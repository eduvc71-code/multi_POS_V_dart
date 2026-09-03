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
import 'package:multi_p_o_s/database/database_helper.dart';
import 'package:multi_p_o_s/database/inventory_initializer.dart';

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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PuntoDeVentaModel());
    _loadInitialProducts();
  }

  Future<void> _loadInitialProducts() async {
    await _model.searchProducts('');
    if (mounted) {
      setState(() {});
    }
  }

  void _handleAddToCart(Producto producto) {
    final error = _model.addProductoToCart(producto);
    if (error.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✓ ${producto.nombre} agregado (1 u.)'),
          duration: const Duration(milliseconds: 700),
          behavior: SnackBarBehavior.floating,
        ),
      );
      setState(() {});
    }
  }

  Future<void> _showCatalogModal() async {
    final searchCtrl = TextEditingController();
    List<Producto> filteredProducts = [];

    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (sheetCtx, setSheetState) {
            final bottomInset = MediaQuery.of(sheetCtx).viewInsets.bottom;

            return Padding(
              padding: EdgeInsets.only(bottom: bottomInset),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(sheetCtx).size.height * 0.80,
                ),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.grid_view_rounded, color: Color(0xFF0066FF), size: 20),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Catálogo de Inventario',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: FlutterFlowTheme.of(context).primaryText),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0066FF).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '🛒 En Cobro: ${_model.totalItemsCount} u.',
                              style: const TextStyle(color: Color(0xFF0066FF), fontWeight: FontWeight.bold, fontSize: 11),
                            ),
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
                              ? IconButton(
                                  icon: const Icon(Icons.clear_rounded),
                                  onPressed: () {
                                    searchCtrl.clear();
                                    setSheetState(() => filteredProducts.clear());
                                  },
                                )
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.manage_search_rounded, size: 48, color: Colors.grey.shade400),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Escriba cualquier letra para buscar productos',
                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : filteredProducts.isEmpty
                              ? const Center(child: Padding(
                                  padding: EdgeInsets.all(24.0),
                                  child: Text('No hay productos coincidentes.', style: TextStyle(color: Colors.grey)),
                                ))
                              : GridView.builder(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.75,
                                    crossAxisSpacing: 6,
                                    mainAxisSpacing: 6,
                                  ),
                                  itemCount: filteredProducts.length,
                                  itemBuilder: (ctx, index) {
                                    final p = filteredProducts[index];

                                    // Calcular cuántas unidades de este producto ya están en la venta activa
                                    final int inCartQty = _model.cartItems
                                        .where((item) => item.productoId == p.id)
                                        .fold(0, (sum, item) => sum + item.cantidad);

                                  return InkWell(
                                    onTap: () async {
                                      final selectedQty = await showDialog<int>(
                                        context: context,
                                        builder: (popupCtx) {
                                          int qty = 1;
                                          return StatefulBuilder(
                                            builder: (popupCtx, setQtyState) => AlertDialog(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              title: Text(p.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                                                      IconButton(
                                                        icon: const Icon(Icons.remove_circle_outline_rounded, size: 32, color: Colors.red),
                                                        onPressed: () {
                                                          if (qty > 1) setQtyState(() => qty--);
                                                        },
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                                        child: Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(Icons.add_circle_outline_rounded, size: 32, color: Colors.green),
                                                        onPressed: () {
                                                          if (qty < p.stock) setQtyState(() => qty++);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  if (qty >= p.stock)
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 4.0),
                                                      child: Text('Stock máximo disponible: ${p.stock} u.', style: const TextStyle(color: Colors.orange, fontSize: 11)),
                                                    ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(popupCtx, null),
                                                  child: const Text('Cancelar'),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: const Color(0xFF0066FF),
                                                    foregroundColor: Colors.white,
                                                  ),
                                                  onPressed: () => Navigator.pop(popupCtx, qty),
                                                  child: const Text('Agregar Producto'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );

                                      if (selectedQty != null) {
                                        for (int i = 0; i < selectedQty; i++) {
                                          _model.addProductoToCart(p);
                                        }
                                        setState(() {});
                                        Navigator.pop(sheetCtx);
                                      } else {
                                        searchCtrl.clear();
                                        setSheetState(() => filteredProducts.clear());
                                      }
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: inCartQty > 0
                                            ? const Color(0x1510B981)
                                            : FlutterFlowTheme.of(context).primaryBackground,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: inCartQty > 0 ? Colors.green : FlutterFlowTheme.of(context).alternate,
                                          width: inCartQty > 0 ? 1.5 : 1.0,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  p.nombre,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                ),
                                                const SizedBox(height: 2),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Bs. ${p.precio.toStringAsFixed(2)}',
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.w900,
                                                        fontSize: 12,
                                                        color: Color(0xFF0066FF),
                                                      ),
                                                    ),
                                                    if (inCartQty > 0) ...[
                                                      const SizedBox(width: 4),
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                                        decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius: BorderRadius.circular(6),
                                                        ),
                                                        child: Text(
                                                          '✓ $inCartQty',
                                                          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 28,
                                            height: 28,
                                            decoration: BoxDecoration(
                                              color: inCartQty > 0 ? Colors.green : const Color(0xFF0066FF),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              inCartQty > 0 ? Icons.check_rounded : Icons.add_rounded,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  },
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

  Future<void> _showAddManualItemDialog() async {
    final nombreCtrl = TextEditingController();
    final precioCtrl = TextEditingController();
    final cantidadCtrl = TextEditingController(text: '1');

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.add_shopping_cart_rounded, color: Color(0xFF0066FF)),
            SizedBox(width: 8),
            Text('Agregar Ítem Manual', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nombreCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre / Servicio / Concepto *',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: precioCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Precio Unit. (Bs.) *',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: cantidadCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Cantidad *',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Agregar a la Venta'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final p = double.tryParse(precioCtrl.text) ?? 0.0;
      final c = int.tryParse(cantidadCtrl.text) ?? 1;
      _model.addManualItemToCart(nombreCtrl.text, p, c);
      setState(() {});
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
                  const Row(
                    children: [
                      Icon(Icons.qr_code_scanner_rounded, color: Color(0xFF0066FF), size: 20),
                      SizedBox(width: 8),
                      Text('Escanear Código', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: () => Navigator.pop(dialogCtx),
                  ),
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
                        if (code != null && code.isNotEmpty) {
                          Navigator.pop(dialogCtx, code);
                        }
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text('Apuntee la cámara al código de barras', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );

    if (code != null && code.isNotEmpty) {
      final productoDb = await DatabaseHelper.instance.readProductoByCodigo(code);
      if (productoDb != null) {
        _handleAddToCart(productoDb);
      } else {
        final prefs = await SharedPreferences.getInstance();
        final businessType = prefs.getString('selectedBusinessType') ?? 'Tienda';
        final productLib = InventoryInitializer.lookupProductInLibrary(code, businessType);
        
        if (productLib != null) {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Producto de Librería'),
              content: Text('Se encontró "${productLib['nombre']}" en la librería de $businessType.\n\n¿Desea agregarlo al inventario y a la venta actual?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true), 
                  child: const Text('Agregar y Vender')
                ),
              ],
            ),
          );

          if (confirm == true) {
            final nuevoProducto = Producto(
              nombre: productLib['nombre'],
              codigo: code,
              costo: 0.0,
              precio: 0.0,
              stock: 10,
              stockMinimo: 5,
            );
            await DatabaseHelper.instance.createProducto(nuevoProducto);
            final p = await DatabaseHelper.instance.readProductoByCodigo(code);
            if (p != null) _handleAddToCart(p);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Código $code no encontrado en inventario.')),
          );
        }
      }
    }
  }

  Future<void> _handleCheckout() async {
    if (_model.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El carrito de ventas está vacío')),
      );
      return;
    }

    String selectedMetodo = 'EFECTIVO';
    final clientes = await DatabaseHelper.instance.readAllClientes();
    int? selectedClienteId = clientes.isNotEmpty ? clientes.first['id'] : null;
    final montoRecibidoCtrl = TextEditingController(text: _model.total.toStringAsFixed(2));
    final comprobanteCtrl = TextEditingController();
    String? comprobanteFotoPath;

    if (!mounted) return;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
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
              title: const Row(
                children: [
                  Icon(Icons.point_of_sale_rounded, color: Color(0xFF0066FF), size: 22),
                  SizedBox(width: 8),
                  Text('Procesar Cobro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0066FF), Color(0xFF3B82F6)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('TOTAL A COBRAR', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                              Text('Bs. ${totalVenta.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                            ],
                          ),
                          Text('${_model.totalItemsCount} ítems', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedMetodo,
                      decoration: const InputDecoration(labelText: 'Forma de Pago', border: OutlineInputBorder(), isDense: true),
                      items: const [
                        DropdownMenuItem(value: 'EFECTIVO', child: Text('💵 Efectivo (Calculadora de Vueltas)')),
                        DropdownMenuItem(value: 'TRANSFERENCIA', child: Text('📲 Transferencia QR / Banco')),
                        DropdownMenuItem(value: 'TARJETA', child: Text('💳 Tarjeta Débito / Crédito')),
                        DropdownMenuItem(value: 'CREDITO', child: Text('📑 Venta a Crédito / Fiado')),
                      ],
                      onChanged: (val) {
                        if (val != null) setStateDialog(() => selectedMetodo = val);
                      },
                    ),
                    const SizedBox(height: 8),
                    if (selectedMetodo == 'EFECTIVO') ...[
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: montoRecibidoCtrl,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: const InputDecoration(
                                labelText: 'Monto Recibido (Bs.)',
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              onChanged: (_) => setStateDialog(() {}),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: [10, 20, 50, 100, 200].map((billete) => ChoiceChip(
                          label: Text('Bs. $billete', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                          selected: false,
                          onSelected: (_) {
                            setStateDialog(() {
                              montoRecibidoCtrl.text = billete.toString();
                            });
                          },
                        )).toList(),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: cambio >= 0 ? const Color(0x1A10B981) : const Color(0x1AEF4444),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: cambio >= 0 ? Colors.green : Colors.red),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(cambio >= 0 ? 'Cambio / Vueltas:' : 'Insuficiente:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: cambio >= 0 ? Colors.green.shade800 : Colors.red)),
                            Text('Bs. ${cambio.abs().toStringAsFixed(2)}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: cambio >= 0 ? Colors.green.shade800 : Colors.red)),
                          ],
                        ),
                      ),
                    ] else if (selectedMetodo == 'TRANSFERENCIA') ...[
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF0066FF),
                          side: const BorderSide(color: Color(0xFF0066FF)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
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
                        label: Text(comprobanteFotoPath == null ? '📷 Tomar Foto Comprobante' : '✓ Foto Capturada', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      if (comprobanteFotoPath != null) ...[
                        const SizedBox(height: 4),
                        Text('Comprobante ID: ${comprobanteCtrl.text}', style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ] else if (selectedMetodo == 'TARJETA') ...[
                      TextField(
                        controller: comprobanteCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nro. de Lote / Autorización *',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ] else if (selectedMetodo == 'CREDITO') ...[
                      clientes.isEmpty
                          ? const Text('No hay clientes registrados.', style: TextStyle(color: Colors.red, fontSize: 11))
                          : DropdownButtonFormField<int>(
                              value: selectedClienteId,
                              decoration: const InputDecoration(labelText: 'Cliente *', border: OutlineInputBorder(), isDense: true),
                              items: clientes.map((c) => DropdownMenuItem<int>(
                                value: c['id'] as int,
                                child: Text('${c['nombre']} (${c['nit'] ?? 'CI'})'),
                              )).toList(),
                              onChanged: (val) {
                                if (val != null) setStateDialog(() => selectedClienteId = val);
                              },
                            ),
                    ],
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          side: BorderSide(color: Colors.grey.shade400),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () => Navigator.pop(dialogCtx, null),
                        child: const Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0066FF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          Navigator.pop(dialogCtx, {
                            'metodo': selectedMetodo,
                            'monto_recibido': recibido,
                            'cambio': cambio,
                            'comprobante': comprobanteCtrl.text,
                            'foto_path': comprobanteFotoPath,
                            'cliente_id': selectedClienteId,
                          });
                        },
                        child: const Text('Confirmar y Cobrar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      try {
        final items = <Map<String, dynamic>>[];
        for (var item in _model.cartItems) {
          items.add({
            'producto_id': item.productoId ?? 0,
            'cantidad': item.cantidad,
            'precio_unitario': item.precioUnitario,
            'subtotal': item.subtotal,
          });
        }

        final ventaId = await DatabaseHelper.instance.processAtomicSale(
          items: items,
          total: _model.total,
          subtotal: _model.total,
          descuento: 0.0,
          metodoPago: result['metodo'],
        );

        _model.clearCart();

        if (mounted) {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('¡Venta #$ventaId realizada con éxito! (${result['metodo']})'),
              backgroundColor: FlutterFlowTheme.of(context).success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al procesar venta: $e'),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
        }
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
    return GestureDetector(
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
              // CABECERA OPTIMIZADA
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  border: Border(bottom: BorderSide(color: FlutterFlowTheme.of(context).alternate)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 32,
                            fillColor: Colors.transparent,
                            icon: Icon(Icons.arrow_back_rounded, color: FlutterFlowTheme.of(context).primaryText, size: 18),
                            onPressed: () => context.goNamed(PanelPrincipalWidget.routeName),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Punto de Venta',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: FlutterFlowTheme.of(context).titleMedium.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                const Text('Terminal 01 · Caja Abierta', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10, color: Colors.grey)),
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
                        // BOTÓN SOLO ICONO CATÁLOGO DE INVENTARIO
                        FlutterFlowIconButton(
                          borderRadius: 8,
                          buttonSize: 34,
                          fillColor: FlutterFlowTheme.of(context).primary10,
                          icon: Icon(Icons.inventory_2_rounded, color: FlutterFlowTheme.of(context).primary, size: 18),
                          onPressed: _showCatalogModal,
                        ),
                        const SizedBox(width: 4),
                        // BOTÓN + ÍTEM (Sin ++ duplicado)
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0066FF).withValues(alpha: 0.1),
                            foregroundColor: const Color(0xFF0066FF),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: _showAddManualItemDialog,
                          icon: const Icon(Icons.add_rounded, size: 16),
                          label: const Text('Ítem', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 4),
                        // BOTÓN ESCÁNER (100% VISIBLE DENTRO DE PANTALLA)
                        FlutterFlowIconButton(
                          borderRadius: 8,
                          buttonSize: 34,
                          fillColor: FlutterFlowTheme.of(context).primary10,
                          icon: Icon(Icons.qr_code_scanner_rounded, color: FlutterFlowTheme.of(context).primary, size: 18),
                          onPressed: _handleScan,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // CUERPO PRINCIPAL: TABLA / GRID EXCEL DE PRODUCTOS A COBRAR
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Column(
                    children: [
                      // ENCABEZADO DE TABLA
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                          border: Border.all(color: FlutterFlowTheme.of(context).alternate, width: 0.5),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 45, child: Text('CANT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                            Expanded(child: Text('PRODUCTO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                            SizedBox(width: 65, child: Text('P/U', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                            SizedBox(width: 75, child: Text('TOTAL', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                          ],
                        ),
                      ),
                      // LISTA DE FILAS A COBRAR
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
                                            color: isExpanded
                                                ? FlutterFlowTheme.of(context).primary10
                                                : FlutterFlowTheme.of(context).secondaryBackground,
                                            border: Border(
                                              bottom: BorderSide(color: FlutterFlowTheme.of(context).alternate, width: 0.5),
                                              left: BorderSide(color: FlutterFlowTheme.of(context).alternate, width: 0.5),
                                              right: BorderSide(color: FlutterFlowTheme.of(context).alternate, width: 0.5),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 45,
                                                child: Text('${item.cantidad}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                              ),
                                              Expanded(
                                                child: Text(item.nombre, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                              ),
                                              SizedBox(
                                                width: 65,
                                                child: Text('Bs. ${item.precioUnitario.toStringAsFixed(2)}', textAlign: TextAlign.right, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                              ),
                                              SizedBox(
                                                width: 75,
                                                child: Text(
                                                  'Bs. ${item.subtotal.toStringAsFixed(2)}',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: FlutterFlowTheme.of(context).primary),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // BARRA DE EDICIÓN EXPANDIBLE DE LA FILA
                                      if (isExpanded)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          color: FlutterFlowTheme.of(context).primary10,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    constraints: const BoxConstraints(),
                                                    padding: const EdgeInsets.all(4),
                                                    icon: const Icon(Icons.remove_circle_outline_rounded, color: Colors.red, size: 20),
                                                    onPressed: () {
                                                      _model.updateCartItemQuantity(index, item.cantidad - 1);
                                                      setState(() {});
                                                    },
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                                    child: Text('${item.cantidad}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                                  ),
                                                  IconButton(
                                                    constraints: const BoxConstraints(),
                                                    padding: const EdgeInsets.all(4),
                                                    icon: const Icon(Icons.add_circle_outline_rounded, color: Colors.green, size: 20),
                                                    onPressed: () {
                                                      _model.updateCartItemQuantity(index, item.cantidad + 1);
                                                      setState(() {});
                                                    },
                                                  ),
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
                                                          content: TextField(
                                                            controller: priceCtrl,
                                                            keyboardType: TextInputType.number,
                                                            decoration: const InputDecoration(labelText: 'Nuevo Precio Unitario (Bs.)'),
                                                          ),
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
                                                  IconButton(
                                                    constraints: const BoxConstraints(),
                                                    padding: const EdgeInsets.all(4),
                                                    icon: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 20),
                                                    onPressed: () {
                                                      _model.removeCartItem(index);
                                                      setState(() {
                                                        _expandedRowIndex = null;
                                                      });
                                                    },
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

              // BARRA INFERIOR INTEGRADA
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: const [BoxShadow(blurRadius: 4, color: Color(0x33000000), offset: Offset(0, -2))],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // BOTÓN PRINCIPAL COBRAR AHORA (AZUL INSTIUCIONAL)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0066FF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: _handleCheckout,
                        icon: const Icon(Icons.payments_rounded, size: 20),
                        label: Text(
                          'COBRAR AHORA · Bs. ${_model.total.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // RESUMEN DEL CARRITO Y MODO LLEVADO ABAJO DE COBRAR AHORA
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.shopping_cart_rounded, size: 14, color: Color(0xFF0066FF)),
                            const SizedBox(width: 4),
                            Text(
                              'Carrito: ${_model.totalItemsCount} ítems',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '· Total: Bs. ${_model.total.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF0066FF)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                            const SizedBox(width: 4),
                            const Text(
                              'Escáner Activo',
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
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
    );
  }
}
