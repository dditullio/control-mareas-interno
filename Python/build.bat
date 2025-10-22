@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM Asegurar ejecución desde la carpeta del script
pushd %~dp0

echo Generando ejecutable con PyInstaller...

REM Preferir PyInstaller del entorno virtual si existe
set "PYI_CMD=pyinstaller"
if exist ".venv\Scripts\pyinstaller.exe" (
    set "PYI_CMD=.venv\Scripts\pyinstaller.exe"
)

%PYI_CMD% --name ControlMareas ^
    --onefile ^
    --windowed ^
    --noconfirm ^
    --add-data "presentation/styles;presentation/styles" ^
    --add-data "data;data" ^
    --add-data "config.json;." ^
    main.py

echo.
if exist "dist\ControlMareas.exe" (
    echo Proceso completado. El ejecutable se encuentra en la carpeta 'dist'.
) else (
    echo Hubo un error al generar el ejecutable.
)

popd
pause

