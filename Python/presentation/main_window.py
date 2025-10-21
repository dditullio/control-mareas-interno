import os
import sys
from datetime import datetime
from PySide6.QtCore import Qt, QEvent, QDate
from PySide6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout, QGridLayout,
    QGroupBox, QLabel, QLineEdit, QComboBox, QPushButton, QListWidget,
    QFormLayout, QListWidgetItem, QDateEdit, QMessageBox
)

# Ajustar la ruta para importar desde las carpetas de la arquitectura
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from infrastructure.repositories import CatalogRepository
from infrastructure import config_manager
from presentation.stage_list_item_widget import StageListItemWidget
from presentation.species_list_item_widget import SpeciesListItemWidget
from domain.entities import Especie, Buque, Observador

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Control de Mareas - INIDEP")
        self.setGeometry(100, 100, 800, 600)

        self.all_species = []
        self.species_search_mode = 'common_first'  # 'common_first' or 'scientific_first'
        self.process_buttons = []


        self._setup_ui()
        self._load_catalogs()
        self._load_state()

    def _setup_ui(self):
        """Configura la interfaz de usuario."""
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        main_layout = QVBoxLayout(central_widget)

        # --- 1. Sección de Datos de Marea (Layout con labels arriba) ---
        datos_group = QGroupBox("Datos Generales de Marea")        

        self.num_marea = QLineEdit()
        self.num_marea.setMaxLength(3)
        self.anio_marea = QLineEdit()
        self.anio_marea.setMaxLength(4)
        self.anio_marea.setText(str(datetime.now().year))
        self.observador_combo = QComboBox()
        self.observador_combo.currentIndexChanged.connect(self._update_observador_info)
        self.observador_info_label = QLineEdit()
        self.observador_info_label.setReadOnly(True)
        self.observador_info_label.setStyleSheet("font-style: italic; color: #555;")

        self.buque_combo = QComboBox()
        self.buque_combo.currentIndexChanged.connect(self._update_buque_info)
        self.buque_info_label = QLineEdit()
        self.buque_info_label.setReadOnly(True)
        self.buque_info_label.setStyleSheet("font-style: italic; color: #555;")

        # Conexión de señales para actualizar el estado de los botones de procesos
        self.num_marea.textChanged.connect(self._update_process_buttons_state)
        self.anio_marea.textChanged.connect(self._update_process_buttons_state)
        self.observador_combo.currentIndexChanged.connect(self._update_process_buttons_state)
        self.buque_combo.currentIndexChanged.connect(self._update_process_buttons_state)

        # Conexión de señales para autoguardado
        self.num_marea.textChanged.connect(self._save_state)
        self.anio_marea.textChanged.connect(self._save_state)
        self.observador_combo.currentIndexChanged.connect(self._save_state)
        self.buque_combo.currentIndexChanged.connect(self._save_state)

        # Layouts para cada sección de datos
        num_marea_layout = QVBoxLayout()
        num_marea_layout.addWidget(QLabel("Número de Marea"))
        num_marea_layout.addWidget(self.num_marea)
        anio_marea_layout = QVBoxLayout()
        anio_marea_layout.addWidget(QLabel("Año de Marea"))
        anio_marea_layout.addWidget(self.anio_marea)
        observador_layout = QVBoxLayout()
        observador_layout.addWidget(QLabel("Observador"))
        observador_layout.addWidget(self.observador_combo)
        observador_layout.addWidget(self.observador_info_label)
        buque_layout = QVBoxLayout()
        buque_layout.addWidget(QLabel("Buque"))
        buque_layout.addWidget(self.buque_combo)
        buque_layout.addWidget(self.buque_info_label)

        datos_main_layout = QHBoxLayout()
        datos_main_layout.addLayout(num_marea_layout, 1)
        datos_main_layout.addLayout(anio_marea_layout, 1)
        datos_main_layout.addLayout(observador_layout, 2)
        datos_main_layout.addLayout(buque_layout, 2)
        
        datos_group.setLayout(datos_main_layout)
        main_layout.addWidget(datos_group)

        # --- 2. Sección de Listas Dinámicas ---
        listas_container = QWidget()
        listas_layout = QHBoxLayout(listas_container)

        etapas_group = QGroupBox("Etapas de Marea")
        etapas_v_layout = QVBoxLayout()
        
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

        especie_input_layout = QHBoxLayout()
        self.especie_combo = QComboBox()
        self.especie_combo.setEditable(True)
        self.especie_combo.setInsertPolicy(QComboBox.NoInsert)
        self.especie_combo.lineEdit().setClearButtonEnabled(True)
        self.especie_combo.lineEdit().focusInEvent = lambda event: self.especie_combo.lineEdit().selectAll()
        self.especie_combo.lineEdit().returnPressed.connect(self._add_target_specie)
        
        self.toggle_species_view_btn = QPushButton("⥃")
        self.toggle_species_view_btn.setCheckable(True)
        self.toggle_species_view_btn.setFixedWidth(40)
        self.toggle_species_view_btn.setToolTip("Alternar entre 'Nombre Común (Científico)' y 'Nombre Científico (Común)'")
        self.toggle_species_view_btn.clicked.connect(self._toggle_species_view)

        especie_input_layout.addWidget(self.especie_combo)
        especie_input_layout.addWidget(self.toggle_species_view_btn)

        self.especies_list = QListWidget()
        self.add_especie_btn = QPushButton("Agregar Especie")
        self.add_especie_btn.clicked.connect(self._add_target_specie)

        especies_v_layout.addLayout(especie_input_layout)
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
            button.setEnabled(False)
            self.process_buttons.append(button)
            procesos_layout.addWidget(button, row, col)
            col += 1
            if col > 2:
                col = 0
                row += 1
        
        self.clear_button = QPushButton("Limpiar Todo")
        self.clear_button.clicked.connect(self._clear_all_fields)
        procesos_layout.addWidget(self.clear_button, row, 0, 1, 3) # Span across all columns

        procesos_group.setLayout(procesos_layout)
        main_layout.addWidget(procesos_group)

        self._setup_enter_navigation()
        self._update_process_buttons_state()

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

        # Cargar y guardar todas las especies, luego poblar el combo
        self.all_species = sorted(repo.get_especies(), key=lambda e: e.nom_vul_cas or '')
        self._repopulate_species_combo()

        # Actualizar los campos de información con el estado inicial (vacío)
        self._update_observador_info()
        self._update_buque_info()

    def _clear_all_fields(self):
        """Limpia todos los campos y reinicia el estado."""
        self.num_marea.clear()
        self.anio_marea.setText(str(datetime.now().year))
        self.observador_combo.setCurrentIndex(0)
        self.buque_combo.setCurrentIndex(0)
        self.etapas_list.clear()
        self.especies_list.clear()
        self._update_process_buttons_state()
        self._save_state()

    def _save_state(self):
        """Guarda el estado actual de la aplicación en un archivo de configuración."""
        etapas = []
        for i in range(self.etapas_list.count()):
            item = self.etapas_list.item(i)
            start_date, end_date = item.data(Qt.UserRole)
            etapas.append({
                'start_date': start_date.toString(Qt.ISODate),
                'end_date': end_date.toString(Qt.ISODate)
            })

        especies = []
        for i in range(self.especies_list.count()):
            item = self.especies_list.item(i)
            specie = item.data(Qt.UserRole)
            especies.append(specie.codinidep)

        state = {
            'num_marea': self.num_marea.text(),
            'anio_marea': self.anio_marea.text(),
            'observador_cod': self.observador_combo.currentData().obs_nro if self.observador_combo.currentIndex() > 0 else None,
            'buque_cod': self.buque_combo.currentData().buque_cod if self.buque_combo.currentIndex() > 0 else None,
            'etapas': etapas,
            'especies': especies
        }
        config_manager.save_config(state)

    def _load_state(self):
        """Carga el estado de la aplicación desde un archivo de configuración."""
        state = config_manager.load_config()
        if not state:
            return

        self.num_marea.setText(state.get('num_marea', ''))
        self.anio_marea.setText(state.get('anio_marea', str(datetime.now().year)))

        if state.get('observador_cod'):
            for i in range(self.observador_combo.count()):
                obs = self.observador_combo.itemData(i)
                if obs and obs.obs_nro == state['observador_cod']:
                    self.observador_combo.setCurrentIndex(i)
                    break

        if state.get('buque_cod'):
            for i in range(self.buque_combo.count()):
                buque = self.buque_combo.itemData(i)
                if buque and buque.buque_cod == state['buque_cod']:
                    self.buque_combo.setCurrentIndex(i)
                    break

        self.etapas_list.clear()
        for etapa_data in state.get('etapas', []):
            start_date = QDate.fromString(etapa_data['start_date'], Qt.ISODate)
            end_date = QDate.fromString(etapa_data['end_date'], Qt.ISODate)
            self._add_trip_stage(start_date, end_date, save=False)

        self.especies_list.clear()
        for codinidep in state.get('especies', []):
            for especie in self.all_species:
                if especie.codinidep == codinidep:
                    self._add_target_specie(specie, save=False)
                    break
        
        self._update_process_buttons_state()

    def _update_observador_info(self) -> None:
        """Actualiza el campo de texto con la información del observador seleccionado."""
        selected_index = self.observador_combo.currentIndex()
        observador = self.observador_combo.itemData(selected_index)

        if observador:
            self.observador_info_label.setText(f"Código: {observador.obs_nro}")
        else:
            self.observador_info_label.clear()

    def _update_buque_info(self) -> None:
        """Actualiza el campo de texto con la información del buque seleccionado."""
        selected_index = self.buque_combo.currentIndex()
        buque = self.buque_combo.itemData(selected_index)

        if buque:
            info_text = (f"Cód.: {buque.buque_cod}, "
                         f"Esl.: {buque.eslora:.2f} m, "
                         f"Pot.: {buque.pot_hp} HP")
            self.buque_info_label.setText(info_text)
        else:
            self.buque_info_label.clear()

    def _update_process_buttons_state(self) -> None:
        """Habilita o deshabilita los botones de procesos según el estado de los campos de marea."""
        marea_completa = all([
            self.num_marea.text(),
            self.anio_marea.text(),
            self.observador_combo.currentIndex() > 0,
            self.buque_combo.currentIndex() > 0,
            self.etapas_list.count() > 0,
            self.especies_list.count() > 0
        ])

        for button in self.process_buttons:
            button.setEnabled(marea_completa)

    def _toggle_species_view(self):
        """Cambia el modo de visualización de las especies y repuebla el ComboBox."""
        self.species_search_mode = 'scientific_first' if self.species_search_mode == 'common_first' else 'common_first'
        self._repopulate_species_combo()
        self.especie_combo.setFocus()

    def _repopulate_species_combo(self):
        """Limpia y vuelve a llenar el ComboBox de especies según el modo de búsqueda actual."""
        current_text = self.especie_combo.lineEdit().text()
        current_data = self.especie_combo.currentData()

        self.especie_combo.blockSignals(True)
        self.especie_combo.clear()
        self.especie_combo.addItem("Buscar especie...", userData=None)

        for especie in self.all_species:
            display_name = ""
            if self.species_search_mode == 'common_first':
                display_name = especie.display_name
            else:  # scientific_first
                display_name = f"{especie.nom_cient} ({especie.nom_vul_cas})"
            
            self.especie_combo.addItem(display_name, userData=especie)
        
        self.especie_combo.blockSignals(False)

        # Intentar restaurar la selección o texto
        if current_data:
            index = self.especie_combo.findData(current_data)
            if index != -1:
                self.especie_combo.setCurrentIndex(index)
            else:
                self.especie_combo.lineEdit().setText(current_text)
        else:
            self.especie_combo.lineEdit().setText(current_text)

    def _add_target_specie(self, specie_to_add=None, save=True):
        """Añade la especie seleccionada a la lista de especies objetivo, manteniendo el orden alfabético."""
        specie = specie_to_add
        if not specie:
            selected_index = self.especie_combo.currentIndex()
            if selected_index <= 0:
                return
            specie = self.especie_combo.itemData(selected_index)
        
        if not isinstance(specie, Especie):
            return

        for i in range(self.especies_list.count()):
            item = self.especies_list.item(i)
            if item.data(Qt.UserRole).codinidep == specie.codinidep:
                if not specie_to_add:
                    QMessageBox.warning(self, "Especie Duplicada", "La especie ya se encuentra en la lista.")
                return

        list_item = QListWidgetItem()
        list_item.setData(Qt.UserRole, specie)

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
        
        if not specie_to_add:
            self.especie_combo.setCurrentIndex(0)
            self.especie_combo.lineEdit().clear()
            self.especie_combo.setFocus()
        
        if save:
            self._save_state()
        self._update_process_buttons_state()

    def _remove_target_specie(self, item_to_delete):
        """Elimina un item de la lista de especies."""
        row = self.especies_list.row(item_to_delete)
        if row >= 0:
            self.especies_list.takeItem(row)
        self._save_state()
        self._update_process_buttons_state()

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

    def _add_trip_stage(self, start_date=None, end_date=None, save=True):
        """Añade una nueva etapa de viaje a la lista, ordenada y con validación."""
        if start_date is None or end_date is None:
            start_date = self.etapa_start_date.date()
            end_date = self.etapa_end_date.date()

        if end_date < start_date:
            QMessageBox.warning(self, "Error de Fechas", "La fecha final no puede ser anterior a la fecha inicial.")
            return

        for i in range(self.etapas_list.count()):
            item = self.etapas_list.item(i)
            existing_start, existing_end = item.data(Qt.UserRole)
            if start_date <= existing_end and existing_start <= end_date:
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

        if save:
            self.etapa_start_date.setDate(QDate.currentDate())
            self.etapa_end_date.setDate(QDate.currentDate())
            self.etapa_start_date.setFocus()
            self._save_state()
        self._update_process_buttons_state()

    def _remove_trip_stage(self, item_to_delete):
        """Elimina un item de la lista de etapas."""
        row = self.etapas_list.row(item_to_delete)
        if row >= 0:
            self.etapas_list.takeItem(row)
        self._save_state()
        self._update_process_buttons_state()
