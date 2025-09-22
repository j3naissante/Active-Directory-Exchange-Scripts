$DistributionList = "email"

# List of email addresses to add
$ContactEmails = @(
    "contact@domain.com"
)

foreach ($Email in $ContactEmails) {
    try {
        # Try to find the user in Entra ID
        $User = Get-User -Identity $Email -ErrorAction SilentlyContinue

        if ($User) {
            Add-DistributionGroupMember -Identity $DistributionList -Member $User.Identity -Confirm:$false
            Write-Host "Added Entra user $Email to $DistributionList"
            continue
        }

        # Fallback: Try to find a MailContact
        $Contact = Get-MailContact -Identity $Email -ErrorAction SilentlyContinue

        if ($Contact) {
            Add-DistributionGroupMember -Identity $DistributionList -Member $Contact.Identity -Confirm:$false
            Write-Host "Added MailContact $Email to $DistributionList"
            continue
        }

        Write-Warning "No matching user or contact found for $Email"

    } catch {
        Write-Warning "Error processing ${Email}: $_"
    }
}