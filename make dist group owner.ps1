# Define the target OU for groups
$OU = "YOUR OU

# Define the new owner's UPN
$newOwnerUPN = "userprinciplename"

# Get the AD user object based on UPN
$newOwner = Get-ADUser -Filter {UserPrincipalName -eq $newOwnerUPN}

if ($newOwner) {
    # Get all distribution groups in the specified OU
    $groups = Get-ADGroup -SearchBase $OU -Filter {GroupCategory -eq "Distribution"}

    foreach ($group in $groups) {
        try {
            # Set the ManagedBy attribute to the new owner
            Set-ADGroup -Identity $group.DistinguishedName -ManagedBy $newOwner.DistinguishedName

            Write-Host "Updated owner for group: $($group.Name)"
        }
        catch {
            Write-Host "Failed to update group: $($group.Name) — $_"
        }
    }
} else {
    Write-Host "Owner not found: $newOwnerUPN"
}
