import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav_child2/bottom_nav_child2_widget.dart';
import 'package:multi_p_o_s/components/inventory_stat/inventory_stat_widget.dart';
import 'package:multi_p_o_s/components/product_item/product_item_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
            print('FAB pressed ...');
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
            style: FlutterFlowTheme.of(context).labelLarge.override(
              font: GoogleFonts.spaceGrotesk(
                fontWeight:
                FlutterFlowTheme.of(context).labelLarge.fontWeight,
                fontStyle:
                FlutterFlowTheme.of(context).labelLarge.fontStyle,
              ),
              color: FlutterFlowTheme.of(context).onPrimary,
              letterSpacing: 0.0,
              fontWeight:
              FlutterFlowTheme.of(context).labelLarge.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
              lineHeight: 1.3,
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
                    padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 16),
                    child: Container(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Inventario',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                      font: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.bold,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                      lineHeight: 1.25,
                                    ),
                                  ),
                                  Text(
                                    'Gestión de existencias y precios',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                      font: GoogleFonts.poppins(
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                                  ),
                                ].divide(SizedBox(height: 4)),
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
                                  print('IconButton pressed ...');
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
                              hint: 'Buscar por nombre o código...',
                              value: '',
                              onChange: '',
                              onSubmit: '',
                              variant: 'filled',
                              error: false,
                            ),
                          ),
                        ].divide(SizedBox(height: 16)),
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
                        padding: EdgeInsets.all(24),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        icon: Icon(
                                          Icons.inventory_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 20,
                                        ),
                                        label: 'Total Items',
                                        value: '1,284',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.inventoryStatModel2,
                                      updateCallback: () => safeSetState(() {}),
                                      child: InventoryStatWidget(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        icon: Icon(
                                          Icons.warning_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 20,
                                        ),
                                        label: 'Stock Bajo',
                                        value: '12',
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Categorías',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      font: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.bold,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 34,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            border: Border.all(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 1,
                                            ),
                                          ),
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                12, 0, 12, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.check_rounded,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primaryText,
                                                  size: 16,
                                                ),
                                                Text(
                                                  'Todos',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .override(
                                                    font: GoogleFonts
                                                        .spaceGrotesk(
                                                      fontWeight:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelMedium
                                                          .fontWeight,
                                                      fontStyle:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelMedium
                                                          .fontStyle,
                                                    ),
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                    fontSize: 14,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelMedium
                                                        .fontWeight,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelMedium
                                                        .fontStyle,
                                                    lineHeight: 1.3,
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
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            border: Border.all(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 1,
                                            ),
                                          ),
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                12, 0, 12, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Aceites',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .override(
                                                    font: GoogleFonts
                                                        .spaceGrotesk(
                                                      fontWeight:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelMedium
                                                          .fontWeight,
                                                      fontStyle:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelMedium
                                                          .fontStyle,
                                                    ),
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                    fontSize: 14,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelMedium
                                                        .fontWeight,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelMedium
                                                        .fontStyle,
                                                    lineHeight: 1.3,
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
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            border: Border.all(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 1,
                                            ),
                                          ),
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                12, 0, 12, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Filtros',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .override(
                                                    font: GoogleFonts
                                                        .spaceGrotesk(
                                                      fontWeight:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelMedium
                                                          .fontWeight,
                                                      fontStyle:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelMedium
                                                          .fontStyle,
                                                    ),
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                    fontSize: 14,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelMedium
                                                        .fontWeight,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelMedium
                                                        .fontStyle,
                                                    lineHeight: 1.3,
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
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            border: Border.all(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 1,
                                            ),
                                          ),
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                12, 0, 12, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Frenos',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .override(
                                                    font: GoogleFonts
                                                        .spaceGrotesk(
                                                      fontWeight:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelMedium
                                                          .fontWeight,
                                                      fontStyle:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelMedium
                                                          .fontStyle,
                                                    ),
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                    fontSize: 14,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelMedium
                                                        .fontWeight,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelMedium
                                                        .fontStyle,
                                                    lineHeight: 1.3,
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
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            border: Border.all(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 1,
                                            ),
                                          ),
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                12, 0, 12, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Iluminación',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .override(
                                                    font: GoogleFonts
                                                        .spaceGrotesk(
                                                      fontWeight:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelMedium
                                                          .fontWeight,
                                                      fontStyle:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelMedium
                                                          .fontStyle,
                                                    ),
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                    fontSize: 14,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelMedium
                                                        .fontWeight,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelMedium
                                                        .fontStyle,
                                                    lineHeight: 1.3,
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 6)),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8)),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 8)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Productos',
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                          font: GoogleFonts.urbanist(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .fontStyle,
                                          ),
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                      ),
                                      Text(
                                        'Ver archivados',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                          font: GoogleFonts.spaceGrotesk(
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .fontStyle,
                                          ),
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                          FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .fontWeight,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .fontStyle,
                                          lineHeight: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  wrapWithModel(
                                    model: _model.productItemModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ProductItemWidget(
                                      code: 'MOT-001',
                                      name: 'Aceite Sintético 5W-30',
                                      price: '85,00',
                                      statusColor:
                                      FlutterFlowTheme.of(context).success,
                                      stock: '45',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.productItemModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ProductItemWidget(
                                      code: 'BRK-242',
                                      name: 'Pastillas de Freno Delanteras',
                                      price: '210,00',
                                      statusColor:
                                      FlutterFlowTheme.of(context).warning,
                                      stock: '8',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.productItemModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ProductItemWidget(
                                      code: 'FLT-99',
                                      name: 'Filtro de Aire Premium',
                                      price: '45,50',
                                      statusColor:
                                      FlutterFlowTheme.of(context).success,
                                      stock: '120',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.productItemModel4,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ProductItemWidget(
                                      code: 'BAT-P01',
                                      name: 'Batería 12V 75Ah',
                                      price: '650,00',
                                      statusColor:
                                      FlutterFlowTheme.of(context).error,
                                      stock: '3',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.productItemModel5,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ProductItemWidget(
                                      code: 'NGK-IR',
                                      name: 'Bujía Iridium Power',
                                      price: '35,00',
                                      statusColor:
                                      FlutterFlowTheme.of(context).success,
                                      stock: '24',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.productItemModel6,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ProductItemWidget(
                                      code: 'TIM-K02',
                                      name: 'Kit de Distribución',
                                      price: '1.120,00',
                                      statusColor:
                                      FlutterFlowTheme.of(context).success,
                                      stock: '15',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.productItemModel7,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ProductItemWidget(
                                      code: 'LIQ-04',
                                      name: 'Líquido de Frenos DOT4',
                                      price: '25,00',
                                      statusColor:
                                      FlutterFlowTheme.of(context).warning,
                                      stock: '5',
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16)),
                              ),
                            ].divide(SizedBox(height: 24)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 1),
              child: Container(
                child: wrapWithModel(
                  model: _model.bottomNavModel,
                  updateCallback: () => safeSetState(() {}),
                  child: BottomNavWidget(
                    child: () => BottomNavChild2Widget(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
