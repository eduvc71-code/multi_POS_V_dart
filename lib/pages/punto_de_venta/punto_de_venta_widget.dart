import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/cart_item/cart_item_widget.dart';
import 'package:multi_p_o_s/components/product_search_item/product_search_item_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:multi_p_o_s/models/producto_model.dart';

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
                    padding: EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
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
                            ].divide(SizedBox(width: 16)),
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
                                onPressed: () {
                                  debugPrint('IconButton pressed ...');
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8,
                                buttonSize: 40,
                                fillColor: Colors.transparent,
                                icon: Icon(
                                  Icons.person_add_rounded,
                                  color: Colors.black,
                                  size: 24,
                                ),
                                onPressed: () {
                                  debugPrint('IconButton pressed ...');
                                },
                              ),
                            ].divide(SizedBox(width: 8)),
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
                              padding: EdgeInsets.all(24),
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
                                  ].divide(SizedBox(height: 16)),
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
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16),
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
                                    padding: EdgeInsets.all(16),
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
                            padding: EdgeInsets.all(24),
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
                                      padding: EdgeInsets.all(16),
                                      child: Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Icon(
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
                                          ].divide(SizedBox(width: 8)),
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                    ].divide(SizedBox(height: 4)),
                                  ),
                                  wrapWithModel(
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
                                ].divide(SizedBox(height: 16)),
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
                    padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 8),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 34,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 18,
                                          ),
                                          Text(
                                            'F1: Buscar',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                              fontFamily: "Space Grotesk",
                                              color: Colors.black,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              height: 1.3,
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 6)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 34,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.center_focus_weak_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 18,
                                          ),
                                          Text(
                                            'F2: Escanear',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                              fontFamily: "Space Grotesk",
                                              color: Colors.black,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              height: 1.3,
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 6)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 34,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_circle_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 18,
                                          ),
                                          Text(
                                            'F10: Pagar',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                              fontFamily: "Space Grotesk",
                                              color: Colors.black,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              height: 1.3,
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 6)),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16)),
                              ),
                            ),
                          ),
                          Text(
                            'Vendedor: Carlos Méndez',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .copyWith(
                              fontFamily: "Space Grotesk",
                              color: Colors.black,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontWeight,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
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
