@echo off
chcp 65001 >nul
title GMSS - Deploy Final
color 0A

set "DEST=%USERPROFILE%\Desktop\gmss-licitacoes"
echo Preparando pasta: %DEST%
if not exist "%DEST%" mkdir "%DEST%"

:: Copia apenas index.html e README para a pasta de deploy
copy /y "%~dp0index.html" "%DEST%\index.html" >nul
copy /y "%~dp0README.md"  "%DEST%\README.md"  >nul

:: Cria .gitignore para garantir que scripts nao sejam enviados
echo *.bat>  "%DEST%\.gitignore"
echo *.ps1>> "%DEST%\.gitignore"
echo resultado.txt>> "%DEST%\.gitignore"

cd /d "%DEST%"

echo Arquivos a enviar:
dir /b
echo.

:: Remove .git antigo e reinicia
if exist ".git" rmdir /s /q ".git"

git init
git config user.email "marco.antonio.filho29@gmail.com"
git config user.name  "Marcofilho29"

:: Adiciona SOMENTE index.html e README — nenhum bat vai junto
git add index.html README.md .gitignore
git commit -m "Monitor de Licitacoes GMSS"
git branch -M main
git remote add origin https://Marcofilho29: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@github.com/Marcofilho29/gmss-licitacoes.git
git push -u origin main --force

echo.
if errorlevel 1 (
    color 0C
    echo ERRO no push. Veja mensagem acima.
) else (
    color 0A
    echo ============================================
    echo   SUCESSO! Painel publicado no GitHub.
    echo ============================================
    echo.
    echo  Agora ative o GitHub Pages:
    echo  1. Acesse: https://github.com/Marcofilho29/gmss-licitacoes/settings/pages
    echo  2. Source: Deploy from a branch
    echo  3. Branch: main / (root) - Save
    echo.
    echo  URL do painel em ~2 min:
    echo  https://Marcofilho29.github.io/gmss-licitacoes/
    echo.
    echo  Login: eder / 2026
    echo ============================================
)
echo.
pause
