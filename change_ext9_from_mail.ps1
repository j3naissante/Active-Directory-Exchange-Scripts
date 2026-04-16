

# --- Conf ts ---
$TargetOU = ""
$WhatIf   = $true   # Set to $false to make actual changes
# ----------------------

Import-Module ActiveDirectory

$accounts = Get-ADUser -SearchBase $TargetOU -SearchScope Subtree `
    -Filter * `
    -Properties mail, extensionAttribute9

$total   = $accounts.Count
$updated = 0
$skipped = 0
$noMail  = 0

Write-Host "`nFound $total accounts in OU.`n" -ForegroundColor Cyan

foreach ($user in $accounts) {

    if ([string]::IsNullOrWhiteSpace($user.mail)) {
        Write-Host "SKIP (no mail): $($user.SamAccountName)" -ForegroundColor Yellow
        $noMail++
        continue
    }

    if ($user.extensionAttribute9 -eq $user.mail) {
        Write-Host "SKIP (already set): $($user.SamAccountName) -> $($user.mail)" -ForegroundColor Gray
        $skipped++
        continue
    }

    Write-Host "UPDATE: $($user.SamAccountName)  [$($user.extensionAttribute9)] -> [$($user.mail)]" -ForegroundColor Green

    if (-not $WhatIf) {
        Set-ADUser -Identity $user -Replace @{ extensionAttribute9 = $user.mail }
    }

    $updated++
}

Write-Host "`n--- Summary ---" -ForegroundColor Cyan
Write-Host "Total accounts : $total"
Write-Host "To be updated  : $updated"
Write-Host "Already correct: $skipped"
Write-Host "No mail attr   : $noMail"

if ($WhatIf) {
    Write-Host "`nWhatIf mode ON — no changes were made. Set `$WhatIf = `$false to apply." -ForegroundColor Magenta
}