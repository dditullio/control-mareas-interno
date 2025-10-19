
from dataclasses import dataclass, field

@dataclass
class Especie:
    codinidep: str
    nom_vul_cas: str
    nom_cient: str

    @property
    def display_name(self) -> str:
        """Formato: Nombre Vulgar (Nombre Científico)"""
        return f"{self.nom_vul_cas} ({self.nom_cient})"

@dataclass
class Observador:
    obs_nro: str
    apellido: str
    nombre: str

    @property
    def display_name(self) -> str:
        """Formato: Apellido, Nombre"""
        return f"{self.apellido}, {self.nombre}"

@dataclass
class Buque:
    # Usamos el nombre como identificador principal por la inconsistencia del código
    nombre: str 
    buque_cod: str
    tipo_flota: str
    flota: str
    eslora: float
    pot_hp: int
    matricula: str

    @property
    def display_name(self) -> str:
        """Formato: Nombre del Buque"""
        return self.nombre
