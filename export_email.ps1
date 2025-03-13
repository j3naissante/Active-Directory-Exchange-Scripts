# Define the OU
$OU = ""

# Get users from the specified OU
$users = Get-ADUser -Filter * -SearchBase $OU -Properties EmailAddress

# Display the email addresses in a grid view
$users | Select-Object EmailAddress | Out-GridView -Title "User Email Addresses"
