# 🚀 Instalação Rápida em Qualquer Máquina (`victoroliveira59/linkedin-mcp`)

Este guia mostra como instalar e configurar o **LinkedIn MCP Server** em qualquer computador (Windows, Linux ou macOS) no **Google Antigravity**, **Cursor**, **Claude Desktop** ou **VS Code**.

---

## ⚡ 1. Instalação com 1 Comando

### 🪟 Windows (PowerShell)
Abra o PowerShell e rode:
```powershell
irm https://raw.githubusercontent.com/victoroliveira59/linkedin-mcp/main/install.ps1 | iex
```

### 🐧 Linux / 🍎 macOS (Bash/Zsh)
Abra o terminal e rode:
```bash
curl -fsSL https://raw.githubusercontent.com/victoroliveira59/linkedin-mcp/main/install.sh | bash
```

---

## 🛠️ O que o instalador faz automaticamente?
1. Clona este repositório em `~/.gemini/mcp-servers/linkedin`.
2. Instala as dependências (`npm install`) e gera a build de produção (`npm run build`).
3. Instala o navegador stealth do Patchright (`npm run setup:browser`).
4. Registra o servidor `linkedin` automaticamente dentro de `~/.gemini/config/mcp_config.json` sem apagar seus outros MCPs (`context7`, `github`, etc.).
5. Pergunta se você já deseja abrir o navegador para fazer o login inicial (`npm run login`).

---

## 🔐 2. Fazer Login na Conta do LinkedIn
Caso não tenha feito durante a instalação, basta rodar:

```bash
node ~/.gemini/mcp-servers/linkedin/dist/index.js --login
```
*(No Windows: `node "$HOME\.gemini\mcp-servers\linkedin\dist\index.js" --login`)*

Uma janela do Chrome será aberta. Faça login na sua conta do LinkedIn normalmente. A sessão ficará salva localmente em `~/.linkedin-mcp/profile`.

---

## ⚙️ 3. Configuração Manual do `mcp_config.json` (Opcional)

Se preferir adicionar manualmente no seu `~/.gemini/config/mcp_config.json`:

```json
{
  "mcpServers": {
    "linkedin": {
      "command": "node",
      "args": ["C:\\Users\\SEU_USUARIO\\.gemini\\mcp-servers\\linkedin\\dist\\index.js"],
      "env": {
        "TRANSPORT": "stdio",
        "LOG_LEVEL": "info",
        "LINKEDIN_ENABLE_WRITES": "true"
      }
    }
  }
}
```
