# Configuration de l'encodage et des couleurs
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Alias utiles pour la navigation
Set-Alias ll Get-ChildItem
Set-Alias g git
Set-Alias which Get-Command

# Fonction pour remonter d'un niveau dans l'arborescence
function .. { Set-Location .. }

# Fonction pour afficher l'arborescence du dossier courant
function tree { Get-ChildItem -Recurse | Where-Object { $_.PSIsContainer } | Select-Object FullName }

# Fonction pour créer et accéder à un dossier
function mkcd($path) {
    New-Item -Path $path -ItemType Directory -ErrorAction SilentlyContinue
    Set-Location $path
}

# Fonction pour afficher la version de Node.js
function nv { node -v }

# Fonction pour lister les branches Git
function gb { git branch }

# Fonction pour afficher le statut Git
function gs { git status }

# Personnalisation de l'invite de commande avec infos Git
function prompt {
    $location = Get-Location
    $host.UI.RawUI.WindowTitle = $location
    $gitBranch = ""
    
    # Vérifier si on est dans un repo Git
    if (Test-Path .git) {
        $gitBranch = " [$(git branch --show-current)]"
    }
    
    Write-Host "PS " -NoNewline
    Write-Host "$location" -NoNewline -ForegroundColor Blue
    Write-Host "$gitBranch" -NoNewline -ForegroundColor Green
    return "> "
}

# Message de bienvenue avec infos système
$nodeVersion = if (Get-Command node -ErrorAction SilentlyContinue) { node -v } else { "non installé" }
$npmVersion = if (Get-Command npm -ErrorAction SilentlyContinue) { npm -v } else { "non installé" }
$gitVersion = if (Get-Command git -ErrorAction SilentlyContinue) { git --version } else { "non installé" }

Write-Host "=== Profil PowerShell actif ===" -ForegroundColor Green
Write-Host "Node.js : $nodeVersion" -ForegroundColor Yellow
Write-Host "npm     : $npmVersion" -ForegroundColor Yellow
Write-Host "Git     : $gitVersion" -ForegroundColor Yellow
Write-Host "Encodage: UTF-8" -ForegroundColor Yellow
Write-Host "Tapez 'help' pour voir les commandes disponibles" -ForegroundColor Cyan

# Fonction d'aide
function help {
    Write-Host "`nCommandes disponibles:" -ForegroundColor Cyan
    Write-Host "  ll    -> Lister les fichiers (alias de Get-ChildItem)"
    Write-Host "  ..    -> Remonter d'un niveau"
    Write-Host "  mkcd  -> Créer un dossier et y accéder"
    Write-Host "  tree  -> Afficher l'arborescence"
    Write-Host "  nv    -> Version de Node.js"
    Write-Host "  g     -> Alias de git"
    Write-Host "  gs    -> Git status"
    Write-Host "  gb    -> Git branch"
    Write-Host "`nPour plus d'informations sur une commande: Get-Help <commande>"
}