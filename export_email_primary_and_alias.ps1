# Get all mailboxes in the specified Organizational Unit (OU) with unlimited result size
Get-Mailbox -ResultSize Unlimited -OrganizationalUnit "Your OU" |

# Select the DisplayName, PrimarySmtpAddress, and a custom property for AliasSmtpAddresses
Select-Object DisplayName,PrimarySmtpAddress, @{
    Name="AliasSmtpAddresses";
    Expression={
        # Filter email addresses to include only those starting with "smtp:", remove "smtp:" prefix, and join them with commas
        ($_.EmailAddresses | Where-Object {$_ -clike "smtp:*"} | ForEach-Object {$_ -replace "smtp:",""}) -join ","
    }
} |

# Export the results to a CSV file with UTF-8 encoding
Export-csv -Path "your csv path" -Encoding utf8
