$OU = ""

# Define the path to the TXT file containing the list of user logons
$txtFilePath = ""

# Import the list of user logons from the TXT file
$userLogons = Get-Content -Path $txtFilePath

# Loop through each user logon in the list
foreach ($logon in $userLogons) {


    # Query AD user by UPN inside parent OU (searching sub-OUs too)
    $user = Get-ADUser -Filter "UserPrincipalName -eq '$logon'" -SearchBase $OU -SearchScope Subtree

    if ($user) {
        Write-Host "Deleting user: $logon ($($user.DistinguishedName))"
        Remove-ADObject -Identity $user.DistinguishedName -Recursive -Confirm:$false
    } else {
        Write-Host "User not found in $OU or its sub-OUs: $logon"
    }
}
