@echo off
chcp 65001 >nul
title GMSS - Publicando no GitHub...
color 0A

echo.
echo ============================================
echo   GMSS - Publicando no GitHub Pages
echo ============================================
echo.

set TOKEN=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
set USERNAME=Marcofilho29
set REPO=gmss-licitacoes

:: Vai para a pasta onde o .bat esta
cd /d "%~dp0"

echo [1/4] Criando repositorio no GitHub...
echo.

curl -s -X POST https://api.github.com/user/repos ^
  -H "Authorization: token %TOKEN%" ^
  -H "Accept: application/vnd.github.v3+json" ^
  -H "Content-Type: application/json" ^
  -d "{\"name\":\"%REPO%\",\"description\":\"Monitor de Licitacoes GMSS\",\"private\":false,\"auto_init\":false}"

echo.
echo.
echo [2/4] Configurando Git...
echo.

git init
git config user.email "marco.antonio.filho29@gmail.com"
git config user.name "Marcofilho29"
git add .
git commit -m "Monitor de Licitacoes GMSS - versao inicial"

echo.
echo [3/4] Enviando arquivos para o GitHub...
echo.

git branch -M main
git remote remove origin 2>nul
git remote add origin https://%USERNAME%:%TOKEN%@github.com/%USERNAME%/%REPO%.git
git push -u origin main --force

echo.
echo [4/4] Ativando GitHub Pages...
echo.

curl -s -X POST https://api.github.com/repos/%USERNAME%/%REPO%/pages ^
  -H "Authorization: token %TOKEN%" ^
  -H "Accept: application/vnd.github.v3+json" ^
  -H "Content-Type: application/json" ^
  -d "{\"source\":{\"branch\":\"main\",\"path\":\"/\"}}"

echo.
echo.
echo ============================================
echo   CONCLUIDO!
echo ============================================
echo.
echo   Repositorio:
echo   https://github.com/%USERNAME%/%REPO%
echo.
echo   URL do painel (aguarde ~2 min):
echo   https://%USERNAME%.github.io/%REPO%/
echo.
echo   Login do assistente:
echo   Usuario: eder
echo   Senha:   2026
echo.
echo ============================================
echo.
pause
