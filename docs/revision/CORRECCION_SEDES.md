# Flujo controlados: revisión focalizada, 2026-09-06

Código vigente comparado con HUELLAS.csv: widget POS ya difería; modelo coincidía. Se conservaron los cambios locales previos.

Corregido: agregar N unidades invocaba N formularios y permitía incorporación parcial. Ahora agrega la cantidad en una operación del modelo. Se exigen los cuatro campos y se conservan en la fila del carrito; el detalle de venta envía receta_sedes. Se eliminó el segundo formulario al cobrar. Requiere ejecutar SEDES_PASOS.sql antes de usar la versión nueva.

Pendiente de verificación del servidor y dispositivo: iconos dependen de es_psicotropico en productos; no se reclasificaron medicamentos por nombre. La consulta FEFO comprueba existencia pero el código no asigna ese lote al carrito ni demuestra su descuento. processSale registra caja solo si encuentra sesión abierta y oculta errores de ese registro. No se certifica el paso 5. Consultar triggers con SEDES_PASOS.sql antes de cambiar descuentos o caja. Las llamadas actuales de venta no forman una transacción única.

Limitación: la receta se conserva por fila/producto; otra incorporación del mismo producto sustituye la receta de esa fila. No usar una misma fila para pacientes distintos. No se implementó un archivo legal de recetas ni se verificó normativa.

Validación manual pendiente: cantidad 3 abre un formulario; cada campo vacío impide confirmar; cancelar no agrega unidades; confirmar agrega 3; cobrar no repite formulario; verificar receta_sedes en ventas_detalle. Repetir prueba con caja abierta y revisar lote, stock y movimiento con los resultados del diagnóstico.

Comandos PowerShell desde D:\multi-pos-1:

```powershell
flutter analyze lib/pages/punto_de_venta lib/services/supabase_service.dart
flutter test
flutter build apk --release
adb install -r android/app/build/outputs/flutter-apk/app-release.apk
```

No se instaló APK ni se efectuaron ventas o cambios remotos durante esta revisión.
