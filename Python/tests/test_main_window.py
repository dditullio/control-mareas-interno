
import sys
import os
import pytest
from unittest.mock import MagicMock

# Añadir el directorio raíz del proyecto de Python al path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from PySide6.QtCore import QDate, Qt
from PySide6.QtWidgets import QApplication, QListWidgetItem

from presentation.main_window import MainWindow
from domain.entities import Especie, Observador, Buque

# Forzamos la creación de una QApplication para las pruebas
@pytest.fixture(scope='session')
def qt_app():
    app = QApplication.instance()
    if app is None:
        app = QApplication(sys.argv)
    return app

@pytest.fixture
def mock_species():
    """Provee una lista de objetos Especie para simular."""
    return [
        Especie(codinidep='1', nom_vul_cas='Anchoita', nom_cient='Engraulis anchoita'),
        Especie(codinidep='3', nom_vul_cas='Merluza', nom_cient='Merluccius hubbsi'),
        Especie(codinidep='2', nom_vul_cas='Caballa', nom_cient='Scomber colias'),
    ]

@pytest.fixture
def mock_repository(mocker, mock_species):
    """Crea un mock del CatalogRepository."""
    mock_repo = MagicMock()
    mock_repo.get_especies.return_value = mock_species
    mock_repo.get_observadores.return_value = [Observador('1', 'Perez', 'Juan')]
    mock_repo.get_buques.return_value = [Buque('Barco 1', '123', 'A', 'Arrastrero', 30.0, 1000, ' matrícula')]
    
    mocker.patch('presentation.main_window.CatalogRepository', return_value=mock_repo)
    return mock_repo

@pytest.fixture
def mock_config_manager(mocker):
    """Crea un mock del config_manager."""
    mock_cm = MagicMock()
    mock_cm.load_config.return_value = None # No config file by default
    mocker.patch('presentation.main_window.config_manager', new=mock_cm)
    return mock_cm

@pytest.fixture
def window(qt_app, mock_repository, mock_config_manager):
    """Crea una instancia de MainWindow para las pruebas."""
    win = MainWindow()
    return win

def test_initial_load(window, mock_repository):
    """Test: Verifica que los catálogos se cargan al iniciar."""
    mock_repository.get_observadores.assert_called_once()
    mock_repository.get_buques.assert_called_once()
    mock_repository.get_especies.assert_called_once()
    # 3 especies + 1 item placeholder
    assert window.especie_combo.count() == 4

def test_process_buttons_initial_state(window):
    """Test: Verifica que los botones de proceso están deshabilitados inicialmente."""
    for button in window.process_buttons:
        assert not button.isEnabled()

def test_process_buttons_enable_disable(qtbot, window):
    """Test: Los botones de proceso se habilitan y deshabilitan correctamente."""
    # Estado inicial: deshabilitado
    assert not window.process_buttons[0].isEnabled()

    # Rellenar todos los campos
    window.num_marea.setText("123")
    window.anio_marea.setText("2025")
    window.observador_combo.setCurrentIndex(1)
    window.buque_combo.setCurrentIndex(1)
    
    # Añadir una etapa
    window.etapa_start_date.setDate(QDate(2025, 1, 1))
    window.etapa_end_date.setDate(QDate(2025, 1, 5))
    qtbot.mouseClick(window.add_etapa_btn, Qt.LeftButton)

    # Añadir una especie
    window.especie_combo.setCurrentIndex(1)
    qtbot.mouseClick(window.add_especie_btn, Qt.LeftButton)

    # Ahora los botones deben estar habilitados
    for button in window.process_buttons:
        assert button.isEnabled()

    # Limpiar un campo (ej. número de marea)
    window.num_marea.clear()

    # Los botones deben deshabilitarse de nuevo
    for button in window.process_buttons:
        assert not button.isEnabled()

def test_save_state_on_change(window, mock_config_manager):
    """Test: El estado se guarda automáticamente al cambiar un campo."""
    # Limpiar llamadas previas
    mock_config_manager.save_config.reset_mock()

    # Cambiar un campo
    window.num_marea.setText("456")

    # Verificar que se llamó al guardado
    mock_config_manager.save_config.assert_called()

def test_load_state_on_startup(mocker, qt_app, mock_repository):
    """Test: El estado se carga correctamente al iniciar si existe un archivo de config."""
    # Preparar un estado guardado
    saved_state = {
        'num_marea': '789',
        'anio_marea': '2024',
        'observador_cod': '1',
        'buque_cod': '123',
        'etapas': [
            {'start_date': '2024-03-01', 'end_date': '2024-03-05'}
        ],
        'especies': ['3'] # Merluza
    }
    
    mock_cm = MagicMock()
    mock_cm.load_config.return_value = saved_state
    mocker.patch('presentation.main_window.config_manager', new=mock_cm)

    # Crear una nueva ventana para forzar la carga del estado
    win = MainWindow()

    # Verificar que los campos se han llenado
    assert win.num_marea.text() == '789'
    assert win.anio_marea.text() == '2024'
    assert win.observador_combo.currentIndex() == 1
    assert win.buque_combo.currentIndex() == 1
    assert win.etapas_list.count() == 1
    assert win.especies_list.count() == 1
    assert win.especies_list.item(0).data(Qt.UserRole).nom_vul_cas == 'Merluza'

def test_clear_all_fields(qtbot, window, mock_config_manager):
    """Test: El botón 'Limpiar Todo' reinicia la UI y guarda el estado vacío."""
    # Llenar algunos campos primero
    window.num_marea.setText("111")
    window.observador_combo.setCurrentIndex(1)
    qtbot.mouseClick(window.add_etapa_btn, Qt.LeftButton)
    mock_config_manager.save_config.reset_mock()

    # Clic en el botón de limpiar
    qtbot.mouseClick(window.clear_button, Qt.LeftButton)

    # Verificar que los campos están vacíos
    assert window.num_marea.text() == ''
    assert window.observador_combo.currentIndex() == 0
    assert window.etapas_list.count() == 0
    
    # Verificar que el año se ha reseteado al actual
    from datetime import datetime
    assert window.anio_marea.text() == str(datetime.now().year)

    # Verificar que se guardó el estado vacío
    mock_config_manager.save_config.assert_called_with({
        'num_marea': '',
        'anio_marea': str(datetime.now().year),
        'observador_cod': None,
        'buque_cod': None,
        'etapas': [],
        'especies': []
    })

def test_load_state_with_missing_keys(mocker, qt_app, mock_repository):
    """Test: Cargar un estado con claves faltantes no rompe la aplicación."""
    # Estado solo con una clave
    saved_state = {
        'num_marea': '999'
    }
    
    mock_cm = MagicMock()
    mock_cm.load_config.return_value = saved_state
    mocker.patch('presentation.main_window.config_manager', new=mock_cm)

    # La creación de la ventana no debe fallar
    win = MainWindow()

    assert win.num_marea.text() == '999'
    # El resto de los campos deben tener sus valores por defecto
    from datetime import datetime
    assert win.anio_marea.text() == str(datetime.now().year)
    assert win.observador_combo.currentIndex() == 0
    assert win.etapas_list.count() == 0

def test_load_state_with_invalid_values(mocker, qt_app, mock_repository):
    """Test: Cargar un estado con valores inválidos (códigos no existentes)."""
    saved_state = {
        'observador_cod': '999', # Código no existente
        'especies': ['999'] # Código no existente
    }
    
    mock_cm = MagicMock()
    mock_cm.load_config.return_value = saved_state
    mocker.patch('presentation.main_window.config_manager', new=mock_cm)

    win = MainWindow()

    # Los combos no deben seleccionar nada y las listas deben estar vacías
    assert win.observador_combo.currentIndex() == 0
    assert win.especies_list.count() == 0

def test_add_target_specie(qtbot, window):
    """Test: Añadir una especie a la lista de especies objetivo."""
    assert window.especies_list.count() == 0
    
    # Seleccionar "Caballa"
    window.especie_combo.setCurrentIndex(2)
    
    qtbot.mouseClick(window.add_especie_btn, Qt.LeftButton)
    
    assert window.especies_list.count() == 1
    item = window.especies_list.item(0)
    specie_data = item.data(Qt.UserRole)
    assert specie_data.nom_vul_cas == 'Caballa'

def test_add_species_sorted(qtbot, window):
    """Test: Las especies se añaden a la lista en orden alfabético."""
    # Añadir Merluza (debería ir al final)
    window.especie_combo.setCurrentIndex(3) # Merluza
    qtbot.mouseClick(window.add_especie_btn, Qt.LeftButton)
    
    # Añadir Anchoita (debería ir al principio)
    window.especie_combo.setCurrentIndex(1) # Anchoita
    qtbot.mouseClick(window.add_especie_btn, Qt.LeftButton)

    # Añadir Caballa (debería ir en el medio)
    window.especie_combo.setCurrentIndex(2) # Caballa
    qtbot.mouseClick(window.add_especie_btn, Qt.LeftButton)

    assert window.especies_list.count() == 3
    assert window.especies_list.item(0).data(Qt.UserRole).nom_vul_cas == 'Anchoita'
    assert window.especies_list.item(1).data(Qt.UserRole).nom_vul_cas == 'Caballa'
    assert window.especies_list.item(2).data(Qt.UserRole).nom_vul_cas == 'Merluza'

def test_prevent_duplicate_species(qtbot, window, mocker):
    """Test: No se pueden añadir especies duplicadas."""
    mock_msg_box = mocker.patch('presentation.main_window.QMessageBox.warning')

    # Añadir Caballa
    window.especie_combo.setCurrentIndex(2)
    qtbot.mouseClick(window.add_especie_btn, Qt.LeftButton)
    assert window.especies_list.count() == 1

    # Intentar añadir Caballa de nuevo
    window.especie_combo.setCurrentIndex(2)
    qtbot.mouseClick(window.add_especie_btn, Qt.LeftButton)
    
    # La lista no debe crecer y debe mostrarse una advertencia
    assert window.especies_list.count() == 1
    mock_msg_box.assert_called_once()

def test_remove_specie(qtbot, window):
    """Test: Eliminar una especie de la lista."""
    # Añadir una especie primero
    window.especie_combo.setCurrentIndex(1) # Anchoita
    qtbot.mouseClick(window.add_especie_btn, Qt.LeftButton)
    assert window.especies_list.count() == 1

    # Obtener el widget del item y simular clic en su botón de borrar
    item_widget = window.especies_list.itemWidget(window.especies_list.item(0))
    # Asumimos que el botón de borrar se llama 'delete_button' en SpeciesListItemWidget
    # Si no es accesible, necesitamos otra estrategia, como emitir la señal.
    item_widget.deleted.emit(window.especies_list.item(0))

    assert window.especies_list.count() == 0

def test_toggle_species_view(qtbot, window):
    """Test: El modo de búsqueda de especies alterna correctamente."""
    assert window.species_search_mode == 'common_first'
    assert 'Anchoita' in window.especie_combo.itemText(1)

    # Clic en el botón de alternar
    qtbot.mouseClick(window.toggle_species_view_btn, Qt.LeftButton)

    assert window.species_search_mode == 'scientific_first'
    assert 'Engraulis anchoita' in window.especie_combo.itemText(1)

    # Clic de nuevo para volver al original
    qtbot.mouseClick(window.toggle_species_view_btn, Qt.LeftButton)
    assert window.species_search_mode == 'common_first'
    assert 'Anchoita' in window.especie_combo.itemText(1)

def test_add_trip_stage(qtbot, window):
    """Test: Añadir una etapa de viaje válida."""
    start_date = QDate(2025, 10, 20)
    end_date = QDate(2025, 10, 25)
    window.etapa_start_date.setDate(start_date)
    window.etapa_end_date.setDate(end_date)

    qtbot.mouseClick(window.add_etapa_btn, Qt.LeftButton)

    assert window.etapas_list.count() == 1
    item = window.etapas_list.item(0)
    s_date, e_date = item.data(Qt.UserRole)
    assert s_date == start_date
    assert e_date == end_date

def test_prevent_overlapping_stages(qtbot, window, mocker):
    """Test: No se pueden añadir etapas que se solapan."""
    mock_msg_box = mocker.patch('presentation.main_window.QMessageBox.critical')

    # Añadir etapa inicial
    window.etapa_start_date.setDate(QDate(2025, 10, 20))
    window.etapa_end_date.setDate(QDate(2025, 10, 25))
    qtbot.mouseClick(window.add_etapa_btn, Qt.LeftButton)
    assert window.etapas_list.count() == 1

    # Intentar añadir etapa solapada
    window.etapa_start_date.setDate(QDate(2025, 10, 22))
    window.etapa_end_date.setDate(QDate(2025, 10, 27))
    qtbot.mouseClick(window.add_etapa_btn, Qt.LeftButton)

    assert window.etapas_list.count() == 1
    mock_msg_box.assert_called_once()

def test_prevent_end_date_before_start_date(qtbot, window, mocker):
    """Test: No se puede añadir una etapa con fecha final anterior a la inicial."""
    mock_msg_box = mocker.patch('presentation.main_window.QMessageBox.warning')

    window.etapa_start_date.setDate(QDate(2025, 10, 25))
    window.etapa_end_date.setDate(QDate(2025, 10, 20))
    qtbot.mouseClick(window.add_etapa_btn, Qt.LeftButton)

    assert window.etapas_list.count() == 0
    mock_msg_box.assert_called_once()

def test_enter_in_species_combo_adds_item(qtbot, window):
    """Test: Presionar Enter en el combo de especies la añade a la lista."""
    assert window.especies_list.count() == 0
    
    window.especie_combo.setCurrentIndex(2) # Caballa
    
    # Simular la presión de la tecla Enter en el lineEdit del combo
    qtbot.keyClick(window.especie_combo.lineEdit(), Qt.Key_Return)

    assert window.especies_list.count() == 1
    assert window.especies_list.item(0).data(Qt.UserRole).nom_vul_cas == 'Caballa'

