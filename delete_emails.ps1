# Define the path to the CSV file containing the email addresses
$csvFilePath = "your csv path"

# Import the list of email addresses from the CSV file
$EmailAddresses = Import-Csv -Path $csvFilePath

# Loop through each email address in the list
foreach ($Email in $EmailAddresses.EmailAddress) {
    try {
        # Get the mailbox for the current email address, stop if not found
        $Mailbox = Get-Mailbox -Identity $Email -ErrorAction Stop

        # Remove the mailbox for the current email address without confirmation
        Remove-Mailbox -Identity $Mailbox -Confirm:$False
        Write-Host "Mailbox for '$Email' has been removed."
    } catch {
        # Output an error message if the mailbox is not found
        Write-Host "Mailbox for '$Email' not found in Exchange."
    }
}
