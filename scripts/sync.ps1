$ErrorActionPreference = "Stop"

if (-not $env:LEAN_BRAIN_PATH) {
    throw "LEAN_BRAIN_PATH no está configurado"
}

$BrainPath = $env:LEAN_BRAIN_PATH

Write-Host "🔄 Sync Lean Brain..." -ForegroundColor Cyan

if (-not (Test-Path "$BrainPath\.git")) {
    throw "No se encontró repo en $BrainPath"
}

Push-Location $BrainPath

git pull | Out-Null

Pop-Location

Write-Host "✅ Sync completado" -ForegroundColor Green