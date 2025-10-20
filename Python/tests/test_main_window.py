
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
def window(qt_app, mock_repository):
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

def test_enter_in_species_combo_adds_item(qtbot, window):
    """Test: Presionar Enter en el combo de especies la añade a la lista."""
    assert window.especies_list.count() == 0
    
    window.especie_combo.setCurrentIndex(2) # Caballa
    
    # Simular la presión de la tecla Enter en el lineEdit del combo
    qtbot.keyClick(window.especie_combo.lineEdit(), Qt.Key_Return)

    assert window.especies_list.count() == 1
    assert window.especies_list.item(0).data(Qt.UserRole).nom_vul_cas == 'Caballa'

