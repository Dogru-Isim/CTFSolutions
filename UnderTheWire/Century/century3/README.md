# The password for Century4 is the number of files on the desktop.

Notice: Numbers in the file names are not ordered and most of them are missing

# STEP 1: Looking for an easy win
 Again, there is the dir command we can use to display the files.
But even after reading `Get-Help dir -full`, I couldn't find anything that
would give the number of files (lines)

 So I looked for commands that I could pipe into and get something out of.
`Get-Help sort -full` was my initial idea but no luck. The `sort` command doesn't have
any counting mechanism either. Then I decided to do some PowerShell scripting.
So here it is;


# STEP 2: No easy win, time for scriptin' 
 We need to get the output of `dir` and iterate over it's lines while incrementing
an integer value each time we read a new line. After reading the output of `dir`
is done, we should have the number of files in out integer.

 # STEP 2.1: Planning
 We need 4 things:
   1. An integer type variable, this will be incremented for each line of `dir`. At the end, it will be our solution.
   2. A for loop implementation, this`will take `dir` and for each line, it will increment our integer variable.
   3. A print screen implementation. We need to see the content of our integer variable.


 # STEP 2.2: Finding a solution
   1. Variables in PowerShell has to start with a `$` both in declaration and usage.
      Variable types are not given in declaration.
      So our simple code would be: `$int = 0`

   2. I looked for a `for` loop in PowerShell. The `Get-Help for` command gave me;

     ```output
     ...
     about_For                         HelpFile                            Describes a language command you can use to run statements based on a   
     about_ForEach-Parallel            HelpFile                            Describes the ForEach -Parallel language construct in                   
     about_Foreach                     HelpFile                            Describes a language command you can use to traverse all the items in a 
     ...
     ```
      about_foreach seemed familier from several PowerShell script I came across before.
     and the code was shorter with it.
      
      With the `Get-Help foreach -full` command, we get this example
      ```powershell
       1, 2, $null, 4 | ForEach-Object {"Hello"}
      ```
      So it must be taking each object from stdin and for each of them, running the
     command in the curly braces. Good news, we can pipe our `dir` command and increment the $i

     `dir | foreach {$i += 1}

    3. `echo` is the command to print to screen in PowerShell

  # STEP 2.3: Creating
    ```powershell
    $int = 0
    dir | foreach{ $int += 1}

    echo $int  # 123
    ```

Found: 123

