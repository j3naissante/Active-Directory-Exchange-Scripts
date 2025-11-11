# Path to TXT file 
$UserListPath = "users.txt"

# OU Path
$TargetOU = "Your OU"

# File check
if (-not (Test-Path $UserListPath)) {
    Write-Host "User list not found at $UserListPath" -ForegroundColor Red
    exit
}

# Read users from file
$UserUPNs = Get-Content -Path $UserListPath | Where-Object { $_.Trim() -ne "" }

Write-Host "Found $($UserUPNs.Count) users in the list" -ForegroundColor Cyan

foreach ($UPN in $UserUPNs) {
    try {
        # Find user
        $User = Get-ADUser -Filter {UserPrincipleName -eq UPN}

        if ($User){
            Write-Host "Moving user: $UPN" -ForegroundColor Blue
            Move-ADObject -Identity $User.DistinguishedName -TargetPath $TargetOU
            Write-Host "Successfully moved: $UPN" -ForegroundColor Green
        } else {
            Write-Host "User not found in AD: $UPN" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Error moving $UPN: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "All users moved" -ForegroundColor Cyan