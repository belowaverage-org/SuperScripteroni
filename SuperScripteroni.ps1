#Super Scripteroni 1.0 | Dylan Bickerstaff
Start-Transcript -Path "C:\superscripteroni"
$currentLocation = Get-Location
New-EventLog -LogName "Application" -Source "Super Scripteroni" -ErrorAction Ignore
Write-Host "Searching for Scripts..."
$scripts = Get-ChildItem -Path ".\Deploy" -Filter "*.ps1" -Depth 1
foreach($script in $scripts) {
    $script.PSParentPath | Set-Location
    Write-Host "Running $script in $((Get-Item -Path $script.PSParentPath).Name) directory..."
    &$script.PSPath
    $currentLocation | Set-Location
    Write-Host "Done."
}
Stop-Transcript
Write-EventLog -EventId 0 -LogName "Application" -Message (Get-Content -Path "C:\superscripteroni" -Raw) -Source "Super Scripteroni" -EntryType Information
Remove-Item -Path "C:\superscripteroni"
