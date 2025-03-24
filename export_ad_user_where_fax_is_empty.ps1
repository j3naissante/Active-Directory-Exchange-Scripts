# Get all AD users from the specified Organizational Unit (OU) whose fax property is empty
Get-ADUser -SearchBase 'YOUR OU' -Filter {Fax -notlike "*"} -Properties Fax, userPrincipalName | 

# Select specific properties to display
Select-Object -Property Name, userPrincipalName, Fax | 

# Output the result to an Out-GridView window for easy viewing
Out-GridView
