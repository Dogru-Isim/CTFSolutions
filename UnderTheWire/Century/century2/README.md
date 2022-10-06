# Question:
#  The password for Century3 is the name of the built-in cmdlet
# that performs the wget like function within PowerShell PLUS the
# name of the file on the desktop.

# STEP 1: Get the filename
I know that the cmdlet to display the contents of the current
directory is `dir` This also works for Linux.

```powershell
PS> dir

    Directory: C:\users\century2\desktop             
                                                     
                                                     
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        8/30/2018   3:29 AM            693 443
```

So the files name is `443`


# STEP 2: Find the cmdlet that does the same job as `wget`
 `wget` is actually an alias in PowerShell. To get the actual cmdlet
there is the `Get-Command` cmdlet they presented us in the introduction.
We can assume that it will take a cmdlet as a parameter and give us
information about it.

```powershell
PS> Get-Command wget

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Alias           wget -> Invoke-WebRequest                                           
```

The cmdlet is `Invoke-WebRequest`

Passwords should be lowercase as they previosly said 

Found: invoke-webrequest443
