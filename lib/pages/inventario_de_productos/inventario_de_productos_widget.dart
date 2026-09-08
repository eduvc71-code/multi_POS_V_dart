import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/components/inventory_stat/inventory_stat_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav_child2/bottom_nav_child2_widget.dart';
import 'package:multi_p_o_s/models/producto_model.dart';
import 'package:multi_p_o_s/models/lote_model.dart';
import '../panel_principal/panel_principal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multi_p_o_s/database/inventory_initializer.dart';
import 'package:multi_p_o_s/services/open_food_facts_service.dart';
import 'package:multi_p_o_s/services/supabase_service.dart';
import 'inventario_de_productos_model.dart';

export 'inventario_de_productos_model.dart';

@Preview()
Widget previewInventarioDeProductos() {
  return const InventarioDeProductosWidget();
}

class InventarioDeProductosWidget extends StatefulWidget {
  const InventarioDeProductosWidget({super.key});

  static String routeName = 'InventarioDeProductos';
  static String routePath = '/inventarioDeProductos';

  @override
  State<InventarioDeProductosWidget> createState() =>
      _InventarioDeProductosWidgetState();
}

class _InventarioDeProductosWidgetState
    extends State<InventarioDeProductosWidget> {
  late InventarioDeProductosModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _empresaTipo = 'Tienda';
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InventarioDeProductosModel());

    _initColumns();
    _loadData();
  }

  void _initColumns() {
    columns = [
      PlutoColumn(
        title: 'Nombre',
        field: 'nombre',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        width: 160,
      ),
      PlutoColumn(
        title: 'Código',
        field: 'codigo',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        width: 120,
      ),
      PlutoColumn(
        title: 'Costo',
        field: 'costo',
        type: PlutoColumnType.number(format: '#,###.##'),
        width: 90,
        textAlign: PlutoColumnTextAlign.right,
      ),
      PlutoColumn(
        title: 'Precio',
        field: 'precio',
        type: PlutoColumnType.number(format: '#,###.##'),
        width: 90,
        textAlign: PlutoColumnTextAlign.right,
      ),
      PlutoColumn(
        title: 'Stock',
        field: 'stock',
        type: PlutoColumnType.number(),
        width: 70,
        textAlign: PlutoColumnTextAlign.right,
      ),
      PlutoColumn(
        title: 'Acciones',
        field: 'acciones',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        width: _empresaTipo == 'Farmacia' ? 190 : 150,
        renderer: (rendererContext) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_empresaTipo == 'Farmacia')
                IconButton(
                  icon: const Icon(
                    Icons.medication_liquid_rounded,
                    color: Colors.teal,
                    size: 20,
                  ),
                  tooltip: 'Lotes / Caducidad (FEFO)',
                  onPressed: () => _showLotesDialog(rendererContext.row),
                ),
              IconButton(
                icon: const Icon(
                  Icons.history_rounded,
                  color: Colors.purple,
                  size: 20,
                ),
                tooltip: 'Kardex / Movimientos',
                onPressed: () => _showKardexDialog(rendererContext.row),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit_rounded,
                  color: Colors.blue,
                  size: 20,
                ),
                onPressed: () => _showEditDialog(rendererContext.row),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 20,
                ),
                onPressed: () => _handleDelete(rendererContext.row),
              ),
            ],
          );
        },
      ),
    ];
  }

  Future<void> _showKardexDialog(PlutoRow row) async {
    final int? prodId = row.cells['id']?.value;
    final String nombre = row.cells['nombre']?.value ?? '';

    if (prodId == null) return;

    final movs = await SupabaseService.instance.readMovimientosInventario(
      prodId,
    );

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Kardex - $nombre'),
          content: SizedBox(
            width: double.maxFinite,
            height: 350,
            child: movs.isEmpty
                ? const Center(
                    child: Text(
                      'No hay movimientos registrados para este producto.',
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: movs.length,
                    itemBuilder: (context, index) {
                      final m = movs[index];
                      final String tipo = m['tipo'] ?? 'VENTA';
                      final int cantidad = m['cantidad'] ?? 0;
                      final String fecha = m['fecha'] ?? '';
                      final String motivo = m['motivo'] ?? '';

                      Color tipoColor = Colors.green;
                      if (tipo == 'VENTA') tipoColor = Colors.red;
                      if (tipo == 'DEVOLUCION') tipoColor = Colors.orange;

                      return ListTile(
                        leading: Icon(
                          tipo == 'VENTA'
                              ? Icons.remove_circle_outline
                              : Icons.add_circle_outline,
                          color: tipoColor,
                        ),
                        title: Text(
                          '$tipo: $cantidad unidades',
                          style: TextStyle(
                            color: tipoColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '$motivo\nFecha: ${fecha.length > 16 ? fecha.substring(0, 16) : fecha}',
                        ),
                        isThreeLine: true,
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLotesDialog(PlutoRow row) async {
    final int? prodId = row.cells['id']?.value;
    final String nombre = row.cells['nombre']?.value ?? '';
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? 1;

    if (prodId == null) return;

    List<LoteProducto> lotes =
        await SupabaseService.instance.readLotesProducto(prodId, empresaId);

    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (ctx) {
        final loteCtrl = TextEditingController();
        final stockCtrl = TextEditingController();
        DateTime selectedDate =
            DateTime.now().add(const Duration(days: 365));

        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            return AlertDialog(
              title: Text('Lotes / Caducidad (FEFO) - $nombre'),
              content: SizedBox(
                width: double.maxFinite,
                height: 420,
                child: Column(
                  children: [
                    Expanded(
                      child: lotes.isEmpty
                          ? const Center(
                              child: Text(
                                'No hay lotes registrados para este medicamento.',
                              ),
                            )
                          : ListView.builder(
                              itemCount: lotes.length,
                              itemBuilder: (ctx, index) {
                                final l = lotes[index];
                                Color badgeColor = Colors.green;
                                String badgeText = 'Vigente';
                                if (l.esVencido) {
                                  badgeColor = Colors.red;
                                  badgeText = '🔴 VENCIDO';
                                } else if (l.esProximoAVencer) {
                                  badgeColor = Colors.orange;
                                  badgeText =
                                      '🟠 PRÓXIMO A VENCER (${l.diasParaVencer} días)';
                                }

                                return ListTile(
                                  title: Text(
                                    'Lote: ${l.numeroLote}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Vence: ${l.fechaVencimiento.toString().split(' ').first} | Stock: ${l.stockUnidades} u. pastillas',
                                  ),
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: badgeColor,
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      badgeText,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    const Divider(),
                    const Text(
                      'Agregar Nuevo Lote',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: loteCtrl,
                            decoration: const InputDecoration(
                              labelText: 'N° Lote (ej. LOTE-2026-A)',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: stockCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Stock Pastillas',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Vencimiento: ${selectedDate.toString().split(' ').first}',
                        ),
                        const Spacer(),
                        TextButton.icon(
                          icon: const Icon(
                            Icons.calendar_today_rounded,
                            size: 16,
                          ),
                          label: const Text('Elegir Fecha'),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: dialogCtx,
                              initialDate: selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 3650),
                              ),
                            );
                            if (picked != null) {
                              setDialogState(() => selectedDate = picked);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogCtx),
                  child: const Text('Cerrar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (loteCtrl.text.isEmpty) return;
                    final nuevoLote = LoteProducto(
                      productoId: prodId,
                      empresaId: empresaId,
                      numeroLote: loteCtrl.text,
                      fechaVencimiento: selectedDate,
                      stockUnidades: int.tryParse(stockCtrl.text) ?? 100,
                    );
                    await SupabaseService.instance
                        .createLoteProducto(nuevoLote);
                    final updatedLotes = await SupabaseService.instance
                        .readLotesProducto(prodId, empresaId);
                    setDialogState(() {
                      lotes = updatedLotes;
                      loteCtrl.clear();
                      stockCtrl.clear();
                    });
                  },
                  child: const Text('Guardar Lote'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? 1;
    final empresa = await SupabaseService.instance.getEmpresa(empresaId);
    if (empresa != null) {
      _empresaTipo = empresa['tipo'] ?? 'Tienda';
      _initColumns();
    }
    await _model.fetchProductos();
    _updateRows();
    if (mounted) {
      setState(() {});
    }
  }

  void _updateRows() {
    rows = _model.productos.map((p) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: p.id),
          'nombre': PlutoCell(value: p.nombre),
          'codigo': PlutoCell(value: p.codigo),
          'costo': PlutoCell(value: p.costo),
          'precio': PlutoCell(value: p.precio),
          'stock': PlutoCell(value: p.stock),
          'acciones': PlutoCell(value: ''),
        },
      );
    }).toList();
    if (_model.stateManager != null) {
      _model.stateManager!.refRows.clear();
      _model.stateManager!.refRows.addAll(rows);
    }
  }

  Future<void> _showAddProductDialog() async {
    _showAddProductDialogWithData({});
  }

  Future<void> _showAddProductDialogWithData(Map<String, dynamic> data) async {
    final currentContext = context;
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('user_role') ?? 'admin';

    if (role == 'cajero') {
      if (!currentContext.mounted) return;
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(
          content: Text(
            'Acceso Restringido: El rol de Cajero solo puede visualizar el inventario',
          ),
        ),
      );
      return;
    }

    final nombreController = TextEditingController(text: data['nombre'] ?? '');
    final codigoController = TextEditingController(text: data['codigo'] ?? '');
    final costoController = TextEditingController(
      text: (data['costo'] ?? '').toString(),
    );
    final precioController = TextEditingController(
      text: (data['precio'] ?? '').toString(),
    );
    final stockController = TextEditingController(
      text: (data['stock'] ?? '0').toString(),
    );

    if (!currentContext.mounted) return;

    final result = await showDialog<Producto>(
      context: currentContext,
      builder: (context) => AlertDialog(
        title: Text(
          data.isEmpty ? 'Nuevo Producto' : 'Cargar desde Librería',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: codigoController,
                decoration: const InputDecoration(labelText: 'Código'),
              ),
              TextField(
                controller: costoController,
                decoration: const InputDecoration(labelText: 'Costo'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
              if (_empresaTipo == 'Farmacia') ...[
                const SizedBox(height: 12),
                const Divider(),
                const Text(
                  'Configuración Farmacéutica (Fraccionamiento)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Pastillas / Caja',
                          hintText: '30',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Pastillas / Blíster',
                          hintText: '10',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                Producto(
                  nombre: nombreController.text,
                  codigo: codigoController.text,
                  costo: double.tryParse(costoController.text) ?? 0.0,
                  precio: double.tryParse(precioController.text) ?? 0.0,
                  stock: int.tryParse(stockController.text) ?? 0,
                  stockMinimo: 12,
                ),
              );
            },
            child: Text(data.isEmpty ? 'Crear' : 'Agregar'),
          ),
        ],
      ),
    );

    if (result != null) {
      final prefs = await SharedPreferences.getInstance();
      final empresaId = prefs.getInt('empresa_id') ?? 1;
      await SupabaseService.instance.createProducto(result, empresaId);
      await _loadData();
    }
  }

  Future<void> _handleScan() async {
    final currentContext = context;
    final code = await showDialog<String>(
      context: currentContext,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Escanear Producto'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: MobileScanner(
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            if (barcodes.isNotEmpty) {
              final String? code = barcodes.first.rawValue;
              if (code != null) {
                Navigator.pop(context, code);
              }
            }
          },
        ),
      ),
    );

    if (code != null && code.isNotEmpty) {
      // 1. Buscar en Supabase
      final prefs = await SharedPreferences.getInstance();
      final empresaId = prefs.getInt('empresa_id') ?? 1;
      final productoDb = await SupabaseService.instance.readProductoByCodigo(
        code,
        empresaId,
      );
      if (productoDb != null) {
        _onSearchChanged(code); // Filtrar la grilla para mostrar el producto
        if (!currentContext.mounted) return;
        ScaffoldMessenger.of(currentContext).showSnackBar(
          SnackBar(
            content: Text('Producto en inventario: ${productoDb.nombre}'),
          ),
        );
      } else {
        // 2. Buscar en "Librería" según tipo de empresa
        final prefs = await SharedPreferences.getInstance();
        final businessType =
            prefs.getString('selectedBusinessType') ?? 'Tienda';
        final productLib = InventoryInitializer.lookupProductInLibrary(
          code,
          businessType,
        );

        if (productLib != null) {
          _showAddProductDialogWithData(productLib);
        } else {
          // 3. Buscar en Open Food Facts (Bolivia y América Latina)
          if (!currentContext.mounted) return;
          ScaffoldMessenger.of(currentContext).showSnackBar(
            const SnackBar(
              content: Text(
                'Buscando producto en Open Food Facts (Bolivia / América Latina)...',
              ),
              duration: Duration(seconds: 3),
            ),
          );

          final offProduct = await OpenFoodFactsService.searchProductByBarcode(
            code,
          );

          if (!currentContext.mounted) return;
          ScaffoldMessenger.of(currentContext).hideCurrentSnackBar();

          if (offProduct != null) {
            final confirm = await showDialog<bool>(
              context: currentContext,
              builder: (context) => AlertDialog(
                title: Text(
                  'Producto encontrado (${offProduct['origen'] ?? 'Open Food Facts'})',
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nombre: ${offProduct['nombre']}'),
                    if (offProduct['marca'] != null &&
                        offProduct['marca'].toString().isNotEmpty)
                      Text('Marca: ${offProduct['marca']}'),
                    if (offProduct['categoria'] != null &&
                        offProduct['categoria'].toString().isNotEmpty)
                      Text('Categoría: ${offProduct['categoria']}'),
                    Text('Código: $code'),
                    const SizedBox(height: 8),
                    const Text(
                      '¿Desea agregar este producto al inventario?\n(Precio y costo se inicializan en 0, podrá editarlos después)',
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Agregar'),
                  ),
                ],
              ),
            );
            if (confirm == true) {
              final empresaId = prefs.getInt('empresa_id') ?? 1;
              final nuevoProducto = Producto(
                nombre: offProduct['nombre'],
                codigo: code,
                costo: 0.0,
                precio: 0.0,
                stock: 10,
                stockMinimo: 12,
              );
              await SupabaseService.instance.createProducto(nuevoProducto, empresaId);
              await _loadData();
              _onSearchChanged(code); // Filtra para mostrar el nuevo producto
              if (!currentContext.mounted) return;
              ScaffoldMessenger.of(currentContext).showSnackBar(
                SnackBar(
                  content: Text(
                    'Producto agregado desde Open Food Facts: ${offProduct['nombre']}',
                  ),
                ),
              );
            }
          } else {
            // Mostrar diálogo para agregar el producto si no existe
            if (!currentContext.mounted) return;
            final confirm = await showDialog<bool>(
              context: currentContext,
              builder: (context) => AlertDialog(
                title: const Text('Producto no encontrado'),
                content: Text(
                  'El código $code no existe. ¿Desea agregarlo ahora?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Agregar'),
                  ),
                ],
              ),
            );

            if (confirm == true) {
              _showAddProductDialogWithData({'codigo': code});
            }
          }
        }
      }
    }
  }

  Future<void> _showEditDialog(PlutoRow row) async {
    final currentContext = context;
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('user_role') ?? 'admin';

    if (role != 'admin') {
      if (!currentContext.mounted) return;
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(
          content: Text(
            'Acceso Restringido: Solo el Administrador/Dueño puede editar precios o stock',
          ),
        ),
      );
      return;
    }

    final id = row.cells['id']?.value;
    if (id == null) return;

    final producto = _model.productos.firstWhere((p) => p.id == id);

    final nombreController = TextEditingController(text: producto.nombre);
    final codigoController = TextEditingController(text: producto.codigo);
    final costoController = TextEditingController(
      text: producto.costo.toString(),
    );
    final precioController = TextEditingController(
      text: producto.precio.toString(),
    );
    final stockController = TextEditingController(
      text: producto.stock.toString(),
    );

    if (!currentContext.mounted) return;

    final result = await showDialog<Producto>(
      context: currentContext,
      builder: (context) => AlertDialog(
        title: const Text(
          'Editar Producto',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: codigoController,
                decoration: const InputDecoration(labelText: 'Código'),
              ),
              TextField(
                controller: costoController,
                decoration: const InputDecoration(labelText: 'Costo'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                producto.copyWith(
                  nombre: nombreController.text,
                  codigo: codigoController.text,
                  costo:
                      double.tryParse(costoController.text) ?? producto.costo,
                  precio:
                      double.tryParse(precioController.text) ?? producto.precio,
                  stock: int.tryParse(stockController.text) ?? producto.stock,
                ),
              );
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (result != null) {
      await SupabaseService.instance.updateProducto(result);
      await _loadData();
    }
  }

  Future<void> _handleDelete(PlutoRow row) async {
    final currentContext = context;
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('user_role') ?? 'admin';

    if (role != 'admin') {
      if (!currentContext.mounted) return;
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(
          content: Text(
            'Acceso Restringido: Solo el Administrador/Dueño puede eliminar productos',
          ),
        ),
      );
      return;
    }

    final id = row.cells['id']?.value;
    if (id != null) {
      if (!currentContext.mounted) return;
      final confirm = await showDialog<bool>(
        context: currentContext,
        builder: (context) => AlertDialog(
          title: const Text('Confirmar'),
          content: const Text('¿Estás seguro de eliminar este producto?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );

      if (confirm == true) {
        await SupabaseService.instance.deleteProducto(id);
        await _loadData();
      }
    }
  }

  Future<void> _handleCellChange(PlutoGridOnChangedEvent event) async {
    final currentContext = context;
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('user_role') ?? 'admin';

    if (role != 'admin') {
      if (!currentContext.mounted) return;
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(
          content: Text(
            'Acceso Restringido: Solo el Administrador/Dueño puede modificar celdas del inventario',
          ),
        ),
      );
      _updateRows(); // Revertir edición
      return;
    }

    final id = event.row.cells['id']?.value;
    if (id == null) return;

    final productoOriginal = _model.productos.firstWhere((p) => p.id == id);
    Producto productoActualizado;

    switch (event.column.field) {
      case 'costo':
        productoActualizado = productoOriginal.copyWith(
          costo: event.value.toDouble(),
        );
        break;
      case 'precio':
        productoActualizado = productoOriginal.copyWith(
          precio: event.value.toDouble(),
        );
        break;
      case 'stock':
        productoActualizado = productoOriginal.copyWith(
          stock: event.value.toInt(),
        );
        break;
      default:
        return;
    }

    await SupabaseService.instance.updateProducto(productoActualizado);
    await _loadData();
  }

  void _onSearchChanged(String query) {
    if (_model.stateManager != null) {
      _model.stateManager!.setFilter((element) {
        final nombre =
            element.cells['nombre']?.value.toString().toLowerCase() ?? '';
        final codigo =
            element.cells['codigo']?.value.toString().toLowerCase() ?? '';
        final q = query.toLowerCase();
        return nombre.contains(q) || codigo.contains(q);
      });
    }
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
          top: true,
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Inventario',
                                style: FlutterFlowTheme.of(context).titleMedium
                                    .copyWith(
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '| Existencias',
                                style: FlutterFlowTheme.of(context).labelSmall
                                    .copyWith(
                                      fontFamily: "Poppins",
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 12,
                                buttonSize: 32,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: const Icon(
                                  Icons.add_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onPressed: _showAddProductDialog,
                              ),
                              const SizedBox(width: 6),
                              FlutterFlowIconButton(
                                borderRadius: 12,
                                buttonSize: 32,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: const Icon(
                                  Icons.qr_code_scanner_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onPressed: _handleScan,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      wrapWithModel(
                        model: _model.textFieldModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TextFieldWidget(
                          hint: 'Buscar por nombre o código...',
                          onChange: _onSearchChanged,
                          variant: 'filled',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: wrapWithModel(
                        model: _model.inventoryStatModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: InventoryStatWidget(
                          color: FlutterFlowTheme.of(context).primary,
                          icon: const Icon(
                            Icons.inventory_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          label: 'Total Items',
                          value: _model.productos.length.toString(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: wrapWithModel(
                        model: _model.inventoryStatModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: InventoryStatWidget(
                          color: FlutterFlowTheme.of(context).secondary,
                          icon: const Icon(
                            Icons.warning_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          label: 'Stock Bajo',
                          value: _model.productos
                              .where((p) => p.stock <= p.stockMinimo)
                              .length
                              .toString(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Expanded(
                        child: _model.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : PlutoGrid(
                                columns: columns,
                                rows: rows,
                                onChanged: _handleCellChange,
                                onLoaded: (event) =>
                                    _model.stateManager = event.stateManager,
                                configuration: PlutoGridConfiguration(
                                  style: PlutoGridStyleConfig(
                                    gridBackgroundColor: FlutterFlowTheme.of(
                                      context,
                                    ).primaryBackground,
                                    rowColor: FlutterFlowTheme.of(
                                      context,
                                    ).secondaryBackground,
                                    columnTextStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                    cellTextStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                    ),
                                    rowHeight: 38,
                                    columnHeight: 34,
                                  ),
                                ),
                              ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(
                            context,
                          ).secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 2,
                              color: Color(0x22000000),
                              offset: Offset(0, -1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Total Costo (Stock)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  formatBs(_model.totalCosto),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Total Venta (Stock)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  formatBs(_model.totalVenta),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
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
              wrapWithModel(
                model: _model.bottomNavModel,
                updateCallback: () => safeSetState(() {}),
                child: const BottomNavWidget(child: BottomNavChild2Widget.new),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
