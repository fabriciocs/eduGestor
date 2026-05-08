$ErrorActionPreference = "Stop"
Write-Host "== EduGestor 360: setup local =="
if (!(Test-Path ".env")) {
  Copy-Item ".env.example" ".env"
  Write-Host ".env created from .env.example."
}
npx supabase start
npx supabase db reset
Write-Host "Local Supabase ready."
