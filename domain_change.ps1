# Define the old domain and new domain for email addresses
$OldDomain = ""
$NewDomain = ""
# Define the organizational unit (OU) to search for users
$OU = ""

# Get all users within the specified OU
$users = Get-User -OrganizationalUnit $OU

# Loop through each user
foreach ($user in $users) {
    # Get the mailbox for the current user
    $mailbox = Get-Mailbox -Identity $user.SamAccountName

    # Check if the user's primary SMTP address contains the old domain
    if ($mailbox.PrimarySmtpAddress -like "*$OldDomain") {
        $oldEmail = $mailbox.PrimarySmtpAddress.ToString()
        $newEmail = $oldEmail -replace $OldDomain, $NewDomain

        Write-Host "Processing user: $($user.Name)"
        Write-Host "Old Email: $oldEmail"
        Write-Host "New Email: $newEmail"

        try {
            # Disable the email address policy for the user
            Set-Mailbox -Identity $user.SamAccountName -EmailAddressPolicyEnabled $false

            # Set the new primary SMTP address for the user
            Set-Mailbox -Identity $user.SamAccountName -PrimarySmtpAddress $newEmail

            # Add the old email address as an alias
            Set-Mailbox -Identity $user.SamAccountName -EmailAddresses @{Add=$oldEmail}

            Write-Host "Changed $oldEmail to $newEmail and added $oldEmail as an alias"
        } catch {
            # Output an error message if updating the user fails
            Write-Host "Failed to update $($user.Name): $_"
            Write-Host "Error details: $($_.Exception.Message)"
        }
    }
}
