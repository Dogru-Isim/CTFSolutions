#  The password for Century8 is in a readme file somewhere within
# the contacts, desktop, documents, downloads, favorites, music,
# or videos folder in the user’s profile.

 First of all, I don't want to go into every directory and run `dir`. In order
to do that, we need to use recursion.
From previous readings about `dir`, I know that there is a recursion mode: `-r`
and a regex match option `-include`
We can move up to the home directory of century7: `cd ..`

From there, if we do recursive dir, and filter for our readme file:
```powershell
dir -r -include *readme*

    Directory: C:\users\century7\Downloads


Mode                LastWriteTime         Length Name       
----                -------------         ------ ----       
-a----        8/30/2018   3:29 AM              7 Readme.txt 
-a----        2/12/2022   8:59 PM              2 Readme2.txt
```

To read the contents of a file: `type`

```powershell
PS> cd Downloads
PS> type Readme.txt
7points
PS> type Readme2.txt
PS>
```
Readme2 doesn't have anything in it.

Found: 7points
