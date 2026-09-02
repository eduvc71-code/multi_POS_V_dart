import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/components/sale_row/sale_row_widget.dart';
import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:multi_p_o_s/database/database_helper.dart';
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
  List<Map<String, dynamic>> _ventas = [];
  bool _isLoading = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistorialDeVentasModel());
    _loadVentas();
  }

  Future<void> _loadVentas() async {
    final list = await DatabaseHelper.instance.readAllVentas();
    if (mounted) {
      setState(() {
        _ventas = list;
        _isLoading = false;
      });
    }
  }

  Future<void> _handleAnularVenta(Map<String, dynamic> venta) async {
    final int ventaId = venta['id'];
    final String estado = venta['estado'] ?? 'COMPLETADA';

    if (estado == 'ANULADA') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Esta venta ya se encuentra anulada.')),
      );
      return;
    }

    String motivo = 'Cliente solicitó devolución';

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Anular Venta #$ventaId'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total: Bs. ${(venta['total'] as num).toStringAsFixed(2)}'),
              Text('Método: ${venta['metodo_pago']}'),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(labelText: 'Motivo de anulación'),
                onChanged: (val) => motivo = val,
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Anular y Reintegrar Stock'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await DatabaseHelper.instance.processReturnSale(
          ventaId: ventaId,
          motivo: motivo,
        );
        await _loadVentas();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Venta #$ventaId anulada correctamente.'),
              backgroundColor: FlutterFlowTheme.of(context).success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al anular venta: $e'),
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
                                icon: const Icon(
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
                            ].divide(const SizedBox(width: 16)),
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
                      padding: const EdgeInsets.all(24),
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
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: const Icon(
                                    Icons.calendar_today_rounded,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                              ].divide(const SizedBox(width: 16)),
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
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
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
                                        ].divide(const SizedBox(width: 6)),
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
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
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
                                        ].divide(const SizedBox(width: 6)),
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
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
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
                                        ].divide(const SizedBox(width: 6)),
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
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
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
                                        ].divide(const SizedBox(width: 6)),
                                      ),
                                    ),
                                  ),
                                ].divide(const SizedBox(width: 8)),
                              ),
                            ),
                            if (_isLoading)
                              const Center(child: CircularProgressIndicator())
                            else if (_ventas.isEmpty)
                              const Center(child: Text('No hay ventas registradas.'))
                            else
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: _ventas.map((v) {
                                  final int id = v['id'];
                                  final double total = (v['total'] as num).toDouble();
                                  final String metodo = v['metodo_pago'] ?? 'EFECTIVO';
                                  final String estado = v['estado'] ?? 'COMPLETADA';
                                  final String fecha = v['fecha'] ?? '';

                                  Color statusColor = FlutterFlowTheme.of(context).success;
                                  if (estado == 'ANULADA') {
                                    statusColor = FlutterFlowTheme.of(context).error;
                                  } else if (metodo == 'CREDITO') {
                                    statusColor = FlutterFlowTheme.of(context).warning;
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: InkWell(
                                      onTap: () => _handleAnularVenta(v),
                                      child: SaleRowWidget(
                                        folio: 'V-${id.toString().padLeft(6, '0')}',
                                        method: metodo,
                                        statusColor: statusColor,
                                        time: fecha.length > 16 ? fecha.substring(11, 16) : fecha,
                                        total: total.toStringAsFixed(2),
                                        status: estado,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                          ].divide(const SizedBox(height: 24)),
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
