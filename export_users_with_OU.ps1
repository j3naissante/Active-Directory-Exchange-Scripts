$OutputPath = "your path"
$Encoding = [System.Text.Encoding]::UTF8

$users = Get-ADUser -Filter * -SearchBase "YOUR OU" -Properties DisplayName, DistinguishedName

# Create a custom object with DisplayName and OU
$export = $users | Select-Object @{
    Name = 'DisplayName'; Expression = { $_.DisplayName }
}, @{
    Name = 'OU'; Expression = {
        ($_.DistinguishedName -split '(?<!\\),')[1] -replace '^OU='
    }
}

# Export to CSV
$export | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8