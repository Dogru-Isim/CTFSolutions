#  The password for Century6 is the short name of the domain in which this
# system resides in PLUS the name of the file on the desktop.

# STEP 1: Finding the domain
  From my understaning, the `Get-Help <argument>` command returns every cmdlet that contains
 the <argument>. So `Get-Help domain` might give us some nice information

 ```powershell
 PS> Get-Help domain

  ...
  Get-ADDefaultDomainPasswordPolicy Cmdlet    ActiveDirectory           Gets the default password policy for an Active Directory domain.  
  Get-ADDomain                      Cmdlet    ActiveDirectory           Gets an Active Directory domain.                                  
  ...
 ```
  Oh, our good friend from AD enumeration Get-AdDomain is here.
 ```powershell
 PS> Get-ADDomain

 ...
 ComputersContainer                 : CN=Computers,DC=underthewire,DC=tech
 ...
 ```

 Result: underthewire
 

# STEP 2: File name

 We all know how to get a filename at this point

 ```powershell
 PS> dir

    Directory: C:\users\century5\desktop              
                                                      
                                                      
  Mode                LastWriteTime         Length Name 
  ----                -------------         ------ ---- 
  -a----        8/30/2018   3:29 AM             54 3347 
 ```

 Result: 3347

Found: underthewire3347
