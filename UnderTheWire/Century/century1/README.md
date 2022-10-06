```explanation
 After utilizing the Get-Help cmdlet the site presented
in the introduction, (Get-Help build) we are prompted with
a Get-Host cmdlet. Thinking that it might give us relative 
information about the host, we run it.
```

```powershell
PS > Get-Help build

Name                              Category  Module                    Synopsis                                                                                               
----                              --------  ------                    --------                                                                                               
New-PSSessionOption               Cmdlet    Microsoft.PowerShell.Core Creates an object that contains advanced options for a PSSession.                                      
Get-Host                          Cmdlet    Microsoft.PowerShell.U... Gets an object that represents the current host program.                                               
Import-LocalizedData              Cmdlet    Microsoft.PowerShell.U... Imports language-specific data into scripts and functions based on the UI culture that is selected ... 
...

PS > Get-Host


Name             : ConsoleHost                                                         
Version          : 5.1.14393.5127                                                      
InstanceId       : e20f7069-1d76-477a-b42f-79b369dfb1a7                                
UI               : System.Management.Automation.Internal.Host.InternalHostUserInterface
CurrentCulture   : en-US                                                               
CurrentUICulture : en-US                                                               
PrivateData      : Microsoft.PowerShell.ConsoleHost+ConsoleColorProxy                  
DebuggerEnabled  : True                                                                
IsRunspacePushed : False                                                               
Runspace         : System.Management.Automation.Runspaces.LocalRunspace                
```

```explanation
But that version doesn't match with the pattern `(**.*.*****.****)`

 After trying some other cmdlets from `Get-Help build` and failing,
I tried `Get-Help powershell` and `Get-Help version` but I couldn't
find anything and decided to use the internet (mission failed?) And hey,
there is a variable called `$PSVersionTable` that is read-only and has
information about PowerShell.
```

```powershell
PS > echo $PSVersionTable

Name                           Value                   
----                           -----                   
PSVersion                      5.1.14393.5127          
PSEdition                      Desktop                 
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...} 
***BuildVersion                   10.0.14393.5127          
CLRVersion                     4.0.30319.42000         
WSManStackVersion              3.0                     
PSRemotingProtocolVersion      2.3                     
SerializationVersion           1.1.0.1                 
```

Found: 10.0.14393.5127
