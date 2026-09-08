# Prueba real de venta demo en TECNO LJ7

## Alcance autorizado

El usuario autorizó simular el flujo de farmacia hasta guardar una venta. Sus cinco empresas en Supabase son demos para futuros clientes de distintos rubros. La prioridad es preservar el comportamiento existente al reorganizar el POS; no crear un selector multiempresa como requisito inmediato ni cambiar reglas, esquema o triggers durante esta prueba.

Prueba realizada mediante la UI Android existente, usando ADB en el TECNO LJ7 autorizado. Paquete: `com.example.multi_p_o_s`. No se instaló otra compilación ni se modificó el código de la app. La correspondencia exacta entre el APK instalado y el checkout no está certificada.

## Operación realizada

- Empresa confirmada en Ajustes: FARMA-ONE, Farmacia. ID 9 confirmado mediante lectura de Supabase.
- Producto: Paracetamol Inti 500mg (Lote #198).
- ID producto: 22802. Código: 555100000198.
- Stock visible antes: 60.
- Se buscó `para` en el catálogo, se eligió el producto y se agregó cantidad 1.
- Se abrió la fila del carrito y se observaron las tres presentaciones: Caja Bs. 65,31; Blíster Bs. 653,10; Pastilla Bs. 65,31.
- Se volvió a **Caja** y se mantuvo cantidad 1, sin editar el precio.
- Cobro en efectivo: total Bs. 65,31, recibido simulado Bs. 100, vuelto mostrado Bs. 34,69.
- Se pulsó Confirmar y Cobrar una sola vez.
- Resultado UI: “¡Venta #4 realizada con éxito! (EFECTIVO)”. Carrito vacío después de guardar.
- Historial: folio **V-000004**, EFECTIVO, COMPLETADA.
- Se dejó la app en Historial. No se anuló ni eliminó la venta ni se repuso stock: permanece como prueba autorizada en la demo.

## Verificación de persistencia (solo lectura)

| Entidad | Resultado observado |
|---|---|
| ventas | ID 4, empresa 9, subtotal/total 65.31, EFECTIVO, COMPLETADA. |
| ventas_detalle | ID 5, venta 4, producto 22802, cantidad 1, precio 65.31, subtotal 65.31, empresa 9. |
| productos | Stock posterior 59, frente a 60 observado antes en catálogo. |
| movimientos_inventario | ID 5, tipo VENTA, cantidad 1, motivo “Venta registrada #4”, empresa 9, producto 22802. |
| producto_lotes | La consulta con la misma clave pública que usa la app, filtrada por empresa 9/producto 22802, devolvió cero filas visibles. |
| movimientos_caja | Consulta filtrada por empresa 9 devolvió cero filas visibles. No se certifica movimiento de caja para esta venta. |

Fecha almacenada de venta: `2026-09-05T23:05:20.029985+00:00`. Fecha del movimiento de inventario: `2026-09-06T03:05:20.402113+00:00`. Existe una diferencia de cuatro horas entre registros de la misma operación; revisar tratamiento de zona horaria por separado. No se corrigió.

Las consultas REST se hicieron con las credenciales ya configuradas en el servicio, sin copiarlas a documentación. Una respuesta vacía describe la visibilidad de esa consulta; no sustituye inspeccionar esquema, políticas o triggers con acceso administrativo. La primera búsqueda de producto por código también devolvió una entrada con empresa nula; se descartó y la verificación posterior quedó limitada a empresa 9/producto 22802.

## Qué demuestra y qué no

**Demostrado:** búsqueda en catálogo → selección de cantidad → carrito → cambio visual de presentación/precio → cobro → persistencia de cabecera y detalle → descuento de stock → movimiento de inventario → historial. Una venta por caja funciona por este recorrido.

**No demostrado:** validación FEFO por escaneo, consumo de un lote concreto, bloqueo de vencidos, cobro final por blíster/pastilla, receta de productos controlados, pagos mixtos, devoluciones, impresión ni cierre de caja. No afirmar que una sola venta valida todas las características de farmacia.

## Hallazgos para revisar sin mezclar con la refactorización

1. **Catálogo y escáner siguen rutas distintas en el código revisado.** En `punto_de_venta_widget.dart:469`, el catálogo llama `_model.addProductoToCart(p)` directamente. `_handleAddToCart` (línea 60) consulta lote FEFO y es invocado por el escáner en otras rutas. La venta por catálogo no demuestra que haya pasado FEFO. El texto “Lote #198” forma parte del nombre del producto; no demuestra relación con una fila de `producto_lotes`.
2. **Presentaciones visibles pese a fraccionamiento desactivado.** Producto 22802: `permite_fraccionamiento=false`, `unidades_por_caja=1`, `unidades_por_blister=10`. Los precios observados coinciden con esos factores y la fórmula actual. La UI muestra Caja/Blíster/Pastilla por tipo Farmacia sin condicionar por `permiteFraccionamiento`. Resolver reglas/datos en un cambio explícito posterior; no modificar silenciosamente durante extracción de widgets.
3. **Caja pendiente de verificación.** Venta y kardex sí se observaron; no apareció movimiento de caja visible. No confundir éxito de venta con conciliación de caja demostrada.
4. **UX observada:** el nombre del medicamento se trunca en carrito; el texto largo del medio de pago excede visualmente su campo; la tarjeta de historial no deja ver un importe en el viewport capturado. Estos detalles sí tienen evidencia del APK actual.
5. **Estados transitorios:** inmediatamente después de navegar, aparecieron valores por defecto antes de cargar FARMA-ONE y sus métricas. Esperar datos antes de interpretar ceros o “Comercial” como estado real. Capturas tomadas durante transición no sirven como resultado final.

## Evidencias locales

- `.artifacts/farmacia-antes.png`: búsqueda y stock inicial.
- `.artifacts/farmacia-blister.png`, `farmacia-pastilla.png`, `farmacia-caja.png`: presentaciones.
- `.artifacts/farmacia-cobro.png`, `farmacia-vuelto.png`: cobro y vuelto.
- `.artifacts/farmacia-resultado.png`: confirmación de venta #4.
- `.artifacts/farmacia-panel-despues.png`, `farmacia-historial.png`: consulta posterior.

## Aplicación a la siguiente optimización

Esta prueba es una línea base parcial. Extraer primero widgets de presentación manteniendo callbacks, cálculos y payloads. No unificar automáticamente los caminos de catálogo/escáner porque cambiaría el comportamiento actual. Antes de tocar la lógica de farmacia, completar un caso con producto realmente configurado para fraccionamiento y lotes visibles. Separar cualquier corrección funcional de la reorganización estructural.
