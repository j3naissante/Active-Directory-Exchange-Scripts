# Define the organizational unit where the contacts will be created
$organizationalUnit = "Your OU"

# Define the path to the CSV file containing the contact information
$csvFilePath = "Your CSV Path"

# Import the contact information from the CSV file
$contacts = Import-Csv -Path $csvFilePath

# Loop through each contact in the CSV file and create a new mail contact
foreach ($contact in $contacts) {
    # Create a new mail contact with the specified name and external email address
    New-MailContact -Name $contact.EmailAddress -ExternalEmailAddress $contact.EmailAddress -OrganizationalUnit $organizationalUnit
}

# Output a message indicating that the contacts were created successfully
Write-Host "Contacts created successfully!"

# Define the name of the distribution group to which the contacts will be added
$distributionGroupName = "Your dist group"

# Loop through each contact in the CSV file and add them to the distribution group
foreach ($contact in $contacts) {
    $email = $contact.EmailAddress
    # Output a message indicating that the email is being added to the distribution group
    Write-Output "Adding email: $email to distribution group: $distributionGroupName"
    # Add the contact to the distribution group, suppressing any errors
    Add-DistributionGroupMember -Identity $distributionGroupName -Member $email -ErrorAction SilentlyContinue
}

# Output a message indicating that all specified contacts have been added to the distribution group
Write-Output "All specified contacts have been added to the distribution group."
