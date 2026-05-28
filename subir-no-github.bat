@echo off
echo ============================================
echo   GMSS - Publicar no GitHub
echo ============================================
echo.

set /p GITHUB_USER=Digite seu usuario do GitHub:
set /p REPO_NAME=Nome do repositorio (ex: gmss-licitacoes):

echo.
echo Inicializando repositorio Git...
git init
git add .
git commit -m "Monitor de Licitacoes GMSS - versao inicial"
git branch -M main

echo.
echo Conectando ao GitHub...
git remote add origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git
git push -u origin main

echo.
echo ============================================
echo  PRONTO! Acesse em alguns minutos:
echo  https://%GITHUB_USER%.github.io/%REPO_NAME%/
echo ============================================
echo.
echo Lembre-se de ativar o GitHub Pages em:
echo Settings -^> Pages -^> Deploy from branch main
echo.
pause
