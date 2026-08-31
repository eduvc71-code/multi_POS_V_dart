import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/components/sale_row/sale_row_widget.dart';
import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'historial_de_ventas_model.dart';
export 'historial_de_ventas_model.dart';

@Preview()
Widget previewHistorialDeVentas() {
  return const HistorialDeVentasWidget();
}

class HistorialDeVentasWidget extends StatefulWidget {
  const HistorialDeVentasWidget({super.key});

  static String routeName = 'HistorialDeVentas';
  static String routePath = '/historialDeVentas';

  @override
  State<HistorialDeVentasWidget> createState() =>
      _HistorialDeVentasWidgetState();
}

class _HistorialDeVentasWidgetState extends State<HistorialDeVentasWidget> {
  late HistorialDeVentasModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistorialDeVentasModel());
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
            Icons.assessment_rounded,
            color: FlutterFlowTheme.of(context).onPrimary,
            size: 24,
          ),
          elevation: 0,
          label: Text(
            'Reporte del Día',
            style: FlutterFlowTheme.of(context).labelLarge.copyWith(
              fontFamily: "Space Grotesk",
              color: FlutterFlowTheme.of(context).onPrimary,
              letterSpacing: 0.0,
              fontWeight:
              FlutterFlowTheme.of(context).labelLarge.fontWeight,
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
                                  size: 24,
                                ),
                                onPressed: () async {
                                  GoRouter.of(context)
                                      .goNamed(PanelPrincipalWidget.routeName);
                                },
                              ),
                              Text(
                                'Historial de Ventas',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .copyWith(
                                  fontFamily: "Urbanist",
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                              ),
                            ].divide(SizedBox(width: 16)),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 40,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.filter_list_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 24,
                            ),
                            onPressed: () {
                              debugPrint('IconButton pressed ...');
                            },
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
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Ventas Hoy', style: FlutterFlowTheme.of(context).labelMedium),
                                      Text('Bs. 4.250,00', 
                                        style: FlutterFlowTheme.of(context).headlineSmall.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: FlutterFlowTheme.of(context).success,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Transacciones', style: FlutterFlowTheme.of(context).labelMedium),
                                      Text('24', 
                                        style: FlutterFlowTheme.of(context).titleMedium.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.textFieldModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: TextFieldWidget(
                                      label: '',
                                      labelPresent: false,
                                      helper: '',
                                      helperPresent: false,
                                      leadingIcon: Icon(
                                        Icons.search,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24,
                                      ),
                                      leadingIconPresent: true,
                                      trailingIconPresent: false,
                                      hint: 'Buscar por folio o cliente',
                                      value: '',
                                      onSubmit: '',
                                      variant: 'filled',
                                      error: false,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(24),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1,
                                    ),
                                  ),
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Icon(
                                    Icons.calendar_today_rounded,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                              ].divide(SizedBox(width: 16)),
                            ),
                            SingleChildScrollView(
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
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1,
                                      ),
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
                                            Icons.check_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 16,
                                          ),
                                          Text(
                                            'Todas',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                              fontFamily: "Space Grotesk",
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
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
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1,
                                      ),
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
                                          Text(
                                            'Completadas',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                              fontFamily: "Space Grotesk",
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
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
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1,
                                      ),
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
                                          Text(
                                            'Crédito',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                              fontFamily: "Space Grotesk",
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
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
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1,
                                      ),
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
                                          Text(
                                            'Anuladas',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                              fontFamily: "Space Grotesk",
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
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
                                ].divide(SizedBox(width: 8)),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Hoy, 24 de Mayo',
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .copyWith(
                                    fontFamily: "Space Grotesk",
                                    color: Colors.black,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    height: 1.3,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.saleRowModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SaleRowWidget(
                                    folio: 'V-000482',
                                    method: 'Efectivo',
                                    statusColor:
                                    FlutterFlowTheme.of(context).success,
                                    time: '14:20',
                                    total: '348,50',
                                    status: 'completada',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.saleRowModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SaleRowWidget(
                                    folio: 'V-000481',
                                    method: 'Crédito',
                                    statusColor:
                                    FlutterFlowTheme.of(context).warning,
                                    time: '13:45',
                                    total: '1.200,00',
                                    status: 'Pendiente',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.saleRowModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SaleRowWidget(
                                    folio: 'V-000480',
                                    method: 'Transferencia',
                                    statusColor:
                                    FlutterFlowTheme.of(context).error,
                                    time: '12:10',
                                    total: '85,00',
                                    status: 'anulada',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.saleRowModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SaleRowWidget(
                                    folio: 'V-000479',
                                    method: 'Tarjeta',
                                    statusColor:
                                    FlutterFlowTheme.of(context).success,
                                    time: '11:30',
                                    total: '520,00',
                                    status: 'completada',
                                  ),
                                ),
                                Text(
                                  'Ayer, 23 de Mayo',
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .copyWith(
                                    fontFamily: "Space Grotesk",
                                    color: Colors.black,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    height: 1.3,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.saleRowModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SaleRowWidget(
                                    folio: 'V-000478',
                                    method: 'Efectivo',
                                    statusColor:
                                    FlutterFlowTheme.of(context).success,
                                    time: '18:05',
                                    total: '210,00',
                                    status: 'completada',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.saleRowModel6,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SaleRowWidget(
                                    folio: 'V-000477',
                                    method: 'Crédito',
                                    statusColor:
                                    FlutterFlowTheme.of(context).success,
                                    time: '17:40',
                                    total: '1.540,00',
                                    status: 'completada',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.saleRowModel7,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SaleRowWidget(
                                    folio: 'V-000476',
                                    method: 'Efectivo',
                                    statusColor:
                                    FlutterFlowTheme.of(context).tertiary,
                                    time: '16:15',
                                    total: '45,50',
                                    status: 'Devolución',
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
          ],
        ),
      ),
    );
  }
}
