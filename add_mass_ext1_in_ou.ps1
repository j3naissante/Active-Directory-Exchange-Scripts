# Path to the TXT file containing UPNs (one per line)
$UserList = "C:\path\to\userlist.txt"

# New value for extensionAttribute1
$newValue = "new ext1 value"

# Read each UPN from file
$UPNs = Get-Content -Path $UserList

foreach ($upn in $UPNs) {

    # Attempt to get the user
    $user = Get-ADUser -Filter "UserPrincipalName -eq '$upn'" -Properties extensionAttribute1

    if ($user) {
        # Update extensionAttribute1
        Set-ADUser -Identity $user.DistinguishedName -Replace @{extensionAttribute1 = $newValue}
        Write-Host "Updated ext1 for: $($user.UserPrincipalName)"
    }
    else {
        Write-Warning "User not found: $upn"
    }
}
