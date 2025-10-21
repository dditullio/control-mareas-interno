import os
import sys
import json
import pytest

# Añadir el directorio raíz del proyecto de Python al path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from infrastructure import config_manager

@pytest.fixture
def mock_config_file(tmp_path):
    """Crea un archivo de configuración temporal."""
    config_path = tmp_path / "config.json"
    original_get_config_path = config_manager.get_config_path
    config_manager.get_config_path = lambda: str(config_path)
    yield str(config_path)
    config_manager.get_config_path = original_get_config_path

def test_save_and_load_valid_config(mock_config_file):
    """Test: Guardar y cargar una configuración válida."""
    data_to_save = {'key': 'value', 'number': 123}
    config_manager.save_config(data_to_save)
    
    loaded_data = config_manager.load_config()
    assert loaded_data == data_to_save

def test_load_non_existent_config(tmp_path):
    """Test: Cargar un archivo de configuración que no existe."""
    # Asegurarse de que el archivo no existe
    config_path = tmp_path / "non_existent_config.json"
    original_get_config_path = config_manager.get_config_path
    config_manager.get_config_path = lambda: str(config_path)
    
    loaded_data = config_manager.load_config()
    assert loaded_data is None
    
    config_manager.get_config_path = original_get_config_path

def test_load_corrupted_config(mock_config_file):
    """Test: Cargar un archivo JSON corrupto."""
    with open(mock_config_file, "w") as f:
        f.write("this is not json")
    
    loaded_data = config_manager.load_config()
    assert loaded_data is None
