# AGENTS.md

## Propósito del Proyecto

Desarrollar una **aplicación de escritorio** con **interfaz gráfica (GUI)** basada en **PySide6 (Qt para Python)**, enfocada en la **manipulación y visualización de datos**.
El sistema debe mantener un diseño moderno, modular, limpio y robusto, siguiendo principios de arquitectura limpia y buenas prácticas de ingeniería de software.

---

## Stack Tecnológico

* **Framework de UI:** PySide6 (Qt para Python)
* **Manejo de datos:** Pandas y NumPy
* **Distribución:** PyInstaller (generar binarios ejecutables multiplataforma)
* **Lenguaje:** Python 3.11+
* **Testing:** `pytest` o `unittest`
* **Formateo:** `black`, `flake8`, `isort`

---

## Arquitectura y Organización

El agente debe adherirse estrictamente a una estructura basada en **Clean Architecture**, adaptada al contexto Qt/PySide6.
Cada capa debe tener responsabilidades claramente definidas:

```
/src
  /ui               → ventanas, widgets, QSS, layouts
  /domain           → lógica de negocio, validaciones
  /data             → persistencia, acceso a archivos, manejo de DataFrames
  /tests            → pruebas unitarias y de integración
  /resources        → íconos, QSS, temas, assets
```

**Principios Clave:**

* Separación clara entre presentación, dominio y datos.
* Sin dependencias cruzadas entre capas.
* Aplicar SOLID en el diseño de clases y módulos.
* Mantener independencia del framework (PySide6 solo en capa UI).

---

## Estilo de Interfaz (UI/UX)

**Objetivo:** lograr una experiencia visual moderna inspirada en **Material Design 3 (M3)**, sin depender de librerías externas.

**Directrices:**

* **Estética general:** bordes redondeados, sombras sutiles, y jerarquía visual clara.
* **Colores:** paleta limitada coherente (primario, secundario, fondo, superficie).
* **Tipografía:** limpia, legible y consistente.
* **Temas Claro / Oscuro:** el sistema debe soportar alternancia dinámica.

  * Los archivos QSS deben estructurarse por tema (`light.qss`, `dark.qss`).
  * Todo cambio de estilo debe reflejarse en ambos temas.
* **Layouts:** usar exclusivamente `QVBoxLayout`, `QHBoxLayout`, `QGridLayout`.
  Prohibido el uso de posicionamiento absoluto (`.move()`, `.setGeometry()`) salvo excepciones justificadas.

---

## Lineamientos de Código

* Seguir principios de **Clean Code**.
* Nombrado **descriptivo y semántico** (sin abreviaturas innecesarias).
* Incluir **type hints** completos.
* Documentar todas las funciones y clases públicas con **docstrings** (formato Google o NumPy).
* Evitar duplicación de lógica; crear funciones utilitarias reutilizables.
* No incluir lógica de estilo en el código Python (debe estar en QSS).

---

## Pruebas y Robustez

* Todo módulo con lógica de negocio o manipulación de datos debe tener **tests unitarios**.
* Usar `pytest` como estándar (o `unittest` si ya está en uso).
* Los tests deben cubrir:

  * Casos nominales.
  * Casos límite.
  * Comportamientos esperados frente a errores.
* **Manejo de errores:**

  * Prohibido usar `except:` sin especificar excepción.
  * Registrar errores con `logging` o mediante diálogo en UI según el caso.
  * Evitar fallas silenciosas.

---

## Documentación Interna

* Mantener documentación técnica bajo `/docs`, incluyendo:

  * `architecture.md`: descripción general de módulos y flujo de datos.
  * `ui-guidelines.md`: convenciones de interfaz.
  * `data-model.md`: descripción de estructuras de datos y formatos de entrada/salida.
* Cada módulo nuevo debe incluir al menos un resumen descriptivo en su docstring principal.

---

## Estilo de Desarrollo

* Formatear código con `black` y ordenar imports con `isort`.
* Pasar `flake8` antes de cada commit.
* Respetar convenciones de commits (`feat`, `fix`, `refactor`, `chore`, etc.).
* Usar un flujo de trabajo **plan → apply → verify**:

  1. Proponer un plan de implementación.
  2. Aplicar cambios.
  3. Verificar mediante tests y revisión automática.

---

## Reglas del Agente

1. Antes de generar código nuevo, **revisar y usar** estructuras o patrones existentes.
2. Priorizar claridad, mantenibilidad y coherencia sobre brevedad.
3. Sugerir mejoras de diseño o refactor cuando detecte inconsistencias.
4. Al crear nuevos módulos o clases:

   * Documentarlos completamente.
   * Proveer un ejemplo mínimo de uso.
   * Incluir test de validación.

---

## Tareas Permitidas al Agente

* Crear o extender módulos en las capas `ui`, `domain` o `data`.
* Generar templates base para nuevas ventanas o widgets en PySide6.
* Agregar o mejorar tests unitarios.
* Refactorizar código siguiendo las reglas anteriores.
* Optimizar operaciones con Pandas o NumPy sin romper compatibilidad.

---

## Referencias para Contexto

* `@docs/architecture.md`
* `@docs/ui-guidelines.md`
* `@docs/data-model.md`

---

## En Resumen de Intención

El agente debe actuar como **colaborador técnico experto**, siguiendo estándares de ingeniería y asegurando consistencia entre UI, dominio y datos.
Debe escribir código elegante, documentado y verificable, manteniendo coherencia con los lineamientos de arquitectura definidos en este documento.
