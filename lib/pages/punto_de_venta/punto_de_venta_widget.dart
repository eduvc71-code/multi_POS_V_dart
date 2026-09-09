import 'package:permission_handler/permission_handler.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:multi_p_o_s/models/producto_model.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multi_p_o_s/database/inventory_initializer.dart';
import 'package:multi_p_o_s/services/open_food_facts_service.dart';
import 'package:multi_p_o_s/services/supabase_service.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'punto_de_venta_model.dart';
export 'punto_de_venta_model.dart';

@Preview()
Widget previewPuntoDeVenta() {
  return const PuntoDeVentaWidget();
}

class PuntoDeVentaWidget extends StatefulWidget {
  const PuntoDeVentaWidget({super.key});

  static String routeName = 'PuntoDeVenta';
  static String routePath = '/puntoDeVenta';

  @override
  State<PuntoDeVentaWidget> createState() => _PuntoDeVentaWidgetState();
}

class _PuntoDeVentaWidgetState extends State<PuntoDeVentaWidget> {
  late PuntoDeVentaModel _model;
  int? _expandedRowIndex;
  String _empresaTipo = 'Tienda';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // ✅ VARIABLES PARA RECONOCIMIENTO DE VOZ
  final _speech = SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PuntoDeVentaModel());
    _loadInitialProducts();
  }

  Future<void> _loadInitialProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? 1;
    final empresa = await SupabaseService.instance.getEmpresa(empresaId);
    if (empresa != null) {
      _empresaTipo = (empresa['tipo'] ?? 'Tienda').toString().trim().toLowerCase();
    }
    await _model.searchProducts('');
    if (mounted) {
      setState(() {});
    }
  }

  // ✅ CAPTURA DE DATOS DEL LOTE FEFO PARA EL CARRITO
  Future<void> _handleAddToCart(Producto producto) async {
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? 1;

    int? loteIdAsignado;
    String? numeroLoteAsignado;
    String? fechaVencimientoAsignada;

    if (_empresaTipo == 'farmacia' && producto.id != null) {
      final loteFEFO = await SupabaseService.instance.readLoteFEFOActivo(producto.id!, empresaId);

      if (loteFEFO == null || loteFEFO.esVencido) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              loteFEFO != null && loteFEFO.esVencido
                  ? '🔴 MEDICAMENTO VENCIDO (Lote ${loteFEFO.numeroLote}): Venta bloqueada.'
                  : '🔴 SIN LOTE ACTIVO VIGENTE: Registre un lote no vencido en Inventario.',
            ),
            backgroundColor: FlutterFlowTheme.of(context).error,
          ),
        );
        return;
      }

      loteIdAsignado = loteFEFO.id;
      numeroLoteAsignado = loteFEFO.numeroLote;

      // ✅ CORRECCIÓN: Convertir DateTime a String de forma segura
      fechaVencimientoAsignada = loteFEFO.fechaVencimiento != null
          ? loteFEFO.fechaVencimiento.toString().split(' ')[0]
          : 'N/A';
    }

    final error = _model.addProductoToCart(
      producto,
      loteId: loteIdAsignado,
      numeroLote: numeroLoteAsignado,
      fechaVencimiento: fechaVencimientoAsignada,
    );

    if (error.isNotEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: FlutterFlowTheme.of(context).error),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✓ ${producto.nombre} agregado al carrito'),
          duration: const Duration(milliseconds: 700),
          behavior: SnackBarBehavior.floating,
        ),
      );
      setState(() {});
    }
  }

  Future<void> _updateCartItemUnidad(PosCartItem item, String unidad) async {
    item.unidadVenta = unidad;
    if (item.productoId != null) {
      final prefs = await SharedPreferences.getInstance();
      final empresaId = prefs.getInt('empresa_id') ?? 1;
      final catalogoCompleto = await SupabaseService.instance.readAllProductos(empresaId);

      final p = catalogoCompleto.firstWhere(
            (prod) => prod.id == item.productoId,
        orElse: () => Producto(
          codigo: '', nombre: '', precio: item.precioUnitario,
          costo: 0, stock: 0, stockMinimo: 12,
        ),
      );
      if (unidad == PosCartItem.TIPO_CAJA) {
        item.precioUnitario = p.precio;
      } else if (unidad == PosCartItem.TIPO_BLISTER) {
        final uCaja = p.unidadesPorCaja <= 0 ? 1 : p.unidadesPorCaja;
        final uBlister = p.unidadesPorBlister <= 0 ? 10 : p.unidadesPorBlister;
        item.precioUnitario = (p.precio / uCaja) * uBlister;
      } else if (unidad == PosCartItem.TIPO_PASTILLA) {
        final uCaja = p.unidadesPorCaja <= 0 ? 1 : p.unidadesPorCaja;
        item.precioUnitario = p.precio / uCaja;
      }
    }
    if (mounted) setState(() {});
  }

  // ✅ FUNCIÓN DE VOZ CON SOLICITUD DE PERMISO AUTOMÁTICA
  Future<void> _handleVoiceManualItem() async {
    final tiposPermitidosVoz = ['tienda', 'ferreteria', 'autopartes', 'motopartes'];
    if (!tiposPermitidosVoz.contains(_empresaTipo)) return;

    // 1. SOLICITAR PERMISO AL USUARIO (Igual que el escáner)
    var status = await Permission.microphone.request();

    if (status.isDenied) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de micrófono denegado.'), backgroundColor: Colors.red),
      );
      return;
    }

    if (status.isPermanentlyDenied) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso denegado permanentemente. Habilítalo en Ajustes.'), backgroundColor: Colors.orange),
      );
      openAppSettings();
      return;
    }

    // 2. INICIAR EL MICRÓFONO
    final bool available = await _speech.initialize(
      onStatus: (val) => debugPrint('Estado micrófono: $val'),
      onError: (val) => debugPrint('Error micrófono: $val'),
    );

    if (!available) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Micrófono no disponible.'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isListening = true);

    _speech.listen(
      onResult: (val) async {
        if (val.finalResult) {
          setState(() => _isListening = false);
          String spokenText = val.recognizedWords.trim();
          if (spokenText.isNotEmpty) {
            _showAddManualItemDialog(preFilledName: spokenText);
          }
        }
      },
      listenFor: const Duration(seconds: 5),
      pauseFor: const Duration(seconds: 3),
      listenOptions: SpeechListenOptions(partialResults: true),
      localeId: 'es_BO',
    );
  }

  Future<void> _showCatalogModal() async {
    final searchCtrl = TextEditingController();
    List<Producto> filteredProducts = [];
    PlutoGridStateManager? stateManager;

    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (sheetCtx, setSheetState) {
            final bottomInset = MediaQuery.of(sheetCtx).viewInsets.bottom;

            final List<PlutoColumn> columns = [
              PlutoColumn(title: 'Código', field: 'codigo', type: PlutoColumnType.text(), width: 100, enableEditingMode: false),
              PlutoColumn(title: 'Producto', field: 'nombre', type: PlutoColumnType.text(), width: 250, enableEditingMode: false),
              PlutoColumn(title: 'Stock', field: 'stock', type: PlutoColumnType.number(), width: 80, enableEditingMode: false, textAlign: PlutoColumnTextAlign.center),
              PlutoColumn(title: 'Precio (Bs.)', field: 'precio', type: PlutoColumnType.currency(symbol: 'Bs. '), width: 100, enableEditingMode: false, textAlign: PlutoColumnTextAlign.right),
            ];

            final List<PlutoRow> rows = filteredProducts.map((p) {
              return PlutoRow(cells: {
                'codigo': PlutoCell(value: p.codigo),
                'nombre': PlutoCell(value: p.nombre),
                'stock': PlutoCell(value: p.stock),
                'precio': PlutoCell(value: p.precio),
                'producto_raw': PlutoCell(value: p),
              });
            }).toList();

            return Padding(
              padding: EdgeInsets.only(bottom: bottomInset),
              child: Container(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(sheetCtx).size.height * 0.85),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(margin: const EdgeInsets.only(top: 8), width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(_empresaTipo == 'farmacia' ? Icons.local_hospital_rounded : Icons.grid_view_rounded, color: _empresaTipo == 'farmacia' ? Colors.red : const Color(0xFF0066FF), size: 20),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    _empresaTipo == 'farmacia' ? 'Catálogo Farmacéutico' : 'Catálogo de Inventario',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: FlutterFlowTheme.of(context).primaryText),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: const Color(0xFF0066FF).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                            child: Text('🛒 En Cobro: ${_model.totalItemsCount} u.', style: const TextStyle(color: Color(0xFF0066FF), fontWeight: FontWeight.bold, fontSize: 11)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: searchCtrl,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Escriba cualquier letra o producto...',
                          prefixIcon: const Icon(Icons.search_rounded),
                          suffixIcon: searchCtrl.text.isNotEmpty
                              ? IconButton(icon: const Icon(Icons.clear_rounded), onPressed: () { searchCtrl.clear(); setSheetState(() => filteredProducts.clear()); })
                              : null,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          isDense: true,
                        ),
                        onChanged: (q) async {
                          if (q.trim().isEmpty) {
                            setSheetState(() => filteredProducts.clear());
                          } else {
                            await _model.searchProducts(q);
                            setSheetState(() => filteredProducts = _model.searchResults);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: searchCtrl.text.trim().isEmpty
                          ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.manage_search_rounded, size: 48, color: Colors.grey.shade400),
                            const SizedBox(height: 8),
                            const Text('Escriba cualquier letra para buscar productos', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13)),
                          ]),
                        ),
                      )
                          : filteredProducts.isEmpty
                          ? const Center(child: Padding(padding: EdgeInsets.all(24.0), child: Text('No hay productos coincidentes.', style: TextStyle(color: Colors.grey))))
                          : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: PlutoGrid(
                          columns: columns,
                          rows: rows,
                          onLoaded: (PlutoGridOnLoadedEvent event) {
                            stateManager = event.stateManager;
                            stateManager?.setShowColumnFilter(true);
                          },
                          onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) async {
                            final p = event.row.cells['producto_raw']?.value as Producto;
                            final selectedQty = await showDialog<int>(
                              context: context,
                              builder: (popupCtx) {
                                int qty = 1;
                                return StatefulBuilder(
                                  builder: (popupCtx, setQtyState) => AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    title: Row(
                                      children: [
                                        Expanded(child: Text(p.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                        if (p.requiereReceta || p.esPsicotropico) const Icon(Icons.lock_rounded, color: Colors.red, size: 20),
                                      ],
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Precio: Bs. ${p.precio.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context).primary)),
                                        const SizedBox(height: 12),
                                        const Text('Cantidad a Vender:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconButton(icon: const Icon(Icons.remove_circle_outline_rounded, size: 32, color: Colors.red), onPressed: () { if (qty > 1) setQtyState(() => qty--); }),
                                            Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
                                            IconButton(icon: const Icon(Icons.add_circle_outline_rounded, size: 32, color: Colors.green), onPressed: () { if (qty < p.stock) setQtyState(() => qty++); }),
                                          ],
                                        ),
                                        if (qty >= p.stock) Padding(padding: const EdgeInsets.only(top: 4.0), child: Text('Stock máximo disponible: ${p.stock} u.', style: const TextStyle(color: Colors.orange, fontSize: 11))),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(popupCtx, null), child: const Text('Cancelar')),
                                      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0066FF), foregroundColor: Colors.white), onPressed: () => Navigator.pop(popupCtx, qty), child: const Text('Agregar Producto')),
                                    ],
                                  ),
                                );
                              },
                            );

                            if (selectedQty != null) {
                              for (int i = 0; i < selectedQty; i++) {
                                _handleAddToCart(p);
                              }
                              setState(() {});
                              if (sheetCtx.mounted) Navigator.pop(sheetCtx);
                            } else {
                              searchCtrl.clear();
                              setSheetState(() => filteredProducts.clear());
                            }
                          },
                          configuration: const PlutoGridConfiguration(
                            style: PlutoGridStyleConfig(
                              enableColumnBorderVertical: false,
                              enableColumnBorderHorizontal: true,
                              enableCellBorderVertical: false,
                              enableCellBorderHorizontal: true,
                              rowHeight: 45,
                              gridBorderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showAddManualItemDialog({String? preFilledName}) async {
    final nombreCtrl = TextEditingController(text: preFilledName ?? '');
    final precioCtrl = TextEditingController();
    final cantidadCtrl = TextEditingController(text: '1');

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(preFilledName != null ? Icons.mic_rounded : Icons.add_shopping_cart_rounded, color: const Color(0xFF0066FF)),
            const SizedBox(width: 8),
            Text(preFilledName != null ? 'Agregar Ítem por Voz' : 'Agregar Ítem Manual', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nombreCtrl,
              autofocus: preFilledName != null,
              decoration: const InputDecoration(labelText: 'Nombre / Servicio / Concepto *', border: OutlineInputBorder(), isDense: true),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextField(controller: precioCtrl, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Precio Unit. (Bs.) *', border: OutlineInputBorder(), isDense: true))),
                const SizedBox(width: 8),
                Expanded(child: TextField(controller: cantidadCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Cantidad *', border: OutlineInputBorder(), isDense: true))),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx, false), child: const Text('Cancelar')),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: FlutterFlowTheme.of(context).primary, foregroundColor: Colors.white), onPressed: () => Navigator.pop(dialogCtx, true), child: const Text('Agregar a la Venta')),
        ],
      ),
    );

    if (confirm == true) {
      final p = double.tryParse(precioCtrl.text) ?? 0.0;
      final c = int.tryParse(cantidadCtrl.text) ?? 1;
      if (nombreCtrl.text.trim().isNotEmpty) {
        _model.addManualItemToCart(nombreCtrl.text.trim(), p, c);
        setState(() {});
      }
    }
  }

  Future<void> _handleScan() async {
    final code = await showDialog<String>(
      context: context,
      builder: (dialogCtx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(children: [Icon(Icons.qr_code_scanner_rounded, color: Color(0xFF0066FF), size: 20), SizedBox(width: 8), Text('Escanear Código', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))]),
                  IconButton(constraints: const BoxConstraints(), padding: const EdgeInsets.all(4), icon: const Icon(Icons.close_rounded, size: 20), onPressed: () => Navigator.pop(dialogCtx)),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 240,
                  height: 200,
                  child: MobileScanner(
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      if (barcodes.isNotEmpty) {
                        final String? code = barcodes.first.rawValue;
                        if (code != null && code.isNotEmpty) Navigator.pop(dialogCtx, code);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text('Apunte la cámara al código de barras', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );

    if (code != null && code.isNotEmpty) {
      final currentContext = context;
      final prefs = await SharedPreferences.getInstance();
      final empresaId = prefs.getInt('empresa_id') ?? 1;

      final productoDb = await SupabaseService.instance.readProductoByCodigo(code, empresaId);
      if (productoDb != null) {
        _handleAddToCart(productoDb);
      } else {
        final businessType = prefs.getString('selectedBusinessType') ?? 'Tienda';
        final productLib = InventoryInitializer.lookupProductInLibrary(code, businessType);

        if (productLib != null) {
          if (!currentContext.mounted) return;
          final confirm = await showDialog<bool>(
            context: currentContext,
            builder: (context) => AlertDialog(
              title: const Text('Producto de Librería'),
              content: Text('Se encontró "${productLib['nombre']}" en la librería de $businessType.\n\n¿Desea agregarlo al inventario y a la venta actual?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Agregar y Vender')),
              ],
            ),
          );
          if (confirm == true) {
            final nuevoProducto = Producto(nombre: productLib['nombre'], codigo: code, costo: 0.0, precio: 0.0, stock: 10, stockMinimo: 12);
            await SupabaseService.instance.createProducto(nuevoProducto, empresaId);
            final p = await SupabaseService.instance.readProductoByCodigo(code, empresaId);
            if (p != null) _handleAddToCart(p);
          }
        } else {
          if (!currentContext.mounted) return;
          ScaffoldMessenger.of(currentContext).showSnackBar(const SnackBar(content: Text('Buscando producto en Open Food Facts...'), duration: Duration(seconds: 2)));
          final offProduct = await OpenFoodFactsService.searchProductByBarcode(code);
          if (!currentContext.mounted) return;
          ScaffoldMessenger.of(currentContext).hideCurrentSnackBar();

          if (offProduct != null) {
            final confirm = await showDialog<bool>(
              context: currentContext,
              builder: (context) => AlertDialog(
                title: Text('Producto encontrado (${offProduct['origen'] ?? 'OFF'})'),
                content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Nombre: ${offProduct['nombre']}'),
                  if (offProduct['marca'] != null && offProduct['marca'].toString().isNotEmpty) Text('Marca: ${offProduct['marca']}'),
                  Text('Código: $code'),
                  const SizedBox(height: 8),
                  const Text('¿Desea agregarlo al inventario y a la venta actual?'),
                ]),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                  ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Agregar y Vender')),
                ],
              ),
            );
            if (confirm == true) {
              final nuevoProducto = Producto(nombre: offProduct['nombre'], codigo: code, costo: 0.0, precio: 0.0, stock: 10, stockMinimo: 12);
              await SupabaseService.instance.createProducto(nuevoProducto, empresaId);
              final p = await SupabaseService.instance.readProductoByCodigo(code, empresaId);
              if (p != null) _handleAddToCart(p);
            }
          } else {
            if (!currentContext.mounted) return;
            final confirm = await showDialog<bool>(
              context: currentContext,
              builder: (context) => AlertDialog(
                title: const Text('Producto no encontrado'),
                content: Text('El código $code no existe. ¿Desea agregarlo ahora?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                  ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Agregar')),
                ],
              ),
            );
            if (confirm == true) {
              final nombreController = TextEditingController();
              final costoController = TextEditingController();
              final precioController = TextEditingController();
              if (!currentContext.mounted) return;
              final nuevoProducto = await showDialog<Producto>(
                context: currentContext,
                builder: (context) => AlertDialog(
                  title: const Text('Nuevo Producto'),
                  content: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      TextField(controller: TextEditingController(text: code), decoration: const InputDecoration(labelText: 'Código'), enabled: false),
                      TextField(controller: nombreController, decoration: const InputDecoration(labelText: 'Nombre')),
                      TextField(controller: costoController, decoration: const InputDecoration(labelText: 'Costo'), keyboardType: TextInputType.number),
                      TextField(controller: precioController, decoration: const InputDecoration(labelText: 'Precio'), keyboardType: TextInputType.number),
                    ]),
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, Producto(nombre: nombreController.text, codigo: code, costo: double.tryParse(costoController.text) ?? 0.0, precio: double.tryParse(precioController.text) ?? 0.0, stock: 10, stockMinimo: 12));
                      },
                      child: const Text('Crear y Vender'),
                    ),
                  ],
                ),
              );
              if (nuevoProducto != null) {
                await SupabaseService.instance.createProducto(nuevoProducto, empresaId);
                final p = await SupabaseService.instance.readProductoByCodigo(code, empresaId);
                if (p != null) _handleAddToCart(p);
              }
            }
          }
        }
      }
    }
  }

  Future<void> _handleCheckout() async {
    final currentContext = context;
    if (_model.cartItems.isEmpty) {
      if (!currentContext.mounted) return;
      ScaffoldMessenger.of(currentContext).showSnackBar(const SnackBar(content: Text('El carrito de ventas está vacío')));
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? 1;

    if (_empresaTipo == 'farmacia') {
      showDialog(context: currentContext, barrierDismissible: false, builder: (ctx) => const PopScope(canPop: false, child: Center(child: CircularProgressIndicator(color: Colors.white))));
      final catalogoCompleto = await SupabaseService.instance.readAllProductos(empresaId);
      if (!mounted) return;
      Navigator.pop(context);

      final itemsRestringidos = _model.cartItems.where((item) {
        final producto = catalogoCompleto.firstWhere(
              (p) => p.id == item.productoId,
          orElse: () => Producto(codigo: '', nombre: item.nombre, precio: item.precioUnitario, costo: 0, stock: 0, stockMinimo: 0, requiereReceta: false, esPsicotropico: false),
        );
        return producto.requiereReceta == true || producto.esPsicotropico == true;
      }).toList();

      if (itemsRestringidos.isNotEmpty) {
        final recetaCtrl = TextEditingController();
        final ciCtrl = TextEditingController();
        final nombrePacienteCtrl = TextEditingController();
        final nombreMedicoCtrl = TextEditingController();
        final registroMedicoCtrl = TextEditingController();

        final recetaConfirmada = await showDialog<bool>(
          context: currentContext,
          barrierDismissible: false,
          builder: (ctx) => PopScope(
            canPop: false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Row(children: [Icon(Icons.medication_rounded, color: Colors.redAccent, size: 28), SizedBox(width: 8), Expanded(child: Text('⚠️ Venta con Receta Obligatoria', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))]),
              content: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('El carrito contiene medicamentos controlados. Según normativa Vigente, es obligatorio registrar los datos de la receta retenida:', style: TextStyle(fontSize: 12, color: Colors.black87)),
                  const SizedBox(height: 16),
                  const Text('📋 DATOS DE LA RECETA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue)),
                  const SizedBox(height: 8),
                  TextField(controller: recetaCtrl, decoration: const InputDecoration(labelText: 'Nro. de Receta Médica *', border: OutlineInputBorder(), isDense: true)),
                  const SizedBox(height: 12),
                  TextField(controller: nombreMedicoCtrl, decoration: const InputDecoration(labelText: 'Nombre del Médico *', border: OutlineInputBorder(), isDense: true)),
                  const SizedBox(height: 12),
                  TextField(controller: registroMedicoCtrl, decoration: const InputDecoration(labelText: 'Registro Profesional del Médico *', border: OutlineInputBorder(), isDense: true)),
                  const SizedBox(height: 16),
                  const Text('👤 DATOS DEL PACIENTE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue)),
                  const SizedBox(height: 8),
                  TextField(controller: nombrePacienteCtrl, decoration: const InputDecoration(labelText: 'Nombre Completo del Paciente *', border: OutlineInputBorder(), isDense: true)),
                  const SizedBox(height: 12),
                  TextField(controller: ciCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'C.I. del Paciente *', border: OutlineInputBorder(), isDense: true)),
                ]),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar Venta', style: TextStyle(color: Colors.red))),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                  onPressed: () {
                    if (recetaCtrl.text.trim().isEmpty || ciCtrl.text.trim().isEmpty || nombreMedicoCtrl.text.trim().isEmpty || registroMedicoCtrl.text.trim().isEmpty) {
                      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('Todos los campos marcados con * son obligatorios por ley.'), backgroundColor: Colors.red));
                      return;
                    }
                    Navigator.pop(ctx, true);
                  },
                  child: const Text('Validar y Continuar'),
                ),
              ],
            ),
          ),
        );

        if (recetaConfirmada != true) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Venta cancelada: Se requiere receta médica válida y retenida para medicamentos controlados.'), backgroundColor: Colors.red, duration: Duration(seconds: 4)));
          return;
        }
      }
    }

    String selectedMetodo = 'EFECTIVO';
    final clientes = await SupabaseService.instance.readAllClientes(empresaId);
    int? selectedClienteId = clientes.isNotEmpty ? clientes.first['id'] : null;
    final montoRecibidoCtrl = TextEditingController(text: _model.total.toStringAsFixed(2));
    final comprobanteCtrl = TextEditingController();
    String? comprobanteFotoPath;

    if (!mounted) return;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (dialogCtx, setStateDialog) {
            final double totalVenta = _model.total;
            final double recibido = double.tryParse(montoRecibidoCtrl.text) ?? totalVenta;
            final double cambio = recibido >= totalVenta ? recibido - totalVenta : 0.0;

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              titlePadding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              title: const Row(children: [Icon(Icons.point_of_sale_rounded, color: Color(0xFF0066FF), size: 22), SizedBox(width: 8), Text('Procesar Cobro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF0066FF), Color(0xFF3B82F6)]), borderRadius: BorderRadius.circular(12)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Text('TOTAL A COBRAR', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                        Text('Bs. ${totalVenta.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                      ]),
                      Text('${_model.totalItemsCount} ítems', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: selectedMetodo,
                    decoration: const InputDecoration(labelText: 'Forma de Pago', border: OutlineInputBorder(), isDense: true),
                    items: const [
                      DropdownMenuItem(value: 'EFECTIVO', child: Text('💵 Efectivo (Calculadora de Vueltas)')),
                      DropdownMenuItem(value: 'TRANSFERENCIA', child: Text('📲 Transferencia QR / Banco')),
                      DropdownMenuItem(value: 'QR_EFECTIVO', child: Text('💵📲 QR + Efectivo')),
                      DropdownMenuItem(value: 'TARJETA', child: Text('💳 Tarjeta Débito / Crédito')),
                      DropdownMenuItem(value: 'CREDITO', child: Text('📑 Venta a Crédito / Fiado')),
                    ],
                    onChanged: (val) { if (val != null) setStateDialog(() => selectedMetodo = val); },
                  ),
                  const SizedBox(height: 8),
                  if (selectedMetodo == 'EFECTIVO' || selectedMetodo == 'QR_EFECTIVO') ...[
                    Row(children: [Expanded(child: TextField(controller: montoRecibidoCtrl, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Monto Recibido (Bs.)', border: OutlineInputBorder(), isDense: true), onChanged: (_) => setStateDialog(() {})))]),
                    const SizedBox(height: 6),
                    Wrap(spacing: 4, runSpacing: 4, children: [10, 20, 50, 100, 200].map((billete) => ChoiceChip(label: Text('Bs. $billete', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)), selected: false, onSelected: (_) { setStateDialog(() { montoRecibidoCtrl.text = billete.toString(); }); })).toList()),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: cambio >= 0 ? const Color(0x1A10B981) : const Color(0x1AEF4444), borderRadius: BorderRadius.circular(8), border: Border.all(color: cambio >= 0 ? Colors.green : Colors.red)),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(cambio >= 0 ? 'Cambio / Vueltas:' : 'Insuficiente:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: cambio >= 0 ? Colors.green.shade800 : Colors.red)),
                        Text('Bs. ${cambio.abs().toStringAsFixed(2)}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: cambio >= 0 ? Colors.green.shade800 : Colors.red)),
                      ]),
                    ),
                  ],
                  if (selectedMetodo == 'TRANSFERENCIA' || selectedMetodo == 'QR_EFECTIVO') ...[
                    const SizedBox(height: 10),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF0066FF), side: const BorderSide(color: Color(0xFF0066FF)), padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        final picker = ImagePicker();
                        final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                        if (photo != null) {
                          setStateDialog(() {
                            comprobanteFotoPath = photo.path;
                            comprobanteCtrl.text = 'QR-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';
                          });
                        }
                      },
                      icon: const Icon(Icons.camera_alt_rounded, size: 18),
                      label: Text(comprobanteFotoPath == null ? '📷 Tomar Foto Comprobante QR' : '✓ Foto Capturada', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    if (comprobanteFotoPath != null) ...[const SizedBox(height: 4), Text('Comprobante ID: ${comprobanteCtrl.text}', style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold))],
                  ],
                  if (selectedMetodo == 'TARJETA') ...[TextField(controller: comprobanteCtrl, decoration: const InputDecoration(labelText: 'Nro. de Lote / Autorización *', border: OutlineInputBorder(), isDense: true))]
                  else if (selectedMetodo == 'CREDITO') ...[
                    clientes.isEmpty ? const Text('No hay clientes registrados.', style: TextStyle(color: Colors.red, fontSize: 11))
                        : DropdownButtonFormField<int>(
                      initialValue: selectedClienteId,
                      decoration: const InputDecoration(labelText: 'Cliente *', border: OutlineInputBorder(), isDense: true),
                      items: clientes.map((c) => DropdownMenuItem<int>(
                          value: c['id'] as int,
                          child: Text('${c['nombre']} (${c['nit'] ?? 'CI'})') // ✅ CORREGIDO: Paréntesis cerrado correctamente
                      )).toList(),
                      onChanged: (val) { if (val != null) setStateDialog(() => selectedClienteId = val); },
                    ),
                  ],
                ]),
              ),
              actions: [
                Row(children: [
                  Expanded(child: OutlinedButton(style: OutlinedButton.styleFrom(foregroundColor: Colors.black87, side: BorderSide(color: Colors.grey.shade400), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), onPressed: () => Navigator.pop(dialogCtx, null), child: const Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold)))),
                  const SizedBox(width: 8),
                  Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0066FF), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), onPressed: () { Navigator.pop(dialogCtx, {'metodo': selectedMetodo, 'monto_recibido': recibido, 'cambio': cambio, 'comprobante': comprobanteCtrl.text, 'foto_path': comprobanteFotoPath, 'cliente_id': selectedClienteId}); }, child: const Text('Confirmar y Cobrar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)))),
                ]),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      if (!mounted) return;
      showDialog(context: context, barrierDismissible: false, builder: (ctx) => const PopScope(canPop: false, child: Center(child: CircularProgressIndicator(color: Colors.white))));

      try {
        final usuarioId = prefs.getInt('usuario_id');
        final items = <Map<String, dynamic>>[];
        for (var item in _model.cartItems) {
          items.add({
            'producto_id': item.productoId ?? 0,
            'cantidad': item.cantidad,
            'precio_unitario': item.precioUnitario,
            'subtotal': item.subtotal,
            'unidad_venta': item.unidadVenta,
            'lote_id': item.loteId,
          });
        }

        final ventaId = await SupabaseService.instance.processSale(
          empresaId: empresaId,
          usuarioId: usuarioId,
          clienteId: result['cliente_id'],
          total: _model.total,
          subtotal: _model.total,
          descuento: 0.0,
          metodoPago: result['metodo'],
          items: items,
        );

        if (!mounted) return;
        Navigator.pop(context);
        _model.clearCart();
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('¡Venta #$ventaId realizada con éxito! (${result['metodo']})'), backgroundColor: FlutterFlowTheme.of(context).success));
      } catch (e) {
        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al procesar venta: $e'), backgroundColor: FlutterFlowTheme.of(context).error));
      }
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.goNamed(PanelPrincipalWidget.routeName);
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: FlutterFlowTheme.of(context).secondaryBackground, border: Border(bottom: BorderSide(color: FlutterFlowTheme.of(context).alternate))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            FlutterFlowIconButton(borderRadius: 8, buttonSize: 32, fillColor: Colors.transparent, icon: Icon(Icons.arrow_back_rounded, color: FlutterFlowTheme.of(context).primaryText, size: 18), onPressed: () => context.goNamed(PanelPrincipalWidget.routeName)),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Punto de Venta', maxLines: 1, overflow: TextOverflow.ellipsis, style: FlutterFlowTheme.of(context).titleMedium.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
                                  Text('Terminal 01 · ${_empresaTipo == 'farmacia' ? 'Farmacia' : 'Caja Abierta'}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 34,
                            fillColor: _empresaTipo == 'farmacia' ? Colors.red.shade50 : FlutterFlowTheme.of(context).primary10,
                            icon: Icon(_empresaTipo == 'farmacia' ? Icons.local_hospital_rounded : Icons.inventory_2_rounded, color: _empresaTipo == 'farmacia' ? Colors.red : FlutterFlowTheme.of(context).primary, size: 18),
                            onPressed: _showCatalogModal,
                          ),
                          const SizedBox(width: 4),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0066FF).withValues(alpha: 0.1), foregroundColor: const Color(0xFF0066FF), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                            onPressed: _showAddManualItemDialog,
                            icon: const Icon(Icons.add_rounded, size: 16),
                            label: const Text('Ítem', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                          if (['tienda', 'ferreteria', 'autopartes', 'motopartes'].contains(_empresaTipo)) ...[
                            const SizedBox(width: 4),
                            FlutterFlowIconButton(
                              borderRadius: 8,
                              buttonSize: 34,
                              fillColor: _isListening ? Colors.red.shade100 : FlutterFlowTheme.of(context).primary10,
                              icon: Icon(Icons.mic_rounded, color: _isListening ? Colors.red : FlutterFlowTheme.of(context).primary, size: 18),
                              onPressed: _isListening ? null : _handleVoiceManualItem,
                            ),
                          ],
                          const SizedBox(width: 4),
                          FlutterFlowIconButton(borderRadius: 8, buttonSize: 34, fillColor: FlutterFlowTheme.of(context).primary10, icon: Icon(Icons.qr_code_scanner_rounded, color: FlutterFlowTheme.of(context).primary, size: 18), onPressed: _handleScan),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(color: FlutterFlowTheme.of(context).secondaryBackground, borderRadius: const BorderRadius.vertical(top: Radius.circular(8)), border: Border.all(color: FlutterFlowTheme.of(context).alternate, width: 0.5)),
                          child: const Row(children: [
                            SizedBox(width: 45, child: Text('CANT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                            Expanded(child: Text('PRODUCTO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                            SizedBox(width: 65, child: Text('P/U', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                            SizedBox(width: 75, child: Text('TOTAL', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                          ]),
                        ),
                        Expanded(
                          child: _model.cartItems.isEmpty
                              ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.point_of_sale_rounded, size: 48, color: Colors.grey.shade400),
                                const SizedBox(height: 8),
                                const Text('Sin productos en el cobro actual', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13)),
                                const SizedBox(height: 4),
                                const Text('Use [📦 Catálogo], [+ Ítem] o [📷 Escáner] para agregar', style: TextStyle(color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                          )
                              : ListView.builder(
                            itemCount: _model.cartItems.length,
                            itemBuilder: (ctx, index) {
                              final item = _model.cartItems[index];
                              final bool isExpanded = _expandedRowIndex == index;

                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _expandedRowIndex = isExpanded ? null : index;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isExpanded ? FlutterFlowTheme.of(context).primary10 : FlutterFlowTheme.of(context).secondaryBackground,
                                        border: Border(
                                          bottom: BorderSide(color: FlutterFlowTheme.of(context).alternate, width: 0.5),
                                          left: BorderSide(color: FlutterFlowTheme.of(context).alternate, width: 0.5),
                                          right: BorderSide(color: FlutterFlowTheme.of(context).alternate, width: 0.5),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 45, child: Text('${item.cantidad}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                                          Expanded(child: Text(item.nombre, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                                          SizedBox(width: 75, child: Text('Bs. ${item.precioUnitario.toStringAsFixed(2)}', textAlign: TextAlign.right, style: const TextStyle(fontSize: 11, color: Colors.grey))),
                                          SizedBox(width: 85, child: Text('Bs. ${item.subtotal.toStringAsFixed(2)}', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: FlutterFlowTheme.of(context).primary))),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (isExpanded)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      color: FlutterFlowTheme.of(context).primary10,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (_empresaTipo == 'farmacia' && item.numeroLote != null) ...[
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.medication_rounded, size: 16, color: Colors.blue),
                                                  const SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      'Lote: ${item.numeroLote} | Vence: ${item.fechaVencimiento ?? 'N/A'}',
                                                      style: const TextStyle(fontSize: 11, color: Colors.blue, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                          if (_empresaTipo == 'farmacia') ...[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [PosCartItem.TIPO_CAJA, PosCartItem.TIPO_BLISTER, PosCartItem.TIPO_PASTILLA].map((u) {
                                                final isSelected = item.unidadVenta == u;
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                                  child: ChoiceChip(
                                                    label: Text(u, style: TextStyle(fontSize: 10, color: isSelected ? Colors.white : Colors.black87)),
                                                    selected: isSelected,
                                                    selectedColor: FlutterFlowTheme.of(context).primary,
                                                    onSelected: (val) {
                                                      if (val) _updateCartItemUnidad(item, u);
                                                    },
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                            const SizedBox(height: 4),
                                          ],
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(constraints: const BoxConstraints(), padding: const EdgeInsets.all(4), icon: const Icon(Icons.remove_circle_outline_rounded, color: Colors.red, size: 20), onPressed: () { _model.updateCartItemQuantity(index, item.cantidad - 1); setState(() {}); }),
                                                  Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: Text('${item.cantidad}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                                                  IconButton(constraints: const BoxConstraints(), padding: const EdgeInsets.all(4), icon: const Icon(Icons.add_circle_outline_rounded, color: Colors.green, size: 20), onPressed: () { _model.updateCartItemQuantity(index, item.cantidad + 1); setState(() {}); }),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  TextButton.icon(
                                                    style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                                                    onPressed: () async {
                                                      final priceCtrl = TextEditingController(text: item.precioUnitario.toStringAsFixed(2));
                                                      final confirmPrice = await showDialog<bool>(
                                                        context: context,
                                                        builder: (dialogCtx) => AlertDialog(
                                                          title: Text('Precio: ${item.nombre}'),
                                                          content: TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Nuevo Precio Unitario (Bs.)')),
                                                          actions: [
                                                            TextButton(onPressed: () => Navigator.pop(dialogCtx, false), child: const Text('Cancelar')),
                                                            ElevatedButton(onPressed: () => Navigator.pop(dialogCtx, true), child: const Text('Guardar')),
                                                          ],
                                                        ),
                                                      );
                                                      if (confirmPrice == true) {
                                                        final newPrice = double.tryParse(priceCtrl.text) ?? item.precioUnitario;
                                                        _model.updateCartItemPrice(index, newPrice);
                                                        setState(() {});
                                                      }
                                                    },
                                                    icon: const Icon(Icons.edit_rounded, size: 14, color: Colors.blue),
                                                    label: const Text('Editar P/U', style: TextStyle(fontSize: 11, color: Colors.blue)),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  IconButton(constraints: const BoxConstraints(), padding: const EdgeInsets.all(4), icon: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 20), onPressed: () { _model.removeCartItem(index); setState(() { _expandedRowIndex = null; }); }),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: FlutterFlowTheme.of(context).secondaryBackground, boxShadow: const [BoxShadow(blurRadius: 4, color: Color(0x33000000), offset: Offset(0, -2))]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0066FF), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          onPressed: _handleCheckout,
                          icon: const Icon(Icons.payments_rounded, size: 20),
                          label: Text('COBRAR AHORA · Bs. ${_model.total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.shopping_cart_rounded, size: 14, color: Color(0xFF0066FF)),
                              const SizedBox(width: 4),
                              Text('Carrito: ${_model.totalItemsCount} ítems', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                              const SizedBox(width: 8),
                              Text('· Total: Bs. ${_model.total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF0066FF))),
                            ],
                          ),
                          Row(
                            children: [
                              Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                              const SizedBox(width: 4),
                              const Text('Escáner Activo', style: TextStyle(fontSize: 10, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}