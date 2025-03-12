

# Replace 'GroupName' with the name of your distribution group
$GroupName = "Your Group Name"

# Get group members
$members = Get-DistributionGroupMember -Identity $GroupName

# Display the name and email address of each member in a grid view
$members | Select-Object DisplayName, PrimarySmtpAddress | Out-GridView
