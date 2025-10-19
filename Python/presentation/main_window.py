
import os
import sys
from PySide6.QtCore import Qt
from PySide6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout, QGridLayout,
    QGroupBox, QLabel, QLineEdit, QComboBox, QPushButton, QListWidget,
    QFormLayout, QListWidgetItem
)

# Ajustar la ruta para importar desde las carpetas de la arquitectura
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from infrastructure.repositories import CatalogRepository
from domain.entities import Especie, Buque, Observador

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Control de Mareas - INIDEP")
        self.setGeometry(100, 100, 800, 600)

        self._setup_ui()
        self._load_catalogs()

    def _setup_ui(self):
        """Configura la interfaz de usuario."""
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        main_layout = QVBoxLayout(central_widget)

        # --- 1. Sección de Datos de Marea (Layout con labels arriba) ---
        datos_group = QGroupBox("Datos Generales de Marea")
        datos_main_layout = QHBoxLayout()

        def create_labeled_widget(label_text, widget):
            v_layout = QVBoxLayout()
            v_layout.setSpacing(2)
            label = QLabel(label_text)
            v_layout.addWidget(label)
            v_layout.addWidget(widget)
            return v_layout

        self.num_marea = QLineEdit()
        self.num_marea.setMaxLength(3)
        self.anio_marea = QLineEdit()
        self.anio_marea.setMaxLength(4)
        self.observador_combo = QComboBox()
        self.buque_combo = QComboBox()

        datos_main_layout.addLayout(create_labeled_widget("Número de Marea", self.num_marea), 1)
        datos_main_layout.addLayout(create_labeled_widget("Año de Marea", self.anio_marea), 1)
        datos_main_layout.addLayout(create_labeled_widget("Observador", self.observador_combo), 2)
        datos_main_layout.addLayout(create_labeled_widget("Buque", self.buque_combo), 2)
        
        datos_group.setLayout(datos_main_layout)
        main_layout.addWidget(datos_group)

        # --- 2. Sección de Listas Dinámicas ---
        listas_container = QWidget()
        listas_layout = QHBoxLayout(listas_container)

        etapas_group = QGroupBox("Etapas de Marea")
        etapas_v_layout = QVBoxLayout()
        self.etapa_search = QLineEdit()
        self.etapa_search.setPlaceholderText("Buscar etapa...")
        self.etapas_list = QListWidget()
        self.add_etapa_btn = QPushButton("Agregar Etapa")
        etapas_v_layout.addWidget(self.etapa_search)
        etapas_v_layout.addWidget(self.etapas_list)
        etapas_v_layout.addWidget(self.add_etapa_btn)
        etapas_group.setLayout(etapas_v_layout)

        especies_group = QGroupBox("Especies Objetivo")
        especies_v_layout = QVBoxLayout()
        self.especie_combo = QComboBox()
        self.especie_combo.setEditable(True)
        self.especie_combo.setInsertPolicy(QComboBox.NoInsert)
        self.especies_list = QListWidget()
        self.add_especie_btn = QPushButton("Agregar Especie")
        self.add_especie_btn.clicked.connect(self._add_target_specie)
        especies_v_layout.addWidget(self.especie_combo)
        especies_v_layout.addWidget(self.especies_list)
        especies_v_layout.addWidget(self.add_especie_btn)
        especies_group.setLayout(especies_v_layout)

        listas_layout.addWidget(etapas_group)
        listas_layout.addWidget(especies_group)
        main_layout.addWidget(listas_container)

        # --- 3. Sección de Procesos (Menú) ---
        procesos_group = QGroupBox("Procesos")
        procesos_layout = QGridLayout()

        button_names = [
            "Cortar bases", "Control Dias horas Arrastrero", 
            "Posiciones con una especie arrastreros", "Resumen produccion",
            "Distribución de tallas", "Distribución de tallas XXXX",
            "Controla archivo L", "Largo peso", "Reemplaza especies",
            "Resumen muestra/maduros", "BUSCAR CODIGO BARCO/AIP"
        ]

        row, col = 0, 0
        for name in button_names:
            button = QPushButton(name)
            procesos_layout.addWidget(button, row, col)
            col += 1
            if col > 2:
                col = 0
                row += 1
        
        procesos_group.setLayout(procesos_layout)
        main_layout.addWidget(procesos_group)

    def _load_catalogs(self):
        """Carga los datos de los catálogos en los ComboBox."""
        foxpro_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..', 'FoxPro'))
        
        repo = CatalogRepository(base_path=foxpro_path)

        observadores = repo.get_observadores()
        self.observador_combo.addItem("Seleccione un observador...", userData=None)
        for obs in observadores:
            self.observador_combo.addItem(obs.display_name, userData=obs)

        buques = repo.get_buques()
        self.buque_combo.addItem("Seleccione un buque...", userData=None)
        for buque in buques:
            self.buque_combo.addItem(buque.display_name, userData=buque)

        especies = repo.get_especies()
        self.especie_combo.addItem("Buscar especie...", userData=None)
        for especie in especies:
            self.especie_combo.addItem(especie.display_name, userData=especie)

    def _add_target_specie(self):
        """Añade la especie seleccionada a la lista de especies objetivo."""
        selected_index = self.especie_combo.currentIndex()
        if selected_index <= 0:
            return

        specie = self.especie_combo.itemData(selected_index)
        if not isinstance(specie, Especie):
            return

        for i in range(self.especies_list.count()):
            item = self.especies_list.item(i)
            if item.data(Qt.UserRole).codinidep == specie.codinidep:
                return

        list_item = QListWidgetItem(specie.display_name)
        list_item.setData(Qt.UserRole, specie)
        self.especies_list.addItem(list_item)
