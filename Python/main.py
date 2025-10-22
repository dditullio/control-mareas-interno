import sys
import os
from PySide6.QtWidgets import QApplication
from util import resource_path
from infrastructure import config_manager

# Importar la ventana principal desde la capa de presentación
from presentation.main_window import MainWindow

def load_stylesheet(path):
    """Carga un archivo de stylesheet QSS."""
    try:
        with open(path, "r") as f:
            return f.read()
    except FileNotFoundError:
        print(f"Advertencia: No se encontró el archivo de estilos en {path}")
        return ""

if __name__ == "__main__":
    # Crear la aplicación
    app = QApplication(sys.argv)

    # Leer tema preferido desde config (por defecto: light)
    cfg = config_manager.load_config() or {}
    theme = cfg.get('theme', 'light')
    if theme not in ('light', 'dark'):
        theme = 'light'

    # Cargar y aplicar el stylesheet según el tema
    style_rel = f"presentation/styles/{'dark.qss' if theme == 'dark' else 'light.qss'}"
    style_path = resource_path(style_rel)
    style_sheet = load_stylesheet(style_path)
    app.setStyleSheet(style_sheet)

    # Crear y mostrar la ventana principal
    window = MainWindow()
    window.show()

    # Ejecutar el bucle de eventos de la aplicación
    sys.exit(app.exec())
