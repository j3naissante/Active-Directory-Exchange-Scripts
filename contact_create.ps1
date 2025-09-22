# Define the target OU
$OU = "YOUR OU"

# Define the list of external email addresses
$emails = @(
    "contact@domain.com"
)

# Create mail contacts using email as Name and Alias
foreach ($email in $emails) {
    New-MailContact -Name $email `
                    -ExternalEmailAddress $email `
                    -OrganizationalUnit $OU `
                    -DisplayName "$email"`
                    -Alias $email.Replace("@", "_").Replace(".", "_")
}