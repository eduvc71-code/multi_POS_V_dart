import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/cart_item/cart_item_widget.dart';
import 'package:multi_p_o_s/components/product_search_item/product_search_item_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:multi_p_o_s/models/producto_model.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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

  void _onSearchChanged(String value) async {
    await _model.searchProducts(value);
    if (mounted) {
      setState(() {});
    }
  }

  void _handleAddToCart(Producto producto) {
    final error = _model.addToCart(producto);
    if (error.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
    } else {
      setState(() {});
    }
  }

  Future<void> _handleScan() async {
    final code = await showDialog<String>(
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Escanear para Vender'),
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
        _handleAddToCart(productoDb);
      } else {
        // 2. Buscar en "Librería" según tipo de empresa
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
              stock: 1, // Agregar con 1 de stock para la venta
              stockMinimo: 5,
            );
            await DatabaseHelper.instance.createProducto(nuevoProducto);
            // Volver a leer para tener el ID
            final p = await DatabaseHelper.instance.readProductoByCodigo(code);
            if (p != null) _handleAddToCart(p);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Código $code no encontrado en inventario ni en librería.')),
          );
        }
      }
    }
  }

  Future<void> _handleCheckout() async {
    if (_model.cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El carrito está vacío')),
      );
      return;
    }

    String selectedMetodo = 'EFECTIVO';

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Procesar Cobro'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total a Cobrar: Bs. ${_model.total.toStringAsFixed(2)}',
                    style: FlutterFlowTheme.of(context).titleMedium,
                  ),
                  const SizedBox(height: 16),
                  const Text('Seleccione Método de Pago:'),
                  DropdownButton<String>(
                    value: selectedMetodo,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'EFECTIVO', child: Text('Efectivo')),
                      DropdownMenuItem(value: 'TARJETA', child: Text('Tarjeta Débito/Crédito')),
                      DropdownMenuItem(value: 'TRANSFERENCIA', child: Text('Transferencia / QR')),
                      DropdownMenuItem(value: 'CREDITO', child: Text('Venta a Crédito')),
                    ],
                    onChanged: (val) {
                      if (val != null) setStateDialog(() => selectedMetodo = val);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, selectedMetodo),
                  child: const Text('Confirmar Venta'),
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
        _model.cart.forEach((productId, qty) {
          final p = _model.cartProducts.firstWhere((p) => p.id == productId);
          items.add({
            'producto_id': productId,
            'cantidad': qty,
            'precio_unitario': p.precio,
            'subtotal': p.precio * qty,
          });
        });

        final ventaId = await DatabaseHelper.instance.processAtomicSale(
          items: items,
          total: _model.total,
          subtotal: _model.total,
          descuento: 0.0,
          metodoPago: result,
        );

        _model.cart.clear();
        _model.cartProducts.clear();
        await _model.searchProducts('');

        if (mounted) {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Venta #$ventaId registrada exitosamente ($result)'),
              backgroundColor: FlutterFlowTheme.of(context).success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al procesar la venta: $e'),
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 8,
                                buttonSize: 40,
                                fillColor: Colors.transparent,
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color:
                                  FlutterFlowTheme.of(context).primaryText,
                                  size: 24,
                                ),
                                onPressed: () async {
                                  GoRouter.of(context)
                                      .goNamed(PanelPrincipalWidget.routeName);
                                },
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Punto de Venta',
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .copyWith(
                                      fontFamily: "Urbanist",
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                  Text(
                                    'Caja Abierta · Terminal 01',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .copyWith(
                                      fontFamily: "Space Grotesk",
                                      color: Colors.black,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ].divide(const SizedBox(width: 16)),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 12,
                                buttonSize: 40,
                                fillColor:
                                FlutterFlowTheme.of(context).primary10,
                                icon: Icon(
                                  Icons.qr_code_scanner_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24,
                                ),
                                onPressed: _handleScan,
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8,
                                buttonSize: 40,
                                fillColor: Colors.transparent,
                                icon: const Icon(
                                  Icons.person_add_rounded,
                                  color: Colors.black,
                                  size: 24,
                                ),
                                onPressed: () {
                                  debugPrint('IconButton pressed ...');
                                },
                              ),
                            ].divide(const SizedBox(width: 8)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: SingleChildScrollView(
                        primary: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    wrapWithModel(
                                      model: _model.textFieldModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldWidget(
                                        label: 'Buscar producto',
                                        labelPresent: true,
                                        helper: '',
                                        helperPresent: false,
                                        leadingIcon: Icon(
                                          Icons.search_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24,
                                        ),
                                        leadingIconPresent: true,
                                        trailingIconPresent: false,
                                        hint: 'Nombre o código de barras...',
                                        value: '',
                                        onChange: _onSearchChanged,
                                        onSubmit: '',
                                        variant: 'outlined',
                                        error: false,
                                      ),
                                    ),
                                    Text(
                                      'Resultados',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .copyWith(
                                        fontFamily: "Space Grotesk",
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        height: 1.3,
                                      ),
                                    ),
                                    if (_model.isLoading)
                                      const Center(child: CircularProgressIndicator())
                                    else if (_model.searchResults.isEmpty)
                                      const Center(child: Text('No se encontraron productos'))
                                    else
                                      Column(
                                        children: _model.searchResults.map((producto) => 
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 8.0),
                                            child: InkWell(
                                              onTap: () => _handleAddToCart(producto),
                                              child: ProductSearchItemWidget(
                                                code: producto.codigo,
                                                name: producto.nombre,
                                                price: producto.precio.toStringAsFixed(2),
                                                tone: producto.stock <= producto.stockMinimo 
                                                  ? FlutterFlowTheme.of(context).error 
                                                  : FlutterFlowTheme.of(context).tertiary,
                                                stock: producto.stock.toString(),
                                              ),
                                            ),
                                          )
                                        ).toList(),
                                      ),
                                  ].divide(const SizedBox(height: 16)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 380,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Carrito de Ventas',
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .copyWith(
                                          fontFamily: "Urbanist",
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: SingleChildScrollView(
                              primary: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          if (_model.cart.isEmpty)
                                            const Center(child: Text('El carrito está vacío'))
                                          else
                                            Column(
                                              children: _model.cartProducts.map((producto) =>
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                  child: CartItemWidget(
                                                    name: producto.nombre,
                                                    qty: _model.cart[producto.id].toString(),
                                                    subtotal: (producto.precio * _model.cart[producto.id]!).toStringAsFixed(2),
                                                  ),
                                                )
                                              ).toList(),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(12),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.account_circle_rounded,
                                              color: Colors.black,
                                              size: 24,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Cliente: Consumidor Final',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .copyWith(
                                                  fontFamily: "Poppins",
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .fontWeight,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.edit_rounded,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              size: 16,
                                            ),
                                          ].divide(const SizedBox(width: 8)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Subtotal',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .copyWith(
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontWeight,
                                              height: 1.5,
                                            ),
                                          ),
                                          Text(
                                            'Bs. ${_model.total.toStringAsFixed(2)}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .copyWith(
                                              fontFamily: "Poppins",
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontWeight,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Descuento',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .copyWith(
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontWeight,
                                              height: 1.5,
                                            ),
                                          ),
                                          Text(
                                            'Bs. 0,00',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .copyWith(
                                              fontFamily: "Poppins",
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontWeight,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 8, 0, 8),
                                        child: Container(
                                          child: Divider(
                                            height: 16,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'TOTAL',
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .copyWith(
                                              fontFamily: "Urbanist",
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w900,
                                              height: 1.3,
                                            ),
                                          ),
                                          Text(
                                            'Bs. ${_model.total.toStringAsFixed(2)}',
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .copyWith(
                                              fontFamily: "Urbanist",
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primary,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w900,
                                              height: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ].divide(const SizedBox(height: 4)),
                                  ),
                                  InkWell(
                                    onTap: _handleCheckout,
                                    child: wrapWithModel(
                                      model: _model.buttonModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ButtonWidget(
                                        icon: Icon(
                                          Icons.payments_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24,
                                        ),
                                        iconPresent: true,
                                        iconEndPresent: false,
                                        content: 'COBRAR AHORA',
                                        variant: 'primary',
                                        size: 'large',
                                        fullWidth: true,
                                        loading: false,
                                        disabled: false,
                                      ),
                                    ),
                                  ),
                                ].divide(const SizedBox(height: 16)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).success,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Modo Táctil / Escáner Activo',
                              style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                                color: Colors.black87,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Vendedor: Administrador',
                          style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                            fontFamily: "Space Grotesk",
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
