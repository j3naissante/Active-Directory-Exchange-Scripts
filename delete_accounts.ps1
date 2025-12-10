# Path to the TXT file containing UPNs
$txtFilePath = ""

# Import UPN list
$userLogons = Get-Content -Path $txtFilePath

foreach ($logon in $userLogons) {

    # Query AD user anywhere in the domain by UPN
    $user = Get-ADUser -Filter "UserPrincipalName -eq '$logon'" -SearchBase (Get-ADDomain).DistinguishedName -SearchScope Subtree

    if ($user) {
        Write-Host "Deleting user: $logon ($($user.DistinguishedName))"
        Remove-ADUser -Identity $user.DistinguishedName -Confirm:$false
    }
    else {
        Write-Host "User not found: $logon"
    }
}
