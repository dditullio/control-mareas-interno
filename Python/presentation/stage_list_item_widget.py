from PySide6.QtWidgets import QWidget, QHBoxLayout, QLabel, QPushButton, QListWidgetItem
from PySide6.QtCore import Signal

class StageListItemWidget(QWidget):
    """
    Widget personalizado para mostrar una etapa de marea en la lista.
    Incluye un label con las fechas y un botón para eliminar el item.
    """
    # Señal que se emite cuando se solicita la eliminación del widget
    deleted = Signal(QListWidgetItem)

    def __init__(self, start_date, end_date, list_item):
        super().__init__()
        self.list_item = list_item  # Guardar referencia al QListWidgetItem que nos contiene

        layout = QHBoxLayout()
        layout.setContentsMargins(5, 2, 5, 2)
        layout.setSpacing(10)

        # Formatear las fechas para mostrarlas
        date_text = f"{start_date.toString('dd/MM/yyyy')} - {end_date.toString('dd/MM/yyyy')}"
        self.label = QLabel(date_text)
        self.label.setStyleSheet("font-size: 11px;")

        self.delete_button = QPushButton("Eliminar")
        self.delete_button.setStyleSheet("padding: 4px 8px; font-size: 10px;")
        
        # Conectar el clic del botón a un método que emita la señal
        self.delete_button.clicked.connect(self._emit_delete_signal)

        layout.addWidget(self.label)
        layout.addStretch()  # Añade espacio flexible
        layout.addWidget(self.delete_button)
        
        self.setLayout(layout)

    def _emit_delete_signal(self):
        """
        Emite la señal 'deleted' pasando como argumento la referencia
        al QListWidgetItem que este widget adorna.
        """
        self.deleted.emit(self.list_item)
