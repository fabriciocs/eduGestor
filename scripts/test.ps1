$ErrorActionPreference = "Stop"
Write-Host "== EduGestor 360: tests =="
Push-Location apps/api
npm run test
npm run test:contract
npm run test:security
Pop-Location
Push-Location apps/web_flutter
flutter test
Pop-Location
Write-Host "Tests completed."
