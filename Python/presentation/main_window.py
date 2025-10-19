import os
import sys
from PySide6.QtCore import Qt, QEvent, QDate
from PySide6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout, QGridLayout,
    QGroupBox, QLabel, QLineEdit, QComboBox, QPushButton, QListWidget,
    QFormLayout, QListWidgetItem, QDateEdit, QMessageBox
)

# Ajustar la ruta para importar desde las carpetas de la arquitectura
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from infrastructure.repositories import CatalogRepository
from presentation.stage_list_item_widget import StageListItemWidget
from presentation.species_list_item_widget import SpeciesListItemWidget
from domain.entities import Especie

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
        
        # Layout para los campos de fecha
        fechas_layout = QHBoxLayout()
        self.etapa_start_date = QDateEdit(calendarPopup=True)
        self.etapa_start_date.setDisplayFormat("dd/MM/yyyy")
        self.etapa_start_date.setDate(QDate.currentDate())
        self.etapa_end_date = QDateEdit(calendarPopup=True)
        self.etapa_end_date.setDisplayFormat("dd/MM/yyyy")
        self.etapa_end_date.setDate(QDate.currentDate())
        fechas_layout.addWidget(QLabel("Fecha Inicial:"))
        fechas_layout.addWidget(self.etapa_start_date)
        fechas_layout.addWidget(QLabel("Fecha Final:"))
        fechas_layout.addWidget(self.etapa_end_date)

        self.etapas_list = QListWidget()
        self.add_etapa_btn = QPushButton("Agregar Etapa")
        self.add_etapa_btn.clicked.connect(self._add_trip_stage)

        etapas_v_layout.addLayout(fechas_layout)
        etapas_v_layout.addWidget(self.etapas_list)
        etapas_v_layout.addWidget(self.add_etapa_btn)
        etapas_group.setLayout(etapas_v_layout)

        especies_group = QGroupBox("Especies Objetivo")
        especies_v_layout = QVBoxLayout()
        self.especie_combo = QComboBox()
        self.especie_combo.setEditable(True)
        self.especie_combo.setInsertPolicy(QComboBox.NoInsert)
        self.especie_combo.lineEdit().setClearButtonEnabled(True)
        self.especie_combo.lineEdit().focusInEvent = lambda event: self.especie_combo.lineEdit().selectAll()
        # Conectar la señal returnPressed para agregar la especie
        self.especie_combo.lineEdit().returnPressed.connect(self._add_target_specie)

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

        self._setup_enter_navigation()

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
        """Añade la especie seleccionada a la lista de especies objetivo, manteniendo el orden alfabético."""
        selected_index = self.especie_combo.currentIndex()
        if selected_index <= 0:  # No agregar si es el texto placeholder o no hay nada seleccionado
            return

        specie = self.especie_combo.itemData(selected_index)
        if not isinstance(specie, Especie):
            return

        # Evitar duplicados
        for i in range(self.especies_list.count()):
            item = self.especies_list.item(i)
            if item.data(Qt.UserRole).codinidep == specie.codinidep:
                QMessageBox.warning(self, "Especie Duplicada", "La especie ya se encuentra en la lista.")
                self.especie_combo.setCurrentIndex(0)
                self.especie_combo.lineEdit().clear()
                self.especie_combo.setFocus()
                return

        list_item = QListWidgetItem()
        list_item.setData(Qt.UserRole, specie)

        # Encontrar la posición correcta para insertar y mantener el orden alfabético
        insert_row = 0
        while insert_row < self.especies_list.count():
            item = self.especies_list.item(insert_row)
            existing_specie = item.data(Qt.UserRole)
            if specie.display_name < existing_specie.display_name:
                break
            insert_row += 1
        
        self.especies_list.insertItem(insert_row, list_item)

        item_widget = SpeciesListItemWidget(specie.display_name, list_item)
        item_widget.deleted.connect(self._remove_target_specie)
        list_item.setSizeHint(item_widget.sizeHint())
        self.especies_list.setItemWidget(list_item, item_widget)
        
        # Limpiar y re-enfocar para la siguiente entrada
        self.especie_combo.setCurrentIndex(0)
        self.especie_combo.lineEdit().clear()
        self.especie_combo.setFocus()

    def _remove_target_specie(self, item_to_delete):
        """Elimina un item de la lista de especies."""
        row = self.especies_list.row(item_to_delete)
        if row >= 0:
            self.especies_list.takeItem(row)

    def eventFilter(self, watched, event):
        """Filtro de eventos para manejar la tecla Enter como Tab."""
        if event.type() == QEvent.KeyPress and event.key() in (Qt.Key_Enter, Qt.Key_Return):
            next_widget_map = {
                self.num_marea: self.anio_marea,
                self.anio_marea: self.observador_combo,
                self.observador_combo: self.buque_combo,
                self.buque_combo: self.especie_combo,
                self.especie_combo: self.etapa_start_date,
                self.etapa_start_date: self.etapa_end_date,
                self.etapa_end_date: self.add_etapa_btn
            }
            
            next_widget = next_widget_map.get(watched)

            if next_widget:
                if next_widget is self.add_etapa_btn:
                    self.add_etapa_btn.click()
                else:
                    next_widget.setFocus()
                return True

        return super().eventFilter(watched, event)

    def _setup_enter_navigation(self):
        """Instala el filtro de eventos en los widgets para la navegación con Enter."""
        self.num_marea.installEventFilter(self)
        self.anio_marea.installEventFilter(self)
        self.observador_combo.installEventFilter(self)
        self.buque_combo.installEventFilter(self)
        self.etapa_start_date.installEventFilter(self)
        self.etapa_end_date.installEventFilter(self)

    def _add_trip_stage(self):
        """Añade una nueva etapa de viaje a la lista, ordenada y con validación."""
        start_date = self.etapa_start_date.date()
        end_date = self.etapa_end_date.date()

        if end_date < start_date:
            QMessageBox.warning(self, "Error de Fechas", "La fecha final no puede ser anterior a la fecha inicial.")
            return

        for i in range(self.etapas_list.count()):
            item = self.etapas_list.item(i)
            existing_start, existing_end = item.data(Qt.UserRole)
            if start_date <= existing_end and existing_start <= end_date:
                QMessageBox.critical(self, "Error de Solapamiento",
                                     f"La etapa se solapa con una existente: "
                                     f"{existing_start.toString('dd/MM/yyyy')} a {existing_end.toString('dd/MM/yyyy')}")
                return

        list_item = QListWidgetItem()
        list_item.setData(Qt.UserRole, (start_date, end_date))

        insert_row = 0
        while insert_row < self.etapas_list.count():
            item = self.etapas_list.item(insert_row)
            existing_start, _ = item.data(Qt.UserRole)
            if start_date < existing_start:
                break
            insert_row += 1
        
        self.etapas_list.insertItem(insert_row, list_item)
        
        item_widget = StageListItemWidget(start_date, end_date, list_item)
        item_widget.deleted.connect(self._remove_trip_stage)
        list_item.setSizeHint(item_widget.sizeHint())
        self.etapas_list.setItemWidget(list_item, item_widget)

        self.etapa_start_date.setDate(QDate.currentDate())
        self.etapa_end_date.setDate(QDate.currentDate())
        self.etapa_start_date.setFocus()

    def _remove_trip_stage(self, item_to_delete):
        """Elimina un item de la lista de etapas."""
        row = self.etapas_list.row(item_to_delete)
        if row >= 0:
            self.etapas_list.takeItem(row)
