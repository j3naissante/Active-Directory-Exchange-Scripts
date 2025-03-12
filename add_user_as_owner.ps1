# Define the username to add as the owner
$UserToAdd = "username"

# Define the organizational unit (OU) to search for groups
$OU = "Your OU"

# Define an array of groups to exclude from processing
$ExcludeGroups = @("Excluded groups")  

# Get all distribution groups within the specified OU
$distributionGroups = Get-DistributionGroup -OrganizationalUnit $OU

# Loop through each distribution group
foreach ($group in $distributionGroups) {
    # Skip the group if it's in the exclusion list
    if ($ExcludeGroups -contains $group.Name) {
        Write-Host "Skipping excluded distribution group: $($group.Name)"
        continue
    }

    Write-Host "Processing distribution group: $($group.Name)"

    try {
        # Set the specified user as the owner of the distribution group
        Set-DistributionGroup -Identity $group -ManagedBy @{Add=$UserToAdd}
        Write-Host "Set $UserToAdd as the owner of distribution group $($group.Name)"
    } catch {
        # Output an error message if setting the owner fails
        Write-Host "Failed to set $UserToAdd as the owner of distribution group $($group.Name): $_"
    }
}

# Get all security groups within the specified OU
$securityGroups = Get-ADGroup -SearchBase $OU -Filter {GroupCategory -eq "Security"}

# Loop through each security group
foreach ($group in $securityGroups) {
    # Skip the group if it's in the exclusion list
    if ($ExcludeGroups -contains $group.Name) {
        Write-Host "Skipping excluded security group: $($group.Name)"
        continue
    }

    Write-Host "Processing security group: $($group.Name)"

    try {
        # Set the specified user as the owner of the security group
        Set-ADGroup -Identity $group -ManagedBy $UserToAdd
        Write-Host "Set $UserToAdd as the owner of security group $($group.Name)"
    } catch {
        # Output an error message if setting the owner fails
        Write-Host "Failed to set $UserToAdd as the owner of security group $($group.Name): $_"
    }
}
