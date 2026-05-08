$ErrorActionPreference = "Stop"
Write-Host "== EduGestor 360: validate =="
.\scripts\lint.ps1
.\scripts\test.ps1
.\scripts\build.ps1
Write-Host "Validation completed."
