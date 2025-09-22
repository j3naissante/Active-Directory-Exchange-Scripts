
# CSV
#userPrincipalName,Password
# email,password
# email1,password1


# Path to your CSV file
$csvPath = "yourpath"

# Import CSV
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    try {
        $upn = $user.userPrincipalName
        $newPassword = $user.Password

        # Get the AD user by UPN
        $adUser = Get-ADUser -Filter {UserPrincipalName -eq $upn}

        if ($adUser) {
            $securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            Set-ADAccountPassword -Identity $adUser.DistinguishedName -NewPassword $securePassword
            Set-ADUser -Identity $adUser.DistinguishedName -ChangePasswordAtLogon $true

            Write-Host "Password updated for $upn"
        } else {
            Write-Host "User not found: $upn"
        }
    } catch {
        Write-Host "Error updating password for $($user.userPrincipalName): $($_.Exception.Message)"
    }
}
