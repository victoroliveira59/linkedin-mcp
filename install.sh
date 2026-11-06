#!/usr/bin/env bash
set -euo pipefail

echo "====================================================="
echo "  Instalador LinkedIn MCP - victoroliveira59"
echo "====================================================="

INSTALL_DIR="$HOME/.gemini/mcp-servers/linkedin"
CONFIG_DIR="$HOME/.gemini/config"
CONFIG_FILE="$CONFIG_DIR/mcp_config.json"
REPO_URL="https://github.com/victoroliveira59/linkedin-mcp.git"

# 1. Clonar ou atualizar repositório
if [ -d "$INSTALL_DIR/.git" ]; then
  echo "[1/4] Atualizando repositório em $INSTALL_DIR..."
  git -C "$INSTALL_DIR" pull origin main
else
  echo "[1/4] Clonando repositório em $INSTALL_DIR..."
  mkdir -p "$(dirname "$INSTALL_DIR")"
  git clone "$REPO_URL" "$INSTALL_DIR"
fi

# 2. Instalar dependências e compilar
echo "[2/4] Instalando pacotes NPM e gerando build..."
cd "$INSTALL_DIR"
npm install
npm run build

echo "[3/4] Configurando browser Patchright (Chrome)..."
npm run setup:browser

# 3. Atualizar ~/.gemini/config/mcp_config.json via Node
echo "[4/4] Atualizando $CONFIG_FILE..."
mkdir -p "$CONFIG_DIR"

node -e '
const fs = require("fs");
const path = process.argv[1];
const distIndex = process.argv[2];
let cfg = { mcpServers: {} };
if (fs.existsSync(path)) {
  try { cfg = JSON.parse(fs.readFileSync(path, "utf8")); } catch {}
}
cfg.mcpServers = cfg.mcpServers || {};
cfg.mcpServers.linkedin = {
  command: "node",
  args: [distIndex],
  env: {
    TRANSPORT: "stdio",
    LOG_LEVEL: "info",
    LINKEDIN_ENABLE_WRITES: "true"
  }
};
fs.writeFileSync(path, JSON.stringify(cfg, null, 2) + "\n");
' "$CONFIG_FILE" "$INSTALL_DIR/dist/index.js"

echo ""
echo "✅ Instalação concluída com sucesso!"
echo "Arquivo configurado: $CONFIG_FILE"
echo "Para autenticar sua conta LinkedIn, execute:"
echo "  node \"$INSTALL_DIR/dist/index.js\" --login"
