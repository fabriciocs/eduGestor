$ErrorActionPreference = "Stop"
Write-Host "== EduGestor 360: build =="
Push-Location apps/api
npm run build
Pop-Location
Push-Location apps/web_flutter
flutter build web --release
Pop-Location
Write-Host "Build completed."
