## Writen by Eric Mereen - 2026
## This is how to install AS/IS/RS Projects using PowerShell
## Please adjust the paths below to match the ones on your system.
## Any questions please email ermereen@microsoft.com or ejmereen@gmail.com

##Visual Studio VSIX Installer Path
$vsixInstaller = "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\VSIXInstaller.exe"

##Path to AS Projects
$vsixPathAS = "C:\Extensions\Microsoft.DataTools.AnalysisServices.vsix"

##Path to RS Projects
$vsixPathRS = "C:\Extensions\Microsoft.DataTools.ReportingServices.vsix"

##Path to IS Projects
$vsixPathIS = "C:\Extensions\Microsoft.DataTools.IntegrationServices.exe"

##Variable for processes to check and close
$blockers = "devenv", "Blend", "MSBuild", "ServiceHub", "VBCSCompiler"

##Run install script silently
## AS
Get-Process | Where-Object { $blockers -contains $_.ProcessName } | ForEach-Object {
    Write-Host "Closing process: $($_.ProcessName)"
    Stop-Process -Id $_.Id -Force
}

Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Installing VSIX: $vsixPathAS" -ForegroundColor Cyan

$procAS = Start-Process -FilePath $vsixInstaller `
                      -ArgumentList @("/quiet", "`"$vsixPathAS`"") `
                      -Wait `
                      -PassThru 

if ($procAS.ExitCode -eq 0) {
    Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] VSIX install completed successfully." -ForegroundColor Green
} 
else {
    Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] VSIX install FAILED. ExitCode: $($procAS.ExitCode)" -ForegroundColor Red
    exit $procAS.ExitCode
}

## RS
Get-Process | Where-Object { $blockers -contains $_.ProcessName } | ForEach-Object {
    Write-Host "Closing process: $($_.ProcessName)"
    Stop-Process -Id $_.Id -Force
}

Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Installing VSIX: $vsixPathRS" -ForegroundColor Cyan

$procRS = Start-Process -FilePath $vsixInstaller `
                      -ArgumentList @("/quiet", "`"$vsixPathRS`"") `
                      -Wait `
                      -PassThru 

if ($procRS.ExitCode -eq 0) {
    Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] VSIX install completed successfully." -ForegroundColor Green
} 
else {
    Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] VSIX install FAILED. ExitCode: $($procRS.ExitCode)" -ForegroundColor Red
    exit $procRS.ExitCode
}

## IS
Get-Process | Where-Object { $blockers -contains $_.ProcessName } | ForEach-Object {
    Write-Host "Closing process: $($_.ProcessName)"
    Stop-Process -Id $_.Id -Force
}

Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Installing EXE: $vsixPathIS" -ForegroundColor Cyan

$procIS = Start-Process -FilePath $vsixPathIS `
                      -ArgumentList @("/quiet") `
                      -Wait `
                      -PassThru 

if ($procIS.ExitCode -eq 0) {
    Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] EXE install completed successfully." -ForegroundColor Green
} 
else {
    Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] EXE install FAILED. ExitCode: $($procIS.ExitCode)" -ForegroundColor Red
    exit $procIS.ExitCode
}
