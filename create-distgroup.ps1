# Define variables
$GroupName = "test group"
$GroupAlias = "test"
$SMTPAddress = "test@domain.com"
$OrganizationalUnit = "YOUR OU"

# Create the distribution group
New-DistributionGroup -Name $GroupName `
                      -Alias $GroupAlias `
                      -PrimarySmtpAddress $SMTPAddress `
                      -OrganizationalUnit $OrganizationalUnit `
                      -Type Distribution

# Confirm creation
Write-Host "Distribution group '$GroupName' created with SMTP address '$SMTPAddress'"
