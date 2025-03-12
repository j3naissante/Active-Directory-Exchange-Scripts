# Define the parent Organizational Unit (OU) you want to search in Active Directory
$parentOU = "Your OU"

# Retrieve all sub-OUs within the specified parent OU
$subOUs = Get-ADOrganizationalUnit -Filter * -SearchBase $parentOU

# Loop through each sub-OU found
foreach ($subOU in $subOUs) {

    # Store the name of the current sub-OU
    $OUName = $subOU.Name

    # Retrieve users within the current sub-OU, including their DisplayName and EmailAddress properties
    $Members = Get-ADUser -Filter * -SearchBase $subOU.DistinguishedName -Properties DisplayName, EmailAddress

    # Select only the DisplayName and EmailAddress properties from the retrieved users
    $MemberList = $Members | Select-Object DisplayName, EmailAddress

    # Export the selected user information to a CSV file at the specified path
    $MemberList | Export-Csv -Path "Your path" -NoTypeInformation
}
