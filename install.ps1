#Requires -Version 5.1
$ErrorActionPreference = "Stop"

Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "  Instalador LinkedIn MCP - victoroliveira59" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan

$InstallDir = Join-Path $HOME ".gemini\mcp-servers\linkedin"
$ConfigDir  = Join-Path $HOME ".gemini\config"
$ConfigFile = Join-Path $ConfigDir "mcp_config.json"
$RepoUrl    = "https://github.com/victoroliveira59/linkedin-mcp.git"

# 1. Clonar ou atualizar repositório
if (Test-Path (Join-Path $InstallDir ".git")) {
    Write-Host "`n[1/4] Atualizando repositorio existente em $InstallDir..." -ForegroundColor Yellow
    Push-Location $InstallDir
    git pull origin main
    Pop-Location
} else {
    Write-Host "`n[1/4] Clonando repositorio em $InstallDir..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Force -Path (Split-Path $InstallDir) | Out-Null
    git clone $RepoUrl $InstallDir
}

# 2. Instalar dependencias e compilar
Write-Host "`n[2/4] Instalando pacotes NPM e gerando build..." -ForegroundColor Yellow
Push-Location $InstallDir
npm install
npm run build
Write-Host "`n[3/4] Configurando browser Patchright (Chrome)..." -ForegroundColor Yellow
npm run setup:browser
Pop-Location

# 3. Atualizar ~/.gemini/config/mcp_config.json
Write-Host "`n[4/4] Atualizando $ConfigFile..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path $ConfigDir | Out-Null

$DistIndex = Join-Path $InstallDir "dist\index.js"

if (Test-Path $ConfigFile) {
    $ConfigJson = Get-Content $ConfigFile -Raw | ConvertFrom-Json
} else {
    $ConfigJson = [PSCustomObject]@{ mcpServers = [PSCustomObject]@{} }
}

if (-not $ConfigJson.mcpServers) {
    $ConfigJson | Add-Member -MemberType NoteProperty -Name "mcpServers" -Value ([PSCustomObject]@{})
}

$LinkedinServer = [PSCustomObject]@{
    command = "node"
    args    = @($DistIndex)
    env     = [PSCustomObject]@{
        TRANSPORT              = "stdio"
        LOG_LEVEL              = "info"
        LINKEDIN_ENABLE_WRITES = "true"
    }
}

$ConfigJson.mcpServers | Add-Member -MemberType NoteProperty -Name "linkedin" -Value $LinkedinServer -Force
$ConfigJson | ConvertTo-Json -Depth 10 | Set-Content -Path $ConfigFile -Encoding UTF8

Write-Host "`nInstalacao concluida com sucesso!" -ForegroundColor Green
Write-Host "Arquivo configurado: $ConfigFile" -ForegroundColor Green
Write-Host "Para autenticar sua conta LinkedIn, execute:" -ForegroundColor Cyan
Write-Host "  node `"$DistIndex`" --login" -ForegroundColor White
