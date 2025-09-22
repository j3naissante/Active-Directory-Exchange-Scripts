# Define the target OU and the new value
$OU = "YOUR OU"
$newValue = "new ext1 value"

# Get all users in the specified OU
$users = Get-ADUser -SearchBase $OU -Filter * -Properties extensionAttribute1

# Loop through each user and update extensionAttribute1
foreach ($user in $users) {
    Set-ADUser -Identity $user.DistinguishedName -Replace @{extensionAttribute1 = $newValue}
    Write-Host "Updated ext1 for: $($user.SamAccountName)"
}
