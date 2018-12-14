install-windowsfeatures AD-domain-services
Import-Module ADDSDeployment

Install-ADDSForest
 -CreateDnsDelegation:$false `
 -DatabasePath "C:\Windows\NTDS" `
 -DomainMode "Win2016" `
 -DomainName "mydomain" `
 -DomainNetbiosName "Mydomain" `
 -ForestMode "Win2016" `
 -InstallDns:$true `
 -LogPath "C:\Windows\NTDS" `
 -NoRebootOnCompletion:$false `
 -SysvolPath "C:\Windows\SYSVOL" `
 -Force:$true