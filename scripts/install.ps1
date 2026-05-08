$ErrorActionPreference = "Stop"
Write-Host "== EduGestor 360: install =="
node --version
npm --version
flutter --version
npx supabase --version
npm install
Push-Location apps/api
npm install
Pop-Location
Push-Location apps/web_flutter
flutter pub get
Pop-Location
Write-Host "Install completed."
