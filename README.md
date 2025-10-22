# Control de Mareas

Aplicación de escritorio desarrollada en Python con PySide6 para la gestión y procesamiento de datos de mareas, siguiendo las directrices del INIDEP.

## Stack Tecnológico

*   **Lenguaje:** Python 3.9+
*   **Interfaz Gráfica (UI):** PySide6 (Qt for Python)
*   **Manejo de Datos:** Pandas, NumPy, dbf
*   **Testing:** Pytest

---

## Configuración del Entorno de Desarrollo (Windows)

Sigue estos pasos para configurar tu entorno en una nueva máquina.

### 1. Instalar Python

Si no tienes Python instalado, descárgalo desde la web oficial.

1.  Ve a [python.org/downloads/windows/](https://www.python.org/downloads/windows/).
2.  Descarga el instalador recomendado para Windows (versión 3.9 o superior).
3.  Ejecuta el instalador.
4.  **¡Muy importante!** En la primera pantalla del instalador, asegúrate de marcar la casilla que dice **"Add Python to PATH"** o **"Agregar Python al PATH"**.
5.  Completa la instalación con las opciones por defecto.

Para verificar que se instaló correctamente, abre una nueva terminal (CMD o PowerShell) y ejecuta:
```sh
python --version
pip --version
```
Deberías ver las versiones de Python y pip instaladas.

### 2. Clonar el Repositorio

Abre una terminal, navega hasta la carpeta donde deseas guardar el proyecto (ej. `D:\Desarrollo`) y clona el repositorio.

```sh
git clone <URL_DEL_REPOSITORIO>
cd ControlMareas
```

### 3. Crear y Activar un Entorno Virtual

Es una buena práctica aislar las dependencias de cada proyecto. Crearemos un entorno virtual dentro de la carpeta del proyecto.

1.  **Navega a la carpeta `Python`** del proyecto:
    ```sh
    cd Python
    ```

2.  **Crea el entorno virtual** (llamado `.venv`):
    ```sh
    python -m venv .venv
    ```

3.  **Activa el entorno virtual**:
    ```sh
    .venv\Scripts\activate
    ```
    Verás que el nombre del entorno (`(.venv)`) aparece al principio de la línea de comandos, indicando que está activo.

### 4. Instalar Dependencias

Con el entorno virtual activado, instala todas las librerías necesarias usando el archivo `requirements.txt`.

```sh
pip install -r requirements.txt
```

### 5. Ejecutar la Aplicación

Una vez instaladas las dependencias, puedes ejecutar la aplicación desde la carpeta `Python`.

```sh
python main.py
```

¡Listo! La ventana principal de la aplicación "Control de Mareas" debería aparecer en tu pantalla.

---

## Generación de Ejecutable (.exe)

Para distribuir la aplicación como un único archivo ejecutable, utilizamos **PyInstaller**.

### Prerrequisitos

Asegúrate de tener todas las dependencias de desarrollo instaladas:

```sh
pip install -r requirements.txt
```

### Generar el Ejecutable

He preparado un script `build.bat` que simplifica el proceso. Este script se encuentra en la carpeta `Python`.

1.  Abre una terminal y asegúrate de tener tu **entorno virtual activado**.
2.  Navega a la carpeta `Python`:
    ```sh
    cd Python
    ```
3.  Ejecuta el script de compilación:
    ```sh
    build.bat
    ```

PyInstaller creará las carpetas `build` y `dist`. Dentro de `dist`, encontrarás el archivo `ControlMareas.exe` junto con todas las dependencias necesarias.

**Nota:** El script está configurado para crear un ejecutable que incluye los estilos (`.qss`) y otros recursos necesarios.

