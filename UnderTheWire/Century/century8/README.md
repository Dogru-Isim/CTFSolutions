# The password for Century9 is the number of unique entries within the file on the desktop.

To do this:
 1. We need to get the contents of the file on the desktop, `type file.txt`
 2. Find the unique ones `sort -uniq`
 3. Get their amount `foreach { $int += 1 }
 4. Pipe these altogether

From previous reading (century 3), I know that `sort` can find unique items: `-uniq`
```powershell
  PS> $int = 0
  PS> 
  PS> type unique.txt | sort -uniq | foreach { $int += 1 }
  PS> echo $int
```

Found: 696
