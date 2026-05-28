@echo off
chcp 65001 >nul
title GMSS - Enviando arquivos...
color 0A

:: Pasta onde este .bat esta localizado
set "PASTA=%~dp0"
:: Remove barra no final se houver
if "%PASTA:~-1%"=="\" set "PASTA=%PASTA:~0,-1%"

echo.
echo ============================================
echo   GMSS - Enviando arquivos para o GitHub
echo ============================================
echo.
echo Pasta detectada: %PASTA%
echo.

:: Vai para a pasta correta
cd /d "%PASTA%"
echo Diretorio atual: %CD%
echo.

:: Remove .git antigo se existir (para comecar do zero)
if exist ".git" (
    echo Removendo configuracao Git anterior...
    rmdir /s /q ".git"
)

echo [1/3] Inicializando Git...
git init
if errorlevel 1 (
    echo ERRO: Git nao encontrado. Verifique se o Git esta instalado.
    pause
    exit /b 1
)

git config user.email "marco.antonio.filho29@gmail.com"
git config user.name "Marcofilho29"

echo.
echo [2/3] Adicionando arquivos e criando commit...
git add .
git status
git commit -m "Monitor de Licitacoes GMSS - versao inicial com login"
echo.

echo [3/3] Enviando para o GitHub...
git branch -M main
git remote add origin https://Marcofilho29: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@github.com/Marcofilho29/gmss-licitacoes.git
git push -u origin main --force

if errorlevel 1 (
    echo.
    echo ERRO no push. Verifique sua conexao com a internet.
    pause
    exit /b 1
)

echo.
echo ============================================
echo   ARQUIVOS ENVIADOS COM SUCESSO!
echo ============================================
echo.
echo   Agora ative o GitHub Pages manualmente:
echo.
echo   1. Acesse: https://github.com/Marcofilho29/gmss-licitacoes
echo   2. Clique em Settings
echo   3. Clique em Pages (menu lateral esquerdo)
echo   4. Em Source, selecione: Deploy from a branch
echo   5. Em Branch, selecione: main  /  (root)
echo   6. Clique em Save
echo.
echo   Em ~2 min o painel estara em:
echo   https://Marcofilho29.github.io/gmss-licitacoes/
echo.
echo   Login: usuario eder / senha 2026
echo ============================================
echo.
pause
