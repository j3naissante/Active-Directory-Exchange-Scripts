# Define the mailbox
$postkast = ""

# Retrieve the last 10 emails received in the past 7 days
$sonumid = Get-MessageTrackingLog -Recipients $postkast -EventId "Receive" -Start (Get-Date).AddDays(-7) |
           Sort-Object Timestamp -Descending | 
           Select-Object -First 10

# Check if any emails were received
if ($null -eq $sonumid -or $sonumid.Count -eq 0) {
    Write-Host "No emails have been received in the last 7 days for '$postkast'." -ForegroundColor Red
} else {
    Write-Host "Displaying the last 10 emails received for '$postkast':" -ForegroundColor Yellow
    foreach ($email in $sonumid) {
        Write-Host "-----------------------------------"
        Write-Host "Subject: $($email.MessageSubject)"
        Write-Host "Sender: $($email.Sender)"
        Write-Host "Date: $($email.Timestamp)"
        Write-Host "-----------------------------------"
    }
}
