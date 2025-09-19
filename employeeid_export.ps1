
Get-ADUser -SearchBase 'YOUR OU' -Filter * -Properties employeeID, userPrincipalName, DistinguishedName | 

Select-Object Name, userPrincipalName, employeeID, @{Name="OU";Expression={$_.DistinguishedName -replace '^CN=.*?,OU=(.*?),DC=.*$','$1'}} | 

ogv

