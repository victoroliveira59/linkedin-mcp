# 🚀 Instalação Rápida e Novas Funcionalidades (`victoroliveira59/linkedin-mcp` v4.5.0)

Este repositório é a versão evoluída do **LinkedIn MCP Server** mantida por **Victor Oliveira**, trazendo **27 ferramentas** (incluindo leitura de publicações próprias/de terceiros e publicação direta com anexo de imagem).

---

## ✨ O que adicionamos na v4.5.0 (Melhorias Exclusivas)

1. **`get_my_posts`** *(Novo)*:
   - Lista as suas próprias publicações recentes no LinkedIn (`/in/:me/recent-activity/all/`), retornando texto completo, `activityUrn`, link direto (`sourceUrl`), contagem de reações e comentários.
2. **`get_profile_posts`** *(Novo)*:
   - Lista as publicações recentes de qualquer perfil público pelo `username` (ex: `"victor-dev-oliveira"`), ideal para pesquisar conteúdos de recrutadores, tech leads e referências da área.
3. **`create_post_with_media`** *(Novo)*:
   - Publica textos **com imagem anexada** (`image_path` + `text`) direto pelo navegador autenticado do MCP, passando pelo mesmo fluxo seguro de preview (`confirm: false` → `confirm: true`) e controle de budget.
4. **Instaladores Multiplataforma 1-Click (`install.ps1` e `install.sh`)**:
   - Configura tudo automaticamente no **Google Antigravity** (`~/.gemini/config/mcp_config.json`) já com `LINKEDIN_ENABLE_WRITES=true`.

---

## ⚡ 1. Instalar ou Atualizar em Qualquer Máquina (1 Comando)

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

## 🔐 2. Fazer Login na Conta do LinkedIn
Caso esteja em uma máquina nova onde ainda não autenticou:

```powershell
node "$HOME\.gemini\mcp-servers\linkedin\dist\index.js" --login
```

Uma janela do Chrome será aberta. Faça login na sua conta do LinkedIn normalmente. A sessão ficará salva localmente em `~/.linkedin-mcp/profile`.
