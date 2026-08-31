# Plan de Implementación: @Preview para Widgets

Este plan describe cómo añadir previsualizaciones (@Preview) a todos los widgets del proyecto para facilitar el desarrollo visual en el IDE.

## User Review Required

> [!IMPORTANT]
> Se añadirá una dependencia implícita de `package:flutter/widget_previews.dart`. Asegúrate de que tu entorno de Flutter (SDK) soporte este paquete. Dado que existe el directorio `.widget_preview`, asumimos que el sistema ya está configurado para esto.

> [!NOTE]
> Para widgets que requieren parámetros obligatorios sin valores por defecto, se proporcionarán datos de ejemplo ("dummy data") en la función de preview.

## Proposed Changes

### [Componentes Reutilizables]
Añadir previews a todos los widgets dentro de `lib/components/`.

#### [MODIFY] [button_widget.dart](file:///D:/multi-pos-1/lib/components/button/button_widget.dart)
#### [MODIFY] [stat_card_widget.dart](file:///D:/multi-pos-1/lib/components/stat_card/stat_card_widget.dart)
#### [MODIFY] [bottom_nav_widget.dart](file:///D:/multi-pos-1/lib/components/bottom_nav/bottom_nav_widget.dart)
*(Y el resto de archivos en `lib/components/`)*

### [Páginas]
Añadir previews a los widgets de pantalla completa en `lib/pages/`.

#### [MODIFY] [panel_principal_widget.dart](file:///D:/multi-pos-1/lib/pages/panel_principal/panel_principal_widget.dart)
#### [MODIFY] [punto_de_venta_widget.dart](file:///D:/multi-pos-1/lib/pages/punto_de_venta/punto_de_venta_widget.dart)
*(Y el resto de archivos en `lib/pages/`)*

## Verification Plan

### Manual Verification
1. Abrir el archivo modificado en Android Studio.
2. Verificar que aparezca el icono de "Preview" o el panel lateral de previsualización.
3. Confirmar que el widget se renderiza correctamente con los datos de ejemplo.
