param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("copilot","cursor","claude")]
    [string]$Tool
)

$BrainPath = $env:LEAN_BRAIN_PATH

if (-not $BrainPath) {
    throw "LEAN_BRAIN_PATH no configurado. Ejecutá install primero."
}

Write-Host "🔧 Configurando $Tool..." -ForegroundColor Cyan

# =========================
# Copilot
# =========================

if ($Tool -eq "copilot") {

    $CopilotDir = Join-Path $HOME ".copilot"
    $CopilotFile = Join-Path $CopilotDir "copilot-instructions.md"

    if (-not (Test-Path $CopilotDir)) {
        New-Item -ItemType Directory -Path $CopilotDir | Out-Null
    }

@"
## Lean Brain

Use agents from:
$BrainPath\agents

Use skills from:
$BrainPath\skills

Default agent: lean-dev
"@ | Out-File -Encoding utf8 $CopilotFile

    Write-Host "✅ Copilot configurado"
}

# =========================
# Cursor
# =========================

if ($Tool -eq "cursor") {

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

    Write-Host "✅ Cursor configurado"
}

# =========================
# Claude
# =========================

if ($Tool -eq "claude") {

    $ClaudeDir = Join-Path $HOME ".claude"

    if (-not (Test-Path $ClaudeDir)) {
        New-Item -ItemType Directory -Path $ClaudeDir | Out-Null
    }

    Write-Host "✅ Claude preparado"
}