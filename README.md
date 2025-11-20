# Dotfiles

Configuración personal para desarrollo en WSL2 (Ubuntu) con ZSH, Neovim, Wezterm y más.

## 📋 Contenido

- [Instalación](#instalación)
- [Estructura](#estructura)
- [Herramientas Instaladas](#herramientas-instaladas)
- [ZSH](#zsh)
- [Git](#git)
- [Neovim](#neovim)
- [Wezterm](#wezterm)
- [Starship](#starship)
- [WSL](#wsl)

## 🚀 Instalación

```bash
# Clonar el repositorio
git clone https://github.com/F2BEAR/dotfiles.git ~/dotfiles

# Ejecutar el script de bootstrap
cd ~/dotfiles
chmod +x bootsrtap.sh
./bootsrtap.sh
```

### Post-instalación

Después de ejecutar el bootstrap:
1. Reinicia tu terminal o ejecuta: `exec zsh`
2. Para aplicar cambios de Docker: `wsl --shutdown` desde PowerShell

## 📁 Estructura

```
dotfiles/
├── bootsrtap.sh          # Script de instalación principal
├── Makefile              # Configuración de instalación de Wezterm
├── git/                  # Configuración de Git
│   └── .gitconfig        # Config global de Git
├── zsh/                  # Configuración de ZSH
│   └── .zshrc            # Configuración principal de ZSH
├── nvim/                 # Configuración de Neovim
│   └── .config/nvim/     # Config de Neovim con Lazy.nvim
├── wezterm/              # Configuración de Wezterm
│   ├── .wezterm.lua      # Config principal
│   └── sync_wezterm.sh   # Script de sincronización
├── starship/             # Configuración de Starship prompt
│   └── .config/starship.toml
└── wsl/                  # Archivos de sistema WSL
    ├── .wslconfig
    └── sync_wsl.sh       # Script de sincronización
```

## 🛠️ Herramientas Instaladas

### Gestor de Paquetes
- **Homebrew** - Gestor de paquetes para Linux

### Desarrollo
- **Git** con **Git Delta** (mejor diff viewer)
- **Node.js** via **NVM** (Node Version Manager)
- **Go** - Lenguaje de programación
- **Docker** + **Docker Compose** - Contenedorización
- **pnpm** - Gestor de paquetes rápido para Node.js

### CLI Tools
- **zsh** - Shell principal
- **Neovim** - Editor de texto (configurado con LazyVim)
- **bat** - `cat` con syntax highlighting
- **eza** - `ls` moderno con iconos y colores
- **ripgrep** - Búsqueda de texto ultra rápida
- **fd** - `find` alternativo más rápido
- **fzf** - Fuzzy finder interactivo
- **zoxide** - `cd` inteligente con historial
- **thefuck** - Corrector de comandos
- **jq** - Procesador JSON

### ZSH Plugins
- **zsh-autosuggestions** - Sugerencias automáticas
- **zsh-syntax-highlighting** - Resaltado de sintaxis
- **zsh-vi-mode** - Modo Vi en ZSH

### Prompt & Terminal
- **Starship** - Prompt personalizable y rápido
- **Wezterm** - Terminal emulador GPU-acelerado

### Seguridad
- **Bitwarden CLI** - Gestor de contraseñas

### Fonts
- **JetBrains Mono Nerd Font** - Fuente con iconos

## 🐚 ZSH

### Aliases de Sistema

```bash
ls               # eza con colores, iconos y git info
cd               # zoxide (navegación inteligente)
reload-zsh       # Recargar configuración de ZSH
edit-zsh         # Editar .zshrc con nvim
```

### Aliases de Edición

```bash
edit-nvim        # Abrir configuración de Neovim
edit-wezterm     # Editar configuración de Wezterm
```

### Aliases de Git

```bash
gdiff            # Ver diferencias en merge conflicts (ours vs theirs)
gconflict        # Abrir archivos con conflictos en nvim
```

### Bitwarden

```bash
# Funciones
bw-unlock        # Desbloquear vault y exportar BW_SESSION
bw-lock          # Bloquear vault
bw-get <term>    # Obtener contraseña
bw-search <term> # Buscar items

# Aliases
bwu              # bw-unlock
bwl              # bw-lock
bwg              # bw-get
bws              # bw-search
```

### Otros

```bash
fk               # thefuck - corregir último comando
syncwez          # Sincronizar config de Wezterm a Windows
```

### FZF (Fuzzy Finder)

- **Ctrl+T** - Buscar archivos
- **Ctrl+R** - Buscar en historial
- **Alt+C** - Buscar directorios

Integrado con:
- `fd` para búsqueda de archivos
- `bat` para preview de archivos
- `eza` para preview de directorios
- **fzf-git.sh** para operaciones de Git

### Tema

Usa un tema custom basado en Coolnight con colores:
- Foreground: `#CBE0F0`
- Background: `#011628`
- Purple: `#B388FF`
- Blue: `#06BCE4`
- Cyan: `#2CF9ED`

## 🔧 Git

### Configuración

- **Pager**: Delta (mejor visualización de diffs)
- **Editor**: Neovim
- **Default Branch**: main

### Delta Features

- Side-by-side diffs
- Line numbers con colores
- Syntax highlighting
- Navegación con `n` y `N`
- Color scheme personalizado (Coolnight)

## 📝 Neovim

### Configuración Base

- **Plugin Manager**: Lazy.nvim
- **Leader Key**: `<Space>`
- **Distribución**: LazyVim (personalizada)

### Estructura

```
nvim/.config/nvim/
├── init.lua              # Entry point
├── lazy-lock.json        # Lock de versiones de plugins
├── lua/
│   ├── core/             # Configuración core
│   │   ├── options.lua   # Opciones de Vim
│   │   ├── keymaps.lua   # Mapeos de teclas
│   │   └── autocmd.lua   # Autocomandos
│   └── plugins/          # Plugins
│       ├── *.lua         # Plugins individuales
│       └── UI/           # Plugins de interfaz
└── stylua.toml           # Configuración de formatter
```

### Características

- Diagnósticos habilitados con iconos personalizados
- Virtual text para errores y warnings
- Borders redondeados en ventanas flotantes
- LSP configurado
- Autocompletado
- Syntax highlighting avanzado

Para editar la configuración: `edit-nvim` o `cd ~/dotfiles/nvim/.config/nvim/ && nvim`

## 💻 Wezterm

Terminal emulador GPU-acelerado configurado para WSL2.

### Características

- **Color Scheme**: Coolnight (custom)
- **Fuente**: JetBrains Mono, 10pt
- **Opacidad**: 95%
- **Default Program**: WSL Ubuntu

### Keybindings

#### Copy/Paste
- `Ctrl+Y` / `Ctrl+Shift+C` - Copiar
- `Ctrl+V` / `Ctrl+P` - Pegar

#### Panes
- `Ctrl+=` - Split horizontal
- `Ctrl+-` - Split vertical
- `Ctrl+D` - Cerrar pane actual
- `Ctrl+H/J/K/L` - Navegar entre panes

#### Tabs
- `Ctrl+T` - Nueva tab
- `Ctrl+W` - Cerrar tab
- `Alt+1-9` - Cambiar a tab específica

### Sincronización

```bash
syncwez  # Copia .wezterm.lua a Windows user directory
```

## ⭐ Starship

Prompt personalizado con información de:
- Usuario
- Directorio actual (con iconos)
- Branch de Git
- Estado de Git (cambios, commits pendientes)
- Version de Node.js (cuando está en proyecto Node)
- Python/Rust cuando son detectados

### Colores

- Background: `#A277FF` (purple)
- Símbolos personalizados para directorios comunes

## 🐧 WSL

### Configuración

**`.wslconfig`**:
```ini
[wsl2]
memory=8GB
processors=4
swap=2GB
```

### Docker en WSL2

- Docker CE instalado
- Usuario agregado al grupo `docker`
- Variable `WSL_HOST_IP` configurada para networking

### Optimizaciones

- 8GB de memoria RAM asignada
- 4 procesadores
- 2GB de swap
- DNS personalizado

## 🔄 Actualización

```bash
cd ~/dotfiles
git pull
./bootsrtap.sh  # Re-ejecutar para aplicar cambios
```

## 🐛 Troubleshooting

### Docker no funciona
```bash
# Reiniciar WSL
wsl --shutdown  # Desde PowerShell
```

### Bitwarden no puede desbloquear
```bash
bw login
bw unlock
export BW_SESSION=$(bw unlock --raw)
```

### Wezterm no ve las fuentes
```bash
# Reconstruir caché de fuentes
fc-cache -fv ~/.local/share/fonts
```

## 📄 Licencia

Personal dotfiles - Uso libre

## 👤 Autor

**Facundo Carbonel**
- GitHub: [@F2BEAR](https://github.com/F2BEAR)
