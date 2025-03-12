# Define the path to the CSV file containing the list of email addresses
$csvFilePath = "path\to\emailList.csv"

# Import the list of email addresses from the CSV file
$emailList = Import-Csv -Path $csvFilePath

# Initialize an array to store the results
$results = @()

# Loop through each email address in the list
foreach ($email in $emailList.EmailAddress) {
    Write-Output "Checking email: $email"
    
    # Check if the mail contact exists for the current email address
    $contact = Get-MailContact -Identity $email -ErrorAction SilentlyContinue
    
    if ($contact) {
        Write-Output "Found: $email"
        $exists = "Exists"
    } else {
        Write-Output "Not found: $email"
        $exists = "Does not exist"
    }
    
    # Add the result to the results array as a custom object
    $results += [PSCustomObject]@{
        EmailAddress = $email
        Status = $exists
    }
}

# Display the results in a grid view
$results | Out-GridView
