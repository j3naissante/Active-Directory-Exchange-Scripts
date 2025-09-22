$DistributionList = "DistributionList email"

# List of contact emails to remove
$ContactEmails = @(
    "contactemail",
    "contactemail1"
)

# Remove each contact from the distribution list
foreach ($Email in $ContactEmails) {
    try {
        Remove-DistributionGroupMember -Identity $DistributionList -Member $Email -Confirm:$false
        Write-Host " Removed $Email from $DistributionList"
    } catch {
        Write-Warning " Could not remove ${Email}: $_"

    }
}