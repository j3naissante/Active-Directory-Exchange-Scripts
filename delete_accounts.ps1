# Define the organizational unit (OU) to search for users
$OU = ""

# Define the path to the CSV file containing the list of user logons
$csvFilePath = "your csv path"

# Import the list of user logons from the CSV file
$userLogons = Import-Csv -Path $csvFilePath

# Loop through each user logon in the list
foreach ($logon in $userLogons.UserLogon) {

    # Get the user object from Active Directory based on the UserPrincipalName
    $user = Get-ADUser -Filter {UserPrincipalName -eq $logon} -SearchBase $OU
    
    if ($user) {
        # Remove the user from Active Directory without confirmation
        Remove-ADUser -Identity $user -Confirm:$false
        Write-Host "Deleted user: $logon"
    } else {
        Write-Host "User not found: $logon"
    }
}
