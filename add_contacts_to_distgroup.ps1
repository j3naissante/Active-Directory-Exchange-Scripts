$DistributionList = "email"

# List of email addresses to add
$ContactEmails = @(
    "contact@domain.com"
)

foreach ($Email in $ContactEmails) {
    try {
        # Search only for on-prem MailContact
        $Contact = Get-MailContact -Identity $Email -ErrorAction SilentlyContinue

        if ($Contact) {
            Add-DistributionGroupMember -Identity $DistributionList -Member $Contact.Identity -Confirm:$false
            Write-Host "Added MailContact $Email to $DistributionList"
        } else {
            Write-Warning "No matching MailContact found for $Email"
        }

    } catch {
        Write-Warning "Error processing ${Email}: $_"
    }
}
