# Define the target OU
$OU = "YOUR OU"

# Define the new owners
$newOwnerUPNs = @("admin@domain.com", "user@admin.com")

# Define group exceptions by name
$excludedGroups = @(
    "secret group"
)

# Get all distribution groups in the specified OU
$groups = Get-DistributionGroup -OrganizationalUnit $OU

foreach ($group in $groups) {
    if ($excludedGroups -contains $group.Name) {
        Write-Host "Skipping excluded group: $($group.Name)"
        continue
    }

    try {
        # Set multiple owners at once
        Set-DistributionGroup -Identity $group.Identity -ManagedBy $newOwnerUPNs -BypassSecurityGroupManagerCheck

        Write-Host "Updated owners for group: $($group.Name) to $($newOwnerUPNs -join ', ')"
    }
    catch {
        Write-Host "Failed to update group: $($group.Name) — $_"
    }
}
