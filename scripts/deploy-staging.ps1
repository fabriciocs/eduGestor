$ErrorActionPreference = "Stop"
Write-Host "== EduGestor 360: deploy staging =="
if ($env:APP_ENV -ne "staging") {
  throw "APP_ENV must be staging."
}
.\scripts\validate.ps1
npx supabase db push
Write-Host "Provider-specific backend/frontend deployment is pending provider selection."
