$ErrorActionPreference = "Stop"
Write-Host "== EduGestor 360: lint =="
Push-Location apps/api
npm run lint
npm run format:check
Pop-Location
Push-Location apps/web_flutter
dart format --set-exit-if-changed .
flutter analyze
Pop-Location
Write-Host "Lint completed."
