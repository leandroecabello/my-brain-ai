param(
  [string]$RepoUrl = "https://github.com/leandroecabello/my-brain-ai.git",
  [string]$Branch = "main",
  [switch]$Force,
  [string[]]$Tools
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# =========================
# Config
# =========================

$RepoName = [System.IO.Path]::GetFileNameWithoutExtension($RepoUrl)
$BrainPath = Join-Path $HOME "brain\$RepoName"

# =========================
# Banner
# =========================

function Show-Banner {
    Write-Host ""
    Write-Host "🧠 Lean Brain Installer" -ForegroundColor Cyan
    Write-Host "Configurando agentes y skills..." -ForegroundColor DarkGray
    Write-Host ""
}

Show-Banner

function Write-Step {
    param([string]$Message)
    Write-Host "[install] $Message"
}

# =========================
# Git check
# =========================

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  throw "Git is required. Install Git and retry."
}

# =========================
# Clone / Update
# =========================

if (Test-Path "$BrainPath\.git") {

    Write-Step "Repositorio existente detectado"
    Push-Location $BrainPath

    $currentOrigin = git config --get remote.origin.url

    if ($currentOrigin -ne $RepoUrl) {
        Pop-Location

        if (-not $Force) {
            throw "Repo distinto en $BrainPath. Usar -Force para sobrescribir."
        }

        Write-Step "Eliminando instalación anterior"
        Remove-Item -Recurse -Force $BrainPath
        git clone --branch $Branch $RepoUrl $BrainPath | Out-Null
    }
    else {
        Write-Step "Actualizando repositorio"
        git pull origin $Branch | Out-Null
        Pop-Location
    }

} elseif (Test-Path $BrainPath) {

    if (-not $Force) {
        throw "Carpeta existe pero no es repo git. Usar -Force."
    }

    Remove-Item -Recurse -Force $BrainPath
    git clone --branch $Branch $RepoUrl $BrainPath | Out-Null

} else {

    Write-Step "Clonando brain en $BrainPath"
    git clone --branch $Branch $RepoUrl $BrainPath | Out-Null
}

# =========================
# ENV VAR
# =========================

[System.Environment]::SetEnvironmentVariable("LEAN_BRAIN_PATH", $BrainPath, "User")
$env:LEAN_BRAIN_PATH = $BrainPath

Write-Step "Variable LEAN_BRAIN_PATH configurada"

# =========================
# Tool selection
# =========================

if (-not $Tools) {

    Write-Host ""
    Write-Host "Seleccioná herramientas a configurar:" -ForegroundColor Yellow
    Write-Host "1) Copilot"
    Write-Host "2) Cursor"
    Write-Host "3) Claude"
    Write-Host "4) Ninguna"

    $choice = Read-Host "Opción (ej: 1,2)"

    switch ($choice) {
        "1" { $Tools = @("copilot") }
        "2" { $Tools = @("cursor") }
        "3" { $Tools = @("claude") }
        "1,2" { $Tools = @("copilot","cursor") }
        "1,3" { $Tools = @("copilot","claude") }
        "2,3" { $Tools = @("cursor","claude") }
        "1,2,3" { $Tools = @("copilot","cursor","claude") }
        default { $Tools = @() }
    }
}

# =========================
# Copilot
# =========================

if ($Tools -contains "copilot") {

    $CopilotDir = Join-Path $HOME ".copilot"
    $CopilotFile = Join-Path $CopilotDir "copilot-instructions.md"

    if (-not (Test-Path $CopilotDir)) {
        New-Item -ItemType Directory -Path $CopilotDir | Out-Null
    }

    if (-not (Test-Path $CopilotFile)) {

@"
## Lean Brain

Use agents from:
$BrainPath\agents

Use skills from:
$BrainPath\skills

Default agent: lean-dev
"@ | Out-File -Encoding utf8 $CopilotFile

        Write-Step "Copilot configurado"
    }
    else {
        Write-Step "Copilot ya configurado (no se sobrescribe)"
    }
}

# =========================
# Cursor
# =========================

if ($Tools -contains "cursor") {

    $CursorDir = Join-Path $HOME ".cursor"
    $CursorFile = Join-Path $CursorDir "rules"

    if (-not (Test-Path $CursorDir)) {
        New-Item -ItemType Directory -Path $CursorDir | Out-Null
    }

@"
Use agents from:
$BrainPath\agents

Use skills from:
$BrainPath\skills
"@ | Out-File -Encoding utf8 $CursorFile

    Write-Step "Cursor configurado"
}

# =========================
# Claude
# =========================

if ($Tools -contains "claude") {

    $ClaudeDir = Join-Path $HOME ".claude"

    if (-not (Test-Path $ClaudeDir)) {
        New-Item -ItemType Directory -Path $ClaudeDir | Out-Null
    }

    Write-Step "Claude preparado (folder creado)"
}

# =========================
# Auto-update
# =========================

$TaskName = "LeanBrainUpdate"

$Action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -WindowStyle Hidden -Command `"cd '$BrainPath'; git pull origin $Branch`""

$Trigger = New-ScheduledTaskTrigger -Daily -At 3:00AM
$Trigger.Repetition = (New-TimeSpan -Hours 4)

$Principal = New-ScheduledTaskPrincipal `
    -UserId $env:USERNAME `
    -RunLevel Limited

try {
    if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false | Out-Null
    }

    Register-ScheduledTask `
        -TaskName $TaskName `
        -Action $Action `
        -Trigger $Trigger `
        -Principal $Principal | Out-Null

    Write-Step "Auto-update configurado"

} catch {
    Write-Warning "No se pudo configurar auto-update"
}

# =========================
# Final
# =========================

Write-Host ""
Write-Host "✅ Instalación completada" -ForegroundColor Green
Write-Host "📍 Brain: $BrainPath"
Write-Host "🔄 Sync automático activo"
Write-Host ""
Write-Host "👉 Reiniciá VS Code / terminal"
Write-Host ""