# Git Configuration

Este directorio contiene la configuración de Git y scripts para gestionar credenciales.

## Archivos

- `.gitconfig` - Configuración principal de Git
- `connect-github.sh` - Script para conectar GitHub usando Git Credential Manager y Bitwarden
- `setup-git-credentials.sh` - Script alternativo usando credential.helper store

## Uso

### Conectar con GitHub usando Bitwarden

Después de ejecutar el `bootstrap.sh`, conecta tu GitHub:

```bash
# Primero, asegúrate de que Bitwarden esté autenticado y desbloqueado
bw login  # si no estás autenticado
export BW_SESSION=$(bw unlock --raw)

# Luego ejecuta el script de conexión
~/dotfiles/git/connect-github.sh
```

El script:
1. Verifica que Git Credential Manager y Bitwarden CLI estén instalados
2. Recupera tu token de GitHub desde la nota segura "GitHub Access Token" en Bitwarden
3. Configura Git Credential Manager para usar tus credenciales
4. Almacena las credenciales de forma segura

### Requisitos

- Git Credential Manager instalado (`brew install git-credential-manager`)
- Bitwarden CLI instalado (`brew install bitwarden-cli`)
- Una nota segura en Bitwarden llamada "GitHub Access Token" con tu Personal Access Token

### Crear un GitHub Personal Access Token

1. Ve a GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Genera un nuevo token con los permisos necesarios (repo, workflow, etc.)
3. Guarda el token en Bitwarden como una secure note llamada "GitHub Access Token"

## Configuración manual

Si prefieres configurar manualmente:

```bash
# Configurar Git Credential Manager
git config --global credential.helper manager

# O usar el almacén simple (menos seguro)
git config --global credential.helper store
```
