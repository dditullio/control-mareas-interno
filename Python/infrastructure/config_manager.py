import json
import os

CONFIG_FILE = "config.json"

def get_config_path():
    """Obtiene la ruta absoluta al archivo de configuración."""
    # Guardar config.json en el directorio padre (la raíz de la app de Python)
    return os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), CONFIG_FILE)

def save_config(data):
    """Guarda la configuración en un archivo JSON."""
    try:
        with open(get_config_path(), "w") as f:
            json.dump(data, f, indent=4)
    except IOError as e:
        print(f"Error al guardar la configuración: {e}")

def load_config():
    """Carga la configuración desde un archivo JSON."""
    config_path = get_config_path()
    if not os.path.exists(config_path):
        return None
    
    try:
        with open(config_path, "r") as f:
            return json.load(f)
    except (IOError, json.JSONDecodeError) as e:
        print(f"Error al cargar la configuración: {e}")
        return None
