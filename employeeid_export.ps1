# Get all AD users from the specified Organizational Unit (OU)
Get-ADUser -SearchBase 'YOUR OU' -Filter * -Properties employeeID, userPrincipalName, DistinguishedName | 

# Select specific properties and add a custom property for the OU
Select-Object Name, userPrincipalName, employeeID, @{Name="OU";Expression={$_.DistinguishedName -replace '^CN=.*?,OU=(.*?),DC=.*$','$1'}} | 

# Output the result to an Out-GridView window for easy viewing
ogv
