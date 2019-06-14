#Super Scripteroni 1.1 | Dylan Bickerstaff
New-EventLog -LogName "Application" -Source "Super Scripteroni"
Start-Transcript -Path "C:\SuperScripteroni"
$currentLocation = Get-Location
Write-Host "Searching for Scripts..."
$Packages = (Get-Item ".\Deploy").GetDirectories()
foreach($Package in $Packages) {
    $Scripts = $Package.GetFiles("*.ps1")
    foreach($Script in $Scripts) {
        $Script.Directory | Set-Location
        Write-Host "Running $Script in $((Get-Item -Path $Script.DirectoryName).Name) directory..."
        &$Script.FullName
        $currentLocation | Set-Location
        Write-Host "Done."
    }
}
Stop-Transcript
Write-EventLog -EventId 0 -LogName "Application" -Message (Get-Content -Path "C:\SuperScripteroni" | Out-String) -Source "Super Scripteroni" -EntryType Information
Remove-Item -Path "C:\SuperScripteroni"
