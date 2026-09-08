# Mapa de trabajo de MultiPOS

Base auditada: 2026-09-05, checkout con cambios locales. Leer primero `INFORME_UI_UX.md`; consultar `HUELLAS.csv` antes de asumir que una observación sigue vigente.

## Entrada y dependencias

- `lib/main.dart`: inicializa Supabase, define MyApp, AppInitializerWidget y diez rutas GoRouter. El arranque consulta `empresa_id` en SharedPreferences.
- `lib/index.dart`: exportaciones de pantallas y utilidades.
- `lib/services/supabase_service.dart`: acceso activo a empresas, usuarios, productos, lotes, clientes, caja, ventas, devolución y métricas. Las pantallas lo invocan directamente o desde su modelo.
- `lib/database/database_helper.dart`: implementación SQLite extensa, sin consumidores encontrados en el código activo revisado. No confundir sus transacciones con las llamadas actuales a Supabase.
- `lib/database/inventory_initializer.dart`: biblioteca sintética por los cinco rubros; genera 150 entradas con variantes.
- `lib/services/open_food_facts_service.dart`: consulta externa de catálogo/código. Verificar pertinencia del resultado antes de alta; no usarlo como fuente de stock o precios reales.
- `lib/models/producto_model.dart`: producto con stock entero y atributos de farmacia.
- `lib/models/lote_model.dart`: lote, stock y vencimiento.
- `lib/flutter_flow/flutter_flow_theme.dart`: colores, tipografía y helper override; siempre devuelve LightModeTheme.
- `lib/flutter_flow/flutter_flow_util.dart`: utilidades, modelo base, formato Bs y navegación.

## Pantallas y puntos de intervención

Todos los paths de esta tabla son relativos a `lib/pages/`; cada carpeta tiene widget y model. La UI y mucha lógica están en el widget.

| Carpeta / ruta | Widget (líneas al auditar) | Métodos o dependencias principales | Revisar al modificar |
|---|---:|---|---|
| inicio_de_sesi_n / inicioDeSesion | 67 | LoginBackgroundWidget → LoginBackgroundChildWidget | Formulario y acceso viven en `components/login_background_child`. |
| registro_de_negocio / registroDeNegocio | 784 | FormFieldWidget, BusinessTypeCardWidget, registerFullBusiness | SelectedBusinessType, preferencias, cierre de app tras registro. |
| panel_principal / panelPrincipal | 796 | _loadData, modelo.fetchDashboardMetrics | Indicadores reales frente a tarjetas constantes; nav y ancho 480. |
| punto_de_venta / puntoDeVenta | 2376 | _loadInitialProducts, _handleAddToCart, _updateCartItemUnidad, _showCatalogModal, _showAddManualItemDialog, _handleScan, _handleCheckout | PosCartItem en model; payload a processSale; unidades/lotes y borrador. |
| inventario_de_productos / inventarioDeProductos | 1394 | _initColumns, _showKardexDialog, _showLotesDialog, _loadData, _showAddProductDialogWithData, _handleScan, _showEditDialog, _handleDelete, _handleCellChange, _onSearchChanged | PlutoGrid, conversión Producto, cambios de stock y errores de servicio. |
| gesti_n_de_caja / gestionDeCaja | 691 | _loadCajaData, _handleAbrirCaja, _handleCerrarCaja, _handleRegistrarMovimiento | Sesión activa y movimientos, _montoEsperado, caja_sesión_id en servicio. |
| historial_de_ventas / historialDeVentas | 677 | _loadVentas, _handleAnularVenta | Búsqueda no conectada; tocar venta abre anulación. |
| clientes_y_cr_ditos / clientesYCreditos | 782 | _loadClientes, _totalPorCobrar, _handleAgregarCliente, _handleAbono | Búsqueda no conectada; tocar cliente abre abono; manejo excedente. |
| reportes_y_m_tricas / reportesYMetricas | 925 | _loadMetrics, _showLineChartModal, _showPieChartModal, _getTopSellersForSector | Rango real, gráficos fijos, Generar sin callback, ancho 480. |
| configuraci_n_y_empresas / configuracionYEmpresas | 1169 | _loadEmpresaActiva, _showEmpleadosDialog | Empresa única visible; targets pendientes; prefs.clear al salir. |

## Componentes compartidos

- `components/bottom_nav`: contenedor con SafeArea; `bottom_nav_child`, `child2`…`child5` y `child3/4` configuran diferentes selecciones de navegación. Consolidar en una definición.
- `components/nav_item`: navegación goNamed, selección recibida y etiquetas con FittedBox/maxLines 1. Las capturas antiguas con texto cortado no prueban un fallo vigente.
- `components/button`: callback `onTap`, loading y disabled; sin callback puede existir aspecto de botón sin acción.
- `components/text_field`: callback se llama `onChange`, no `onChanged`; modelo propio o inyectado; altura 40. El parámetro `onSubmit` es String, no callback de envío.
- `components/settings_tile`: callback o destino; ignora target vacío y 'Target'.
- `components/stat_card`, `metric_card`, `credit_stat`, `inventory_stat`, `cash_stat`, `history_stat`: presentación de cifras; revisar de dónde llegan los valores.
- `components/client_card`, `sale_row`, `product_item`, `product_search_item`, `cart_item`: presentación; comprobar uso real antes de modificar, porque parte de las pantallas construye filas directamente.

## Flujo de datos operativo

Preferencias → empresa_id → servicio → mapa/Producto/Lote → estado de pantalla → widgets.

POS: catálogo → PosCartItem → _handleCheckout → processSale → ventas + ventas_detalle (+ clientes/movimientos_credito si CREDITO). El detalle actual no transporta unidad/lote, descripción manual ni pagos desglosados.

Caja: getCajaAbierta → fetchMovimientosCaja → suma de movimientos → abrir/cerrar/insertar movimiento. Verificar conexión servidor entre venta y caja.

Crédito: cliente.deuda → processAbonoCredito → actualizar deuda e insertar movimiento_credito. La actualización de caja no aparece aquí.

## Método para continuar sin releer todas las pantallas

1. Buscar el módulo en esta tabla y el hallazgo Fxx del informe.
2. Comparar SHA256 actual con `HUELLAS.csv`. El commit no basta porque existen cambios locales.
3. Consultar símbolos y etiquetas en `INDICE_CODIGO.md`; usar `rg -n` para localizar el método vigente.
4. Leer solo el método, sus modelos y componentes/servicio afectados. Revisar callers y tests relevantes.
5. Tras modificar, actualizar observación, índice y huellas de los archivos afectados. Las huellas son una referencia histórica, no instrucciones para reemplazar archivos.

Fuera del árbol activo: `clean-main-temp`, `clean-main-verify`, `repo_temp`, `repo_flutter`, `multi_POS_V_dart` y artefactos generados no se tomaron como fuente de verdad. No borrarlos sin aclarar su uso. El README inicial es genérico.

Actualización focalizada SEDES (2026-09-06): ver [CORRECCION_SEDES.md](CORRECCION_SEDES.md) y [SEDES_PASOS.sql](SEDES_PASOS.sql). Corrección local de cantidad/formulario/payload; FEFO y caja pendientes de verificar en servidor.
