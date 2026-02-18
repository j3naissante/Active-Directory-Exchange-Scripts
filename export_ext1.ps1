$OU = Read-Host "Enter the OU"

$users = Get-ADUser -Filter * -SearchBase $OU -Properties DisplayName, extensionAttribute1

$users | Select-Object DisplayName, extensionAttribute1 | Out-GridView -Title "User Information"
