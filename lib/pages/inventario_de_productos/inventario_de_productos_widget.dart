import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'package:multi_p_o_s/index.dart';
import 'package:multi_p_o_s/components/inventory_stat/inventory_stat_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav_child2/bottom_nav_child2_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multi_p_o_s/database/inventory_initializer.dart';

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
        width: 120,
        renderer: (rendererContext) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_rounded, color: Colors.blue, size: 20),
                onPressed: () => _showEditDialog(rendererContext.row),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                onPressed: () => _handleDelete(rendererContext.row),
              ),
            ],
          );
        },
      ),
    ];
  }

  Future<void> _loadData() async {
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
    final nombreController = TextEditingController(text: data['nombre'] ?? '');
    final codigoController = TextEditingController(text: data['codigo'] ?? '');
    final costoController = TextEditingController(text: (data['costo'] ?? '').toString());
    final precioController = TextEditingController(text: (data['precio'] ?? '').toString());
    final stockController = TextEditingController(text: (data['stock'] ?? '0').toString());

    final result = await showDialog<Producto>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(data.isEmpty ? 'Nuevo Producto' : 'Cargar desde Librería', 
          style: const TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nombreController, decoration: const InputDecoration(labelText: 'Nombre')),
              TextField(controller: codigoController, decoration: const InputDecoration(labelText: 'Código')),
              TextField(controller: costoController, decoration: const InputDecoration(labelText: 'Costo'), keyboardType: TextInputType.number),
              TextField(controller: precioController, decoration: const InputDecoration(labelText: 'Precio'), keyboardType: TextInputType.number),
              TextField(controller: stockController, decoration: const InputDecoration(labelText: 'Stock'), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, Producto(
                nombre: nombreController.text,
                codigo: codigoController.text,
                costo: double.tryParse(costoController.text) ?? 0.0,
                precio: double.tryParse(precioController.text) ?? 0.0,
                stock: int.tryParse(stockController.text) ?? 0,
                stockMinimo: 10,
              ));
            },
            child: Text(data.isEmpty ? 'Crear' : 'Agregar'),
          ),
        ],
      ),
    );

    if (result != null) {
      await DatabaseHelper.instance.createProducto(result);
      await _loadData();
    }
  }

  Future<void> _handleScan() async {
    final code = await showDialog<String>(
      context: context,
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
      // 1. Buscar en DB local
      final productoDb = await DatabaseHelper.instance.readProductoByCodigo(code);
      if (productoDb != null) {
        _onSearchChanged(code); // Filtrar la grilla para mostrar el producto
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Producto en inventario: ${productoDb.nombre}')),
        );
      } else {
        // 2. Buscar en "Librería" según tipo de empresa
        final prefs = await SharedPreferences.getInstance();
        final businessType = prefs.getString('selectedBusinessType') ?? 'Tienda';
        final productLib = InventoryInitializer.lookupProductInLibrary(code, businessType);
        
        if (productLib != null) {
          _showAddProductDialogWithData(productLib);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Código $code no encontrado en la librería de $businessType')),
          );
        }
      }
    }
  }

  Future<void> _showEditDialog(PlutoRow row) async {
    final id = row.cells['id']?.value;
    if (id == null) return;

    final producto = _model.productos.firstWhere((p) => p.id == id);
    
    final nombreController = TextEditingController(text: producto.nombre);
    final codigoController = TextEditingController(text: producto.codigo);
    final costoController = TextEditingController(text: producto.costo.toString());
    final precioController = TextEditingController(text: producto.precio.toString());
    final stockController = TextEditingController(text: producto.stock.toString());

    final result = await showDialog<Producto>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Producto', style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nombreController, decoration: const InputDecoration(labelText: 'Nombre')),
              TextField(controller: codigoController, decoration: const InputDecoration(labelText: 'Código')),
              TextField(controller: costoController, decoration: const InputDecoration(labelText: 'Costo'), keyboardType: TextInputType.number),
              TextField(controller: precioController, decoration: const InputDecoration(labelText: 'Precio'), keyboardType: TextInputType.number),
              TextField(controller: stockController, decoration: const InputDecoration(labelText: 'Stock'), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, producto.copyWith(
                nombre: nombreController.text,
                codigo: codigoController.text,
                costo: double.tryParse(costoController.text) ?? producto.costo,
                precio: double.tryParse(precioController.text) ?? producto.precio,
                stock: int.tryParse(stockController.text) ?? producto.stock,
              ));
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (result != null) {
      await DatabaseHelper.instance.updateProducto(result);
      await _loadData();
    }
  }

  Future<void> _handleDelete(PlutoRow row) async {
    final id = row.cells['id']?.value;
    if (id != null) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmar'),
          content: const Text('¿Estás seguro de eliminar este producto?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar', style: TextStyle(color: Colors.red))),
          ],
        ),
      );

      if (confirm == true) {
        await DatabaseHelper.instance.deleteProducto(id);
        await _loadData();
      }
    }
  }

  Future<void> _handleCellChange(PlutoGridOnChangedEvent event) async {
    final id = event.row.cells['id']?.value;
    if (id == null) return;

    final productoOriginal = _model.productos.firstWhere((p) => p.id == id);
    Producto productoActualizado;

    switch (event.column.field) {
      case 'costo':
        productoActualizado = productoOriginal.copyWith(costo: event.value.toDouble());
        break;
      case 'precio':
        productoActualizado = productoOriginal.copyWith(precio: event.value.toDouble());
        break;
      case 'stock':
        productoActualizado = productoOriginal.copyWith(stock: event.value.toInt());
        break;
      default:
        return;
    }

    await DatabaseHelper.instance.updateProducto(productoActualizado);
    await _loadData();
  }

  void _onSearchChanged(String query) {
    if (_model.stateManager != null) {
      _model.stateManager!.setFilter((element) {
        final nombre = element.cells['nombre']?.value.toString().toLowerCase() ?? '';
        final codigo = element.cells['codigo']?.value.toString().toLowerCase() ?? '';
        final q = query.toLowerCase();
        return nombre.contains(q) || codigo.contains(q);
      });
    }
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
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Inventario',
                                style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                'Gestion de existencias y precios',
                                style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 24,
                                buttonSize: 40,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
                                onPressed: _showAddProductDialog,
                              ),
                              const SizedBox(width: 8),
                              FlutterFlowIconButton(
                                borderRadius: 24,
                                buttonSize: 40,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 24),
                                onPressed: _handleScan,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      wrapWithModel(
                        model: _model.textFieldModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TextFieldWidget(
                          hint: 'Buscar por nombre o codigo...',
                          onChange: _onSearchChanged,
                          variant: 'filled',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: wrapWithModel(
                        model: _model.inventoryStatModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: InventoryStatWidget(
                          color: FlutterFlowTheme.of(context).primary,
                          icon: const Icon(Icons.inventory_rounded, color: Colors.white, size: 20),
                          label: 'Total Items',
                          value: _model.productos.length.toString(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: wrapWithModel(
                        model: _model.inventoryStatModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: InventoryStatWidget(
                          color: FlutterFlowTheme.of(context).secondary,
                          icon: const Icon(Icons.warning_rounded, color: Colors.white, size: 20),
                          label: 'Stock Bajo',
                          value: _model.productos.where((p) => p.stock <= p.stockMinimo).length.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                    children: [
                      Expanded(
                        child: _model.isLoading 
                          ? const Center(child: CircularProgressIndicator())
                          : PlutoGrid(
                              columns: columns,
                              rows: rows,
                              onChanged: _handleCellChange,
                              onLoaded: (event) => _model.stateManager = event.stateManager,
                              configuration: PlutoGridConfiguration(
                                style: PlutoGridStyleConfig(
                                  gridBackgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                  rowColor: FlutterFlowTheme.of(context).secondaryBackground,
                                  columnTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                  cellTextStyle: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: const [BoxShadow(blurRadius: 4, color: Color(0x33000000), offset: Offset(0, -2))],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Total Costo (Stock)', style: TextStyle(fontSize: 12)),
                                Text('Bs. ${_model.totalCosto.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Total Venta (Stock)', style: TextStyle(fontSize: 12)),
                                Text('Bs. ${_model.totalVenta.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: FlutterFlowTheme.of(context).primary)),
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
    );
  }
}
