
# Define your target OU
$OU = "YOUR OU"

# Get users in the specified OU with the old domain in extensionAttribute9
Get-ADUser -SearchBase $OU -Filter {extensionAttribute9 -like "*@olddomain.com"} -Properties extensionAttribute9 | ForEach-Object {
    $oldEmail = $_.extensionAttribute9
    $newEmail = $oldEmail -replace "@old\domain\.com", "@newdomain.com"

    # Update the attribute
    Set-ADUser $_ -Replace @{extensionAttribute9 = $newEmail}

    Write-Host "Updated $($_.Name): $oldEmail → $newEmail"
}
