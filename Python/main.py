import sys
import os
from PySide6.QtWidgets import QApplication

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

    # Cargar y aplicar el stylesheet
    # La ruta se construye relativa a este script
    style_path = os.path.join(os.path.dirname(__file__), 'presentation', 'styles', 'material.qss')
    style_sheet = load_stylesheet(style_path)
    app.setStyleSheet(style_sheet)

    # Crear y mostrar la ventana principal
    window = MainWindow()
    window.show()

    # Ejecutar el bucle de eventos de la aplicación
    sys.exit(app.exec())