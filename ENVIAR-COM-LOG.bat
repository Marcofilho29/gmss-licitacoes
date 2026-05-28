@echo off
chcp 65001 >nul
set "PASTA=%~dp0"
if "%PASTA:~-1%"=="\" set "PASTA=%PASTA:~0,-1%"
set "LOG=%PASTA%\resultado.txt"

:: Salva tudo no log E mostra na tela
cd /d "%PASTA%"

(
echo ============================================
echo GMSS - Envio para GitHub
echo Data: %date% %time%
echo Pasta: %CD%
echo ============================================
echo.
) > "%LOG%"

call :run 2>&1 | tee -a "%LOG%" 2>nul || call :run >> "%LOG%" 2>&1

echo.
echo Log salvo em: %LOG%
echo Abrindo log...
notepad "%LOG%"
goto :eof

:run
echo [1/3] Removendo .git antigo...
if exist ".git" rmdir /s /q ".git"

echo [2/3] Inicializando Git e adicionando arquivos...
git init
git config user.email "marco.antonio.filho29@gmail.com"
git config user.name "Marcofilho29"
git add index.html README.md
git status
git commit -m "Monitor de Licitacoes GMSS"

echo [3/3] Enviando para GitHub...
git branch -M main
git remote add origin https://Marcofilho29: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@github.com/Marcofilho29/gmss-licitacoes.git
git push -u origin main --force

echo.
echo FIM DO SCRIPT.
echo Resultado do push acima ^^^
goto :eof
