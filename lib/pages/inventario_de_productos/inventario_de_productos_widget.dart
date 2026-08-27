import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/index.dart';
import 'package:flutter/material.dart';
import 'package:multi_p_o_s/components/product_item/product_item_widget.dart';

import 'inventario_de_productos_model.dart';
export 'inventario_de_productos_model.dart';

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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InventarioDeProductosModel());
    _loadData();
  }

  Future<void> _loadData() async {
    await _model.fetchProductos();
    if (mounted) {
      setState(() {});
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            debugPrint('FAB pressed ...');
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          icon: Icon(
            Icons.add_rounded,
            color: FlutterFlowTheme.of(context).onPrimary,
            size: 24,
          ),
          elevation: 0,
          label: Text(
            'Nuevo Producto',
            style: FlutterFlowTheme.of(context).labelLarge.copyWith(
                  fontFamily: "Space Grotesk",
                  color: FlutterFlowTheme.of(context).onPrimary,
                  letterSpacing: 0.0,
                  fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                  height: 1.3,
                ),
          ),
        ),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Inventario',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .copyWith(
                                        fontFamily: "Urbanist",
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        height: 1.25,
                                      ),
                                ),
                                Text(
                                  'Gestion de existencias y precios',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .copyWith(
                                        fontFamily: "Poppins",
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        height: 1.4,
                                      ),
                                ),
                              ].divide(const SizedBox(height: 4)),
                            ),
                            FlutterFlowIconButton(
                              borderRadius: 24,
                              buttonSize: 40,
                              fillColor: FlutterFlowTheme.of(context).primary,
                              icon: Icon(
                                Icons.qr_code_scanner_rounded,
                                color: FlutterFlowTheme.of(context).onPrimary,
                                size: 24,
                              ),
                              onPressed: () {
                                debugPrint('IconButton pressed ...');
                              },
                            ),
                          ],
                        ),
                        wrapWithModel(
                          model: _model.textFieldModel,
                          updateCallback: () => safeSetState(() {}),
                          child: TextFieldWidget(
                            label: '',
                            labelPresent: false,
                            helper: '',
                            helperPresent: false,
                            leadingIcon: Icon(
                              Icons.search_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                            leadingIconPresent: true,
                            trailingIconPresent: false,
                            hint: 'Buscar por nombre o codigo...',
                            value: '',
                            onChange: '',
                            onSubmit: '',
                            variant: 'filled',
                            error: false,
                          ),
                        ),
                      ].divide(const SizedBox(height: 16)),
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
              child: SingleChildScrollView(
                primary: false,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: wrapWithModel(
                              model: _model.inventoryStatModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: InventoryStatWidget(
                                color: FlutterFlowTheme.of(context).primary,
                                icon: Icon(
                                  Icons.inventory_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 20,
                                ),
                                label: 'Total Items',
                                value: _model.productos.length.toString(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: wrapWithModel(
                              model: _model.inventoryStatModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: InventoryStatWidget(
                                color: FlutterFlowTheme.of(context).secondary,
                                icon: Icon(
                                  Icons.warning_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 20,
                                ),
                                label: 'Stock Bajo',
                                value: _model.productos
                                    .where((p) => p.stock < 10)
                                    .length
                                    .toString(),
                              ),
                            ),
                          ),
                        ].divide(const SizedBox(width: 16)),
                      ),
                      const SizedBox(height: 24),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Productos',
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .copyWith(
                                  fontFamily: "Urbanist",
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                          ),
                          const SizedBox(height: 16),
                          if (_model.isLoading)
                            const Center(child: CircularProgressIndicator())
                          else if (_model.productos.isEmpty)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(32),
                                child: Text(
                                  'No hay productos en el inventario',
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            )
                          else
                            Column(
                              children: _model.productos
                                  .map((producto) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16),
                                        child: ProductItemWidget(
                                          code: producto.codigo,
                                          name: producto.nombre,
                                          price: producto.precio
                                              .toStringAsFixed(2),
                                          stock: producto.stock.toString(),
                                          statusColor: producto.stock < 10
                                              ? FlutterFlowTheme.of(context)
                                                  .error
                                              : FlutterFlowTheme.of(context)
                                                  .success,
                                        ),
                                      ))
                                  .toList(),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 1),
              child: wrapWithModel(
                model: _model.bottomNavModel,
                updateCallback: () => safeSetState(() {}),
                child: BottomNavWidget(
                  child: () => const BottomNavChild2Widget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
