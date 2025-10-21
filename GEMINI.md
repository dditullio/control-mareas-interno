# Directrices de Configuración de Agente Gemini para Proyectos Python/PySide6

Este documento establece las directrices fundamentales y las restricciones de diseño que el Agente Gemini Code Assist debe seguir al asistir en el desarrollo de código para este proyecto.

## 1. Stack Tecnológico y Contexto

El proyecto se basa en el siguiente stack principal:
* **Framework de UI:** PySide6 (Qt para Python).
* **Manejo de Datos:** Pandas y NumPy.
* **Distribución:** PyInstaller.
* **Objetivo:** Desarrollar una aplicación de escritorio con interfaz gráfica (GUI) que manipule y visualice datos.

## 2. Estilo de Diseño de Interfaz de Usuario (UI)

La GUI debe seguir un estándar de diseño moderno y profesional.

* **Estética:** Implementar un diseño visual que emule la estética **Material Design 3** (M3) de Google. Esto incluye:
    * Uso de sombras sutiles (elevación).
    * Bordes redondeados en widgets principales.
    * Una paleta de colores coherente y limitada (primario, secundario, fondo, superficie, etc.).
    * Tipografía limpia y legible.
* **Estilizado (QSS):** La personalización visual debe implementarse rigurosamente mediante **Hojas de Estilo Qt (QSS)**. El código Python debe ser responsable de la lógica, no del estilo.
* **Tema Claro/Oscuro:** Es obligatorio incluir la funcionalidad para cambiar entre un **Tema Claro** y un **Tema Oscuro**. El diseño QSS debe ser modular para soportar esta alternancia de forma dinámica.
    * **Consistencia de Estilos:** Cada vez que se realice algún cambio en la UI que implique estilos, el cambio debe hacerse tanto para el modo claro como para el modo oscuro.
* **Diseño Responsivo:** Usar **Layouts (QLayouts)** exclusivamente (e.g., `QVBoxLayout`, `QHBoxLayout`, `QGridLayout`) para organizar los widgets. **Queda prohibido** el uso de posicionamiento absoluto (`.move()` o `.setGeometry()`) a menos que sea estrictamente necesario y justificado para un widget específico y simple.

## 3. Arquitectura y Calidad de Código

La calidad, legibilidad y mantenibilidad del código son la máxima prioridad.

* **Principios de Ingeniería de Software:** Estructurar el código, los módulos y las clases adhiriéndose a principios de **Clean Code** y **Clean Architecture** (o similar, como MVC, MVVM o MVP adaptado a Qt) para una separación clara de responsabilidades:
    * **UI/Presentación:** Lógica de la interfaz.
    * **Dominio/Negocio:** Reglas de la aplicación.
    * **Infraestructura/Datos:** Persistencia, acceso a archivos (Pandas/NumPy), o servicios externos.
* **Principios SOLID:** Aplicar los principios SOLID (Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion) en el diseño de clases y módulos, especialmente en la capa de negocio.
* **Legibilidad y Mantenibilidad:**
    * Utilizar nombres de variables, funciones y clases que sean **descriptivos y semánticos**.
    * Incluir **Type Hinting** completo en todas las funciones y métodos.
    * Añadir **Docstrings** siguiendo el formato NumPy o Google para documentar módulos, clases y funciones públicas.

## 4. Pruebas y Robustez

El agente debe enfocarse en código robusto y verificable.

* **Pruebas Unitarias:** Al desarrollar lógica de negocio compleja, funciones de manipulación de datos (Pandas/NumPy) o componentes de servicios, el agente **debe proponer** la creación de tests unitarios (utilizando `unittest` o `pytest`) para verificar su correcto funcionamiento y validar los casos límite.
* **Manejo de Errores:** Implementar manejo de excepciones explícito y claro, evitando el uso de *bare excepts* (`except:`) y registrando o reportando los errores de manera adecuada.