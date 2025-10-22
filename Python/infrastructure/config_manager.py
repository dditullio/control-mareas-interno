import json
import os
import sys

CONFIG_FILE = "config.json"

def _app_root_path() -> str:
    """Ruta base para lectura/escritura persistente.

    - En ejecutable (PyInstaller): carpeta donde se encuentra el .exe
    - En desarrollo: raíz de la app Python (padre de este paquete)
    """
    if getattr(sys, 'frozen', False):  # Ejecutable PyInstaller
        return os.path.dirname(sys.executable)
    # Desarrollo
    return os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

def _bundled_config_path() -> str:
    """Ruta del config.json empacado dentro del ejecutable (solo lectura)."""
    base = getattr(sys, '_MEIPASS', None)
    if base:
        return os.path.join(base, CONFIG_FILE)
    # En desarrollo, el "bundled" es el mismo que el persistente
    return os.path.join(_app_root_path(), CONFIG_FILE)

def get_config_path():
    """Ruta persistente de config.json (junto al .exe en modo congelado)."""
    return os.path.join(_app_root_path(), CONFIG_FILE)

def save_config(data):
    """Guarda la configuración en un archivo JSON."""
    try:
        config_path = get_config_path()
        # Asegurar carpeta destino
        os.makedirs(os.path.dirname(config_path), exist_ok=True)
        with open(config_path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=4)
    except IOError as e:
        print(f"Error al guardar la configuración: {e}")

def load_config():
    """Carga la configuración desde un archivo JSON."""
    config_path = get_config_path()
    # 1) Preferir config persistente junto al .exe (si existe)
    if os.path.exists(config_path):
        try:
            with open(config_path, "r", encoding="utf-8") as f:
                return json.load(f)
        except (IOError, json.JSONDecodeError) as e:
            print(f"Error al cargar la configuración persistente: {e}")

    # 2) Fallback: leer config empacado (solo lectura) como valores por defecto
    bundled = _bundled_config_path()
    if os.path.exists(bundled):
        try:
            with open(bundled, "r", encoding="utf-8") as f:
                return json.load(f)
        except (IOError, json.JSONDecodeError) as e:
            print(f"Error al cargar la configuración empacada: {e}")

    return None
