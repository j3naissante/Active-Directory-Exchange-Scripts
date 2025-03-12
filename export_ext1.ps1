# Define the Organizational Unit (OU) you want to search in Active Directory
$OU = "Your OU"

# Retrieve users from the specified OU with their DisplayName and extensionAttribute1 properties
$users = Get-ADUser -Filter * -SearchBase $OU -Properties DisplayName, extensionAttribute1

# Select only the DisplayName and extensionAttribute1 properties from the retrieved users
# and display the results in an interactive GridView window with the title "User Information"
$users | Select-Object DisplayName, extensionAttribute1 | Out-GridView -Title "User Information"
