# Define the target OU for groups
$OU = "YOUR OU"

# Define multiple owner UPNs
$ownerUPNs = @(
    "userprinciplename"
)

# Get AD user objects
$owners = foreach ($upn in $ownerUPNs) {
    Get-ADUser -Filter {UserPrincipalName -eq $upn}
}

# Validate owners
$validOwners = $owners | Where-Object { $_ }

if ($validOwners.Count -gt 0) {
    # Get all distribution groups in the specified OU
    $groups = Get-ADGroup -SearchBase $OU -Filter {GroupCategory -eq "Distribution"}

    foreach ($group in $groups) {
        try {
            # Set the primary ManagedBy to the first owner
            Set-ADGroup -Identity $group.DistinguishedName -ManagedBy $validOwners[0].DistinguishedName

            # Store other owners in extensionAttribute1 (comma-separated DNs)
            $additionalOwners = $validOwners[1..($validOwners.Count - 1)] | ForEach-Object { $_.DistinguishedName }
            $ownerString = $additionalOwners -join ","

            Set-ADGroup -Identity $group.DistinguishedName -Add @{extensionAttribute1 = $ownerString}

            Write-Host "Updated owners for group: $($group.Name)"
        }
        catch {
            Write-Host "Failed to update group: $($group.Name) — $_"
        }
    }
} else {
    Write-Host "No valid owners found."
}
