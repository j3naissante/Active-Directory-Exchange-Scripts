# Define the organizational unit
$organizationalUnit = "YOUR OU"

# Define the contact details
$contacts = @(
    @{ EmailAddress = "email@yourdomain.com" },
    @{ EmailAddress = "email2@yourdomain.com" }
)

# Loop through each contact and create it
foreach ($contact in $contacts) {
    New-MailContact -Name $contact.EmailAddress -ExternalEmailAddress $contact.EmailAddress -OrganizationalUnit $organizationalUnit
}

Write-Host "Contacts created successfully!"

# Specify the name of the distribution group
$distributionGroupName = "Your Dist group"

# Loop through each email and add it to the distribution group
foreach ($contact in $contacts) {
    $email = $contact.EmailAddress
    Write-Output "Adding email: $email to distribution group: $distributionGroupName"
    Add-DistributionGroupMember -Identity $distributionGroupName -Member $email -ErrorAction SilentlyContinue
}

Write-Output "All specified contacts have been added to the distribution group."