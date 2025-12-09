# Prompt for the target OU
$OU = Read-Host "Enter the target OU (e.g. OU=Contacts,DC=domain,DC=com)"

# Prompt for email addresses (comma-separated)
$emailInput = Read-Host "Enter external email addresses (comma-separated)"
$emails = $emailInput.Split(",") | ForEach-Object { $_.Trim() }

# Create mail contacts
foreach ($email in $emails) {
    $alias = $email.Replace("@", "_").Replace(".", "_")

    New-MailContact -Name $email `
                    -ExternalEmailAddress $email `
                    -OrganizationalUnit $OU `
                    -DisplayName $email `
                    -Alias $alias
}

Write-Host "Mail contacts created successfully."
