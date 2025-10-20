
import dbf
import os
from typing import List
from domain.entities import Especie, Buque, Observador

class CatalogRepository:
    """Repositorio para acceder a los catálogos desde archivos DBF."""

    def __init__(self, base_path: str):
        """Inicializa el repositorio con la ruta base a la carpeta FoxPro."""
        self.base_path = base_path

    def _get_full_path(self, file_name: str) -> str:
        return os.path.join(self.base_path, file_name)

    def get_especies(self) -> List[Especie]:
        """Lee Especies.dbf y devuelve una lista de entidades Especie."""
        especies = []
        dbf_path = self._get_full_path("Especies.dbf")
        try:
            table = dbf.Table(dbf_path, codepage='cp1252') # cp1252 es común para Windows en español
            table.open(dbf.READ_ONLY)
            for record in table:
                try:
                    codinidep = str(record.codinidep).strip()
                    nom_vul_cas = str(record.nomvulcas).strip()
                    nom_cient = str(record.nomcient).strip()
                    if codinidep and nom_vul_cas and nom_cient:
                        especies.append(Especie(
                            codinidep=codinidep,
                            nom_vul_cas=nom_vul_cas,
                            nom_cient=nom_cient
                        ))
                except (dbf.FieldMissingError, AttributeError) as field_err:
                    print(f"Advertencia: Campo faltante en {dbf_path}: {field_err}")
                    continue # Salta al siguiente registro
            table.close()
        except Exception as e:
            print(f"Error al leer {dbf_path}: {e}")
        return sorted(especies, key=lambda x: x.nom_vul_cas)

    def get_buques(self) -> List[Buque]:
        """Lee 'buques y sus datos.DBF' y devuelve una lista de entidades Buque."""
        buques = []
        dbf_path = self._get_full_path("buques y sus datos.DBF")
        try:
            table = dbf.Table(dbf_path, codepage='cp1252')
            table.open(dbf.READ_ONLY)
            for record in table:
                try:
                    nombre = str(record.buque).strip()
                    if not nombre: # El nombre es la clave principal, no puede estar vacío
                        continue
                    
                    buques.append(Buque(
                        nombre=nombre,
                        buque_cod=str(record.buquecod).strip(),
                        tipo_flota=str(record.tipo_flta).strip(),
                        flota=str(record.flota).strip(),
                        eslora=float(record.eslora or 0),
                        pot_hp=int(record.pothp or 0),
                        matricula=str(record.matbuq).strip()
                    ))
                except (dbf.FieldMissingError, AttributeError) as field_err:
                    print(f"Advertencia: Campo faltante en {dbf_path}: {field_err}")
                    continue
                except (ValueError, TypeError) as type_err:
                    print(f"Advertencia: Error de tipo en registro {record} de {dbf_path}: {type_err}")
                    continue
            table.close()
        except Exception as e:
            print(f"Error al leer {dbf_path}: {e}")
        return sorted(buques, key=lambda x: x.nombre)

    def get_observadores(self) -> List[Observador]:
        """Lee 'OBSERVAD.DBF' y devuelve una lista de entidades Observador."""
        observadores = []
        dbf_path = self._get_full_path("OBSERVAD.DBF")
        try:
            table = dbf.Table(dbf_path, codepage='cp1252')
            table.open(dbf.READ_ONLY)
            for record in table:
                try:
                    obs_nro = str(record.obsnro).strip()
                    apellido = str(record.obser).strip()
                    nombre = str(record.obsnom).strip()
                    if obs_nro and apellido:
                        observadores.append(Observador(
                            obs_nro=obs_nro,
                            apellido=apellido,
                            nombre=nombre
                        ))
                except (dbf.FieldMissingError, AttributeError) as field_err:
                    print(f"Advertencia: Campo faltante en {dbf_path}: {field_err}")
                    continue
            table.close()
        except Exception as e:
            print(f"Error al leer {dbf_path}: {e}")
        return sorted(observadores, key=lambda x: x.apellido)
