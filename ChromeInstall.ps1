Write-Host "Checking if chrome is already installed..."
if(Get-Item -Path "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe") {
    Write-Host "Chrome is already installed."
} else {
    Write-Host "Chrome is not installed, starting install..."
    Start-Process -FilePath "msiexec.exe" -ArgumentList '/i GoogleChromeStandaloneEnterprise64.msi /quiet' -Wait
    Write-Host "Chrome is now Installed."
}
