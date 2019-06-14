if(Get-Item -Path "C:\Program Files\LAPS\CSE\AdmPwd.dll" -ErrorAction SilentlyContinue) {
    Write-Host "LAPS is already installed."
} else {
    Write-Host "LAPS not installed."
    if([System.Environment]::Is64BitOperatingSystem) {
        Write-Host "Installing 64bit LAPS"
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i LAPS.x64.msi /quiet" -Wait  
    } else {
        Write-Host "Installing 32bit LAPS"
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i LAPS.x86.msi /quiet" -Wait
    }
}
