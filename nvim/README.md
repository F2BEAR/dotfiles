# Neovim Configuration

Configuración personalizada de Neovim basada en Lazy.nvim con plugins modernos y keybindings optimizados.

## 📋 Contenido

- [Instalación](#instalación)
- [Leader Key](#leader-key)
- [Keybindings Generales](#keybindings-generales)
- [Navegación y Búsqueda](#navegación-y-búsqueda)
- [LSP y Autocompletado](#lsp-y-autocompletado)
- [Git](#git)
- [Terminal](#terminal)
- [Buffers y Ventanas](#buffers-y-ventanas)
- [Plugins](#plugins)
- [Opciones Configuradas](#opciones-configuradas)

## 🚀 Instalación

La configuración se instala automáticamente con el script `bootstrap.sh`. Para editarla manualmente:

```bash
edit-nvim  # Abre la configuración en nvim
# O manualmente:
cd ~/dotfiles/nvim/.config/nvim/ && nvim
```

## 🎯 Leader Key

**Leader Key**: `<Space>`

## ⌨️ Keybindings Generales

### Selección y Clipboard

| Tecla | Modo | Acción |
|-------|------|--------|
| `Ctrl+A` | Normal | Seleccionar todo el archivo |
| `y` | Visual | Copiar (usa clipboard del sistema) |
| `p` | Normal/Visual | Pegar desde clipboard |

### Navegación Básica

| Tecla | Modo | Acción |
|-------|------|--------|
| `h/j/k/l` | Normal | Izquierda/Abajo/Arriba/Derecha |
| `w` | Normal | Palabra siguiente |
| `b` | Normal | Palabra anterior |
| `gg` | Normal | Inicio del archivo |
| `G` | Normal | Final del archivo |
| `0` | Normal | Inicio de línea |
| `$` | Normal | Final de línea |

## 🔍 Navegación y Búsqueda

### Neo-tree (File Explorer)

| Tecla | Modo | Acción |
|-------|------|--------|
| `<leader>e` | Normal | Toggle explorador de archivos |

**Dentro de Neo-tree:**
- `a` - Crear archivo/directorio
- `d` - Eliminar archivo/directorio
- `r` - Renombrar
- `y` - Copiar
- `x` - Cortar
- `p` - Pegar
- `R` - Refrescar
- `H` - Toggle archivos ocultos
- `Enter` - Abrir archivo

### Telescope (Fuzzy Finder)

| Tecla | Modo | Acción |
|-------|------|--------|
| `<leader>ff` | Normal | Buscar archivos |
| `<leader>fg` | Normal | Buscar texto en proyecto (live grep) |
| `<leader>fb` | Normal | Buscar en buffers abiertos |
| `<leader>fh` | Normal | Buscar en help tags |

**Dentro de Telescope:**
- `Ctrl+K` - Mover selección arriba
- `Ctrl+J` - Mover selección abajo
- `Ctrl+Q` - Enviar seleccionados a quickfix list
- `Enter` - Abrir archivo
- `Ctrl+X` - Abrir en split horizontal
- `Ctrl+V` - Abrir en split vertical

### FZF-Lua (Alternativa rápida)

| Tecla | Modo | Acción |
|-------|------|--------|
| `<leader>sf` | Normal | Buscar archivos |
| `<leader>s` | Normal | Buscar en proyecto (grep) |
| `<leader>sb` | Normal | Buscar en buffer actual |

## 🧠 LSP y Autocompletado

### LSP Navigation

| Tecla | Modo | Acción |
|-------|------|--------|
| `gd` | Normal | Go to Definition |
| `gD` | Normal | Go to Declaration |
| `gi` | Normal | Go to Implementation |
| `gr` | Normal | Go to References |
| `K` | Normal | Mostrar documentación (hover) |
| `Ctrl+K` | Normal | Mostrar signature help |
| `<leader>rn` | Normal | Renombrar símbolo (LSP) |
| `<leader>r` | Normal | Renombrar palabra (inc-rename) |

### Code Actions

| Tecla | Modo | Acción |
|-------|------|--------|
| `<leader>c` | Normal | Abrir tiny code actions |
| `<leader>dc` | Normal | Cache dependencies (Deno) |

### Deno LSP

El Deno LSP se activa automáticamente cuando:
- Existe un archivo `deno.json` o `deno.jsonc` en la raíz del proyecto
- Estás trabajando en `supabase/functions/` (para Supabase Edge Functions)

Cuando Deno LSP está activo, el TypeScript LSP (vtsls) se desactiva automáticamente para evitar conflictos.

**Comandos manuales:**

| Comando | Acción |
|---------|--------|
| `:DenoEnable` | Activa Deno LSP y desactiva TypeScript LSP |
| `:DenoDisable` | Activa TypeScript LSP y desactiva Deno LSP |
| `:DenoToggle` | Alterna entre ambos |

### Autocompletado (Blink.cmp)

**Preset**: Super-Tab

| Tecla | Modo | Acción |
|-------|------|--------|
| `Tab` | Insert | Siguiente sugerencia / Aceptar |
| `Shift+Tab` | Insert | Sugerencia anterior |
| `Ctrl+Space` | Insert | Abrir menu de autocompletado |
| `Ctrl+E` | Insert | Cerrar menu |

**Sources configuradas:**
- LSP
- Copilot
- Path
- Buffer
- LazyDev (para desarrollo Lua/Neovim)

### Diagnósticos (Trouble)

| Tecla | Modo | Acción |
|-------|------|--------|
| `<leader>td` | Normal | Toggle Trouble (diagnósticos) |

**Dentro de Trouble:**
- `Enter` - Saltar a la ubicación
- `q` - Cerrar
- `o` - Jump y cerrar Trouble

## 🎨 Git

### Gitsigns

**Símbolos en signcolumn:**
- `✚` - Added
- `✖` - Deleted
- `` - Modified
- `󰁕` - Renamed
- `` - Untracked
- `` - Ignored
- `󰄱` - Unstaged
- `` - Staged
- `` - Conflict

### Diffview

| Comando | Acción |
|---------|--------|
| `:DiffviewOpen` | Abrir diff view |
| `:DiffviewClose` | Cerrar diff view |
| `:DiffviewFileHistory` | Ver historial de archivo |

## 💻 Terminal

### ToggleTerm

| Tecla | Modo | Acción |
|-------|------|--------|
| `F4` | Normal/Insert/Terminal | Toggle terminal horizontal |

**Configuración:**
- Tamaño: 15 líneas
- Posición: Horizontal (abajo)
- Auto-insert: Sí
- Cierra con exit: Sí

## 📑 Buffers y Ventanas

### Bufferline

| Tecla | Modo | Acción |
|-------|------|--------|
| `<leader>bd` | Normal | Cerrar buffer actual |
| `<leader>br` | Normal | Cerrar buffers a la derecha |
| `<leader>bl` | Normal | Cerrar buffers a la izquierda |
| `<leader>bo` | Normal | Cerrar todos los otros buffers |

### Ventanas (Windows)

| Tecla | Modo | Acción |
|-------|------|--------|
| `Ctrl+W` `s` | Normal | Split horizontal |
| `Ctrl+W` `v` | Normal | Split vertical |
| `Ctrl+W` `h/j/k/l` | Normal | Navegar entre ventanas |
| `Ctrl+W` `q` | Normal | Cerrar ventana |
| `Ctrl+W` `=` | Normal | Igualar tamaño de ventanas |
| `Ctrl+W` `>/<` | Normal | Aumentar/Reducir ancho |
| `Ctrl+W` `+/-` | Normal | Aumentar/Reducir alto |

### UFO (Code Folding)

| Tecla | Modo | Acción |
|-------|------|--------|
| `zR` | Normal | Expandir todo |
| `zM` | Normal | Colapsar todo |
| `za` | Normal | Alternar fold bajo cursor |
## 🧩 Plugins

### Which-Key

Presiona `<Space>` y espera ~500ms para ver todos los keybindings disponibles.

| Tecla | Modo | Acción |
|-------|------|--------|
| `<leader>?` | Normal | Buscar keybindings |

### NavBuddy

| Tecla | Modo | Acción |
|-------|------|--------|
| `<leader>nb` | Normal | Abrir NavBuddy Breadcrumbs Navigation |

### Mason (LSP/Tools Manager)

| Tecla | Modo | Acción |
|-------|------|--------|
| `<leader>m` | Normal | Abrir Mason |

**LSP Servers instalados:**
- `vtsls` - TypeScript/JavaScript
- `denols` - Deno (alternativa a vtsls)
- `lua_ls` - Lua
- `eslint` - ESLint
- `tailwindcss` - Tailwind CSS
- `prismals` - Prisma
- `jsonls` - JSON
- `yamlls` - YAML
- `marksman` - Markdown
- `dockerls` - Dockerfile
- `docker_compose_language_service` - Docker Compose
- `bashls` - Bash
- `sqls` - SQL

### Lazy (Plugin Manager)

| Tecla | Modo | Acción |
|-------|------|--------|
| `<leader>l` | Normal | Abrir Lazy |

### Noice (UI Mejorado)

| Tecla | Modo | Acción |
|-------|------|--------|
| `<leader>n` | Normal | Abrir Noice Telescope (historial de mensajes) |

### Copilot

GitHub Copilot integrado con Blink.cmp.

- Sugerencias en línea automáticas
- Integrado con autocompletado
- Prioridad alta en sugerencias

### Treesitter

Highlighting y navegación avanzada con contexto.

**Lenguajes instalados:**
- JavaScript/TypeScript/TSX/JSX
- Lua
- JSON/YAML
- HTML/CSS
- Bash
- SQL
- Prisma
- Dockerfile
- Markdown

### Conform (Formatters)

**Formato automático al guardar** (`BufWritePre`)

| Lenguaje | Formatter |
|----------|-----------|
| Lua | stylua |
| JavaScript/TypeScript/React | prettier |
| HTML/CSS | prettier |
| JSON | jq |
| YAML | yamlfmt |
| SQL | sql_formatter |
| Bash | shfmt |

### Markdown Rendering

Renderizado mejorado de Markdown en tiempo real con `render-markdown.nvim`.

### Colorizer

Visualización de colores inline (hex, rgb, etc).

## ⚙️ Opciones Configuradas

### Números de Línea
- `number` - Números de línea absolutos
- `relativenumber` - Números relativos (útil para motion commands)

### Indentación
- `tabstop = 2` - Tabs de 2 espacios
- `shiftwidth = 2` - Indentación de 2 espacios
- `expandtab = true` - Convertir tabs a espacios
- `autoindent = true` - Auto-indentación

### Búsqueda
- `ignorecase = true` - Ignorar mayúsculas en búsqueda
- `smartcase = true` - Case sensitive si se usa mayúsculas

### UI
- `termguicolors = true` - Colores RGB verdaderos
- `signcolumn = yes` - Columna de símbolos siempre visible
- `wrap = false` - No wrap de líneas largas

### Ventanas
- `splitright = true` - Splits verticales a la derecha
- `splitbelow = true` - Splits horizontales abajo

### Sistema
- `clipboard = unnamedplus` - Compartir clipboard con sistema
- `swapfile = false` - Sin archivos swap

## 🎨 Color Scheme

Usa un theme personalizado basado en Coolnight (configurado en `lua/plugins/UI/colorscheme.lua`).

## 📦 Estructura de Archivos

```
nvim/.config/nvim/
├── init.lua                         # Entry point
├── lua/
│   ├── core/
│   │   ├── options.lua              # Opciones de neovim
│   │   ├── keymaps.lua              # Keybindings personalizados
│   │   └── autocmd.lua              # Autocomandos
│   └── plugins/
│       ├── autopairs.lua            # Auto Pairs
│       ├── comment.lua              # Comentarios
│       ├── fzf-lua.lua              # FZF-Lua
│       ├── telescope.lua            # Telescope
│       ├── tiny-code-actions.lua    # Code Actions
│       ├── markdown.lua             # Markdown rendering
│       ├── lsp.lua                  # Configuración LSP
│       ├── treesitter.lua           # Treesitter
│       ├── blink.lua                # Autocompletado
│       ├── copilot.lua              # GitHub Copilot
│       ├── git.lua                  # Gitsigns + Diffview
│       ├── conform.lua              # Formatters
│       ├── trouble.lua              # Diagnósticos
│       ├── mason.lua                # LSP Manager
│       ├── snacks.lua               # Utilidades
│       └── UI/
│           ├── neo-tree.lua         # File explorer
│           ├── bufferline.lua       # Tabs de buffers
│           ├── lualine.lua          # Statusline
│           ├── toggle-term.lua      # Terminal
│           ├── whichkey.lua         # Keybinding helper
│           ├── noice.lua            # UI de mensajes, cmdline y popupmenus mejorado
│           ├── dashboard.lua        # Dashboard
│           ├── blink-indent.lua     # Indent guides
│           ├── breadcrums.lua       # Breadcrumbs
│           ├── ufo.lua              # Code folding
│           ├── colorizer.lua        # Color Highlighter
│           └── colorscheme.lua      # Theme 
└── lazy-lock.json                   # Lock de versiones
```

## 🔧 Personalización

### Agregar nuevo keybinding

Editar `lua/core/keymaps.lua`:

```lua
keymap.set("n", "<leader>x", "<cmd>MiComando<cr>", { desc = "Descripción" })
```

### Agregar nuevo plugin

Crear archivo en `lua/plugins/mi-plugin.lua`:

```lua
return {
  "autor/plugin.nvim",
  event = "VeryLazy",
  opts = {
    -- opciones
  },
}
```

### Modificar opciones

Editar `lua/core/options.lua`:

```lua
opt.mi_opcion = valor
```

## 🐛 Troubleshooting

### LSP no funciona

```vim
:Mason  " Verificar instalación de LSP servers
:LspInfo  " Ver estado de LSP
:checkhealth  " Diagnóstico general
```

### Plugins no se instalan

```vim
:Lazy sync  " Sincronizar plugins
:Lazy clean  " Limpiar plugins no usados
```

### Treesitter no funciona

```vim
:TSUpdate  " Actualizar parsers
:TSInstall <lenguaje>  " Instalar parser específico
```

### Formateo no funciona

```vim
:ConformInfo  " Ver estado de formatters
```

## 🎓 Tips

1. Usa `<leader>` + espera para ver keybindings con Which-Key
2. `:Telescope keymaps` para buscar todos los keybindings
3. `K` sobre una función para ver documentación
4. `gd` para saltar a definición rápidamente
5. `:checkhealth` para diagnosticar problemas
6. `Ctrl+O` / `Ctrl+I` para navegar hacia atrás/adelante en jump list
7. `.` para repetir último comando
8. `u` para undo, `Ctrl+R` para redo
9. `*` para buscar palabra bajo el cursor
10. `%` para saltar entre paréntesis/brackets matching
