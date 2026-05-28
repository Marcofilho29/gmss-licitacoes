@echo off
chcp 65001 >nul
title GMSS - Deploy GitHub
color 0A

echo.
echo ============================================
echo   GMSS - Deploy automatico para GitHub
echo ============================================
echo.

:: Cria pasta de trabalho na area de trabalho
set "DEST=%USERPROFILE%\Desktop\gmss-licitacoes"
echo Criando pasta em: %DEST%
if not exist "%DEST%" mkdir "%DEST%"
cd /d "%DEST%"
echo OK - pasta criada
echo.

:: Gera o index.html usando PowerShell (sem restricao de política)
echo Gerando arquivo index.html...
powershell -ExecutionPolicy Bypass -Command ^
"$html = Get-Content '%~dp0index.html' -Raw -Encoding UTF8 2>$null; if (-not $html) { Write-Host 'AVISO: index.html nao encontrado na pasta de origem, usando copia embutida'; } else { [System.IO.File]::WriteAllText('%DEST%\index.html', $html, [System.Text.Encoding]::UTF8); Write-Host 'index.html copiado com sucesso!' }"

:: Verifica se o index.html existe na pasta destino
if not exist "%DEST%\index.html" (
    echo index.html nao encontrado - criando versao basica...
    powershell -ExecutionPolicy Bypass -Command "$c='<!DOCTYPE html><html lang=pt-BR><head><meta charset=UTF-8><title>Monitor Licitacoes GMSS</title></head><body><h1>Monitor de Licitacoes GMSS</h1><p>Carregando...</p></body></html>'; [IO.File]::WriteAllText('%DEST%\index.html',$c)"
)

:: Cria README
echo # Monitor de Licitacoes GMSS > "%DEST%\README.md"
echo. >> "%DEST%\README.md"
echo Painel de monitoramento nacional de licitacoes na area de saude. >> "%DEST%\README.md"
echo. >> "%DEST%\README.md"
echo ## Acesso >> "%DEST%\README.md"
echo - Usuario: eder >> "%DEST%\README.md"
echo - Senha: 2026 >> "%DEST%\README.md"
echo. >> "%DEST%\README.md"
echo ## URL >> "%DEST%\README.md"
echo https://Marcofilho29.github.io/gmss-licitacoes/ >> "%DEST%\README.md"

echo.
echo Arquivos na pasta:
dir "%DEST%" /b
echo.

:: Git init e commit
echo Configurando Git...
git init
git config user.email "marco.antonio.filho29@gmail.com"
git config user.name "Marcofilho29"
git add .
git commit -m "Monitor de Licitacoes GMSS - deploy inicial"
git branch -M main

echo.
echo Enviando para GitHub...
git remote remove origin 2>nul
git remote add origin https://Marcofilho29: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@github.com/Marcofilho29/gmss-licitacoes.git
git push -u origin main --force

echo.
if errorlevel 1 (
    color 0C
    echo ERRO no envio. Verifique sua internet.
) else (
    color 0A
    echo ============================================
    echo   SUCESSO! Arquivos enviados para GitHub.
    echo ============================================
    echo.
    echo   Repositorio: https://github.com/Marcofilho29/gmss-licitacoes
    echo.
    echo   Agora ative o GitHub Pages:
    echo   1. Abra: https://github.com/Marcofilho29/gmss-licitacoes/settings/pages
    echo   2. Em Source: Deploy from a branch
    echo   3. Branch: main / (root)
    echo   4. Clique Save
    echo.
    echo   URL final do painel (2 min apos salvar):
    echo   https://Marcofilho29.github.io/gmss-licitacoes/
    echo.
    echo   Login do assistente: eder / 2026
)
echo.
echo ============================================
pause
