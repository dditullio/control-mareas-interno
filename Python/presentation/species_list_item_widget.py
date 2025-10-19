from PySide6.QtWidgets import QWidget, QHBoxLayout, QLabel, QPushButton, QListWidgetItem
from PySide6.QtCore import Signal

class SpeciesListItemWidget(QWidget):
    """
    Widget personalizado para mostrar una especie en la lista de objetivos.
    Incluye un label con el nombre y un botón para eliminar el item.
    """
    deleted = Signal(QListWidgetItem)

    def __init__(self, specie_name, list_item):
        super().__init__()
        self.list_item = list_item

        layout = QHBoxLayout()
        layout.setContentsMargins(5, 2, 5, 2)
        layout.setSpacing(10)

        self.label = QLabel(specie_name)
        self.label.setStyleSheet("font-size: 11px;")

        self.delete_button = QPushButton("Eliminar")
        self.delete_button.setStyleSheet("padding: 4px 8px; font-size: 10px;")
        self.delete_button.clicked.connect(self._emit_delete_signal)

        layout.addWidget(self.label)
        layout.addStretch()
        layout.addWidget(self.delete_button)
        
        self.setLayout(layout)

    def _emit_delete_signal(self):
        self.deleted.emit(self.list_item)
