# ================================================================
#  GMSS - Publicar Monitor de Licitacoes no GitHub
#  Execute este arquivo com duplo clique (ou botao direito -> Executar com PowerShell)
# ================================================================

$TOKEN    = "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"
$USERNAME = "Marcofilho29"
$REPO     = "gmss-licitacoes"

$ErrorActionPreference = "Stop"
$Host.UI.RawUI.WindowTitle = "GMSS - Publicando no GitHub..."

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   GMSS - Publicando no GitHub Pages" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# ---- 1. Criar repositorio via API ----
Write-Host "[1/4] Criando repositorio '$REPO' no GitHub..." -ForegroundColor Yellow

$headers = @{
    Authorization = "token $TOKEN"
    Accept        = "application/vnd.github.v3+json"
}

$body = @{
    name        = $REPO
    description = "Monitor de Licitacoes GMSS - Area de Saude"
    private     = $false
    auto_init   = $false
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "https://api.github.com/user/repos" `
        -Method POST -Headers $headers -Body $body -ContentType "application/json"
    Write-Host "   Repositorio criado: $($response.html_url)" -ForegroundColor Green
} catch {
    $status = $_.Exception.Response.StatusCode.value__
    if ($status -eq 422) {
        Write-Host "   Repositorio ja existe, continuando..." -ForegroundColor DarkYellow
    } else {
        Write-Host "   Erro ao criar repositorio: $_" -ForegroundColor Red
        Read-Host "Pressione Enter para sair"
        exit 1
    }
}

# ---- 2. Inicializar Git ----
Write-Host ""
Write-Host "[2/4] Inicializando Git na pasta local..." -ForegroundColor Yellow

$PASTA = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $PASTA

git init
git config user.email "marco.antonio.filho29@gmail.com"
git config user.name  "Marcofilho29"
git add .
git commit -m "Monitor de Licitacoes GMSS - versao inicial com login Eder"

Write-Host "   Commit criado com sucesso." -ForegroundColor Green

# ---- 3. Push para o GitHub ----
Write-Host ""
Write-Host "[3/4] Enviando arquivos para o GitHub..." -ForegroundColor Yellow

$remoteUrl = "https://${USERNAME}:${TOKEN}@github.com/${USERNAME}/${REPO}.git"

git branch -M main

# Adiciona ou atualiza o remote
$existingRemote = git remote 2>$null
if ($existingRemote -contains "origin") {
    git remote set-url origin $remoteUrl
} else {
    git remote add origin $remoteUrl
}

git push -u origin main --force

Write-Host "   Arquivos enviados com sucesso!" -ForegroundColor Green

# ---- 4. Ativar GitHub Pages ----
Write-Host ""
Write-Host "[4/4] Ativando GitHub Pages..." -ForegroundColor Yellow

$pagesBody = @{
    source = @{
        branch = "main"
        path   = "/"
    }
} | ConvertTo-Json

try {
    Invoke-RestMethod -Uri "https://api.github.com/repos/$USERNAME/$REPO/pages" `
        -Method POST -Headers $headers -Body $pagesBody -ContentType "application/json" | Out-Null
    Write-Host "   GitHub Pages ativado!" -ForegroundColor Green
} catch {
    $status = $_.Exception.Response.StatusCode.value__
    if ($status -eq 409) {
        Write-Host "   GitHub Pages ja estava ativo." -ForegroundColor DarkYellow
    } else {
        Write-Host "   Ative manualmente: Settings -> Pages -> Deploy from branch main" -ForegroundColor DarkYellow
    }
}

# ---- Resultado ----
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  PUBLICADO COM SUCESSO!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Repositorio: https://github.com/$USERNAME/$REPO" -ForegroundColor White
Write-Host ""
Write-Host "  URL do painel (disponivel em ~2 min):" -ForegroundColor White
Write-Host "  https://$USERNAME.github.io/$REPO/" -ForegroundColor Green
Write-Host ""
Write-Host "  Login do assistente:" -ForegroundColor White
Write-Host "  Usuario: eder" -ForegroundColor Cyan
Write-Host "  Senha:   2026" -ForegroundColor Cyan
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Read-Host "Pressione Enter para fechar"
