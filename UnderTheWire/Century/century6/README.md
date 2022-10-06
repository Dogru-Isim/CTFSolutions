# The password for Century7 is the number of folders on the desktop.

 Everything is same as century3. Changing from file to
folder didn't effect us.

```powershell
PS> $int = 0
PS>
PS> dir | foreach { $i += 1 }
PS> echo $int
```

Found: 197
