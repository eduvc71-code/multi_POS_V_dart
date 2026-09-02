import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/components/credit_stat/credit_stat_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/components/client_card/client_card_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav_child3/bottom_nav_child3_widget.dart';
import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:multi_p_o_s/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'clientes_y_cr_ditos_model.dart';
export 'clientes_y_cr_ditos_model.dart';

@Preview()
Widget previewClientesYCreditos() {
  return const ClientesYCreditosWidget();
}

class ClientesYCreditosWidget extends StatefulWidget {
  const ClientesYCreditosWidget({super.key});

  static String routeName = 'ClientesYCreditos';
  static String routePath = '/clientesYCreditos';

  @override
  State<ClientesYCreditosWidget> createState() =>
      _ClientesYCreditosWidgetState();
}

class _ClientesYCreditosWidgetState extends State<ClientesYCreditosWidget> {
  late ClientesYCreditosModel _model;
  List<Map<String, dynamic>> _clientes = [];
  bool _isLoading = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientesYCreditosModel());
    _loadClientes();
  }

  Future<void> _loadClientes() async {
    final list = await DatabaseHelper.instance.readAllClientes();
    if (mounted) {
      setState(() {
        _clientes = list;
        _isLoading = false;
      });
    }
  }

  double get _totalPorCobrar {
    double sum = 0;
    for (var c in _clientes) {
      sum += (c['deuda'] as num? ?? 0.0).toDouble();
    }
    return sum;
  }

  Future<void> _handleAgregarCliente() async {
    String nombre = '';
    String nit = '';
    String telefono = '';
    String direccion = '';

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nuevo Cliente'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Nombre Completo *'),
                  onChanged: (val) => nombre = val,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'NIT / CI'),
                  onChanged: (val) => nit = val,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                  onChanged: (val) => telefono = val,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Dirección'),
                  onChanged: (val) => direccion = val,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nombre.trim().isNotEmpty) {
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );

    if (confirm == true && nombre.trim().isNotEmpty) {
      await DatabaseHelper.instance.createCliente(
        nombre: nombre,
        nit: nit,
        telefono: telefono,
        direccion: direccion,
      );
      await _loadClientes();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cliente "$nombre" registrado correctamente.'),
            backgroundColor: FlutterFlowTheme.of(context).success,
          ),
        );
      }
    }
  }

  Future<void> _handleAbono(Map<String, dynamic> cliente) async {
    final int clienteId = cliente['id'];
    final String nombre = cliente['nombre'] ?? '';
    final double deudaActual = (cliente['deuda'] as num? ?? 0.0).toDouble();

    if (deudaActual <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Este cliente no tiene saldo deudor.')),
      );
      return;
    }

    double montoAbono = 0.0;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Abono - $nombre'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Deuda Actual: Bs. ${deudaActual.toStringAsFixed(2)}'),
              const SizedBox(height: 12),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Monto a Abonar (Bs.)'),
                onChanged: (val) {
                  montoAbono = double.tryParse(val) ?? 0.0;
                },
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
              child: const Text('Registrar Abono'),
            ),
          ],
        );
      },
    );

    if (confirm == true && montoAbono > 0) {
      try {
        await DatabaseHelper.instance.processAbonoCredito(
          clienteId: clienteId,
          monto: montoAbono,
          descripcion: 'Abono realizado desde Clientes y Créditos',
        );
        await _loadClientes();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Abono de Bs. ${montoAbono.toStringAsFixed(2)} registrado exitosamente.'),
              backgroundColor: FlutterFlowTheme.of(context).success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al registrar abono: $e'),
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
                    padding: const EdgeInsets.all(24),
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
                              Row(
                                children: [
                                  FlutterFlowIconButton(
                                    borderRadius: 8,
                                    buttonSize: 40,
                                    fillColor: Colors.transparent,
                                    icon: const Icon(Icons.arrow_back_rounded, size: 24),
                                    onPressed: () async {
                                      context.goNamed(PanelPrincipalWidget.routeName);
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Clientes y Créditos',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .copyWith(
                                              fontFamily: "Urbanist",
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              height: 1.25,
                                            ),
                                      ),
                                      Text(
                                        'Gestiona deudas y estados de cuenta',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .copyWith(
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                              letterSpacing: 0.0,
                                              fontWeight: FlutterFlowTheme.of(
                                                context,
                                              ).bodySmall.fontWeight,
                                              height: 1.4,
                                            ),
                                      ),
                                    ].divide(const SizedBox(height: 4)),
                                  ),
                                ],
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 24,
                                buttonSize: 40,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: Icon(
                                  Icons.person_add_rounded,
                                  color: FlutterFlowTheme.of(context).onPrimary,
                                  size: 24,
                                ),
                                onPressed: _handleAgregarCliente,
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
                                Icons.search,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24,
                              ),
                              leadingIconPresent: true,
                              trailingIconPresent: false,
                              hint: 'Buscar por nombre o QR...',
                              value: '',
                              onSubmit: '',
                              variant: 'filled',
                              error: false,
                            ),
                          ),
                        ].divide(const SizedBox(height: 16)),
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
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.creditStatModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: CreditStatWidget(
                                      icon: Icon(
                                        Icons.payments_rounded,
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).primary,
                                        size: 20,
                                      ),
                                      label: 'Por Cobrar',
                                      tone: FlutterFlowTheme.of(
                                        context,
                                      ).primary,
                                      value: 'Bs. ${_totalPorCobrar.toStringAsFixed(2)}',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.creditStatModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: CreditStatWidget(
                                      icon: Icon(
                                        Icons.people_alt_rounded,
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).primary,
                                        size: 20,
                                      ),
                                      label: 'Clientes',
                                      tone: FlutterFlowTheme.of(context).secondary,
                                      value: '${_clientes.length}',
                                    ),
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
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).alternate,
                                        width: 1,
                                      ),
                                    ),
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                        12,
                                        0,
                                        12,
                                        0,
                                      ),
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
                                              context,
                                            ).primaryText,
                                            size: 16,
                                          ),
                                          Text(
                                            'Todos',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                                  fontFamily: "Space Grotesk",
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).primaryText,
                                                  fontSize: 14,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                        context,
                                                      ).labelMedium.fontWeight,
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
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).alternate,
                                        width: 1,
                                      ),
                                    ),
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                        12,
                                        0,
                                        12,
                                        0,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Con Deuda',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                                  fontFamily: "Space Grotesk",
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).primaryText,
                                                  fontSize: 14,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                        context,
                                                      ).labelMedium.fontWeight,
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
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).alternate,
                                        width: 1,
                                      ),
                                    ),
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                        12,
                                        0,
                                        12,
                                        0,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Al día',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                                  fontFamily: "Space Grotesk",
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).primaryText,
                                                  fontSize: 14,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                        context,
                                                      ).labelMedium.fontWeight,
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
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).alternate,
                                        width: 1,
                                      ),
                                    ),
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                        12,
                                        0,
                                        12,
                                        0,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Suspendidos',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                                  fontFamily: "Space Grotesk",
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).primaryText,
                                                  fontSize: 14,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                        context,
                                                      ).labelMedium.fontWeight,
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
                            else if (_clientes.isEmpty)
                              const Center(child: Text('No hay clientes registrados.'))
                            else
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Directorio de Clientes (${_clientes.length})',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .copyWith(
                                          fontFamily: "Urbanist",
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          height: 1.4,
                                        ),
                                  ),
                                  ..._clientes.map((c) {
                                    final String nombre = c['nombre'] ?? '';
                                    final double deuda = (c['deuda'] as num? ?? 0.0).toDouble();

                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: InkWell(
                                        onTap: () => _handleAbono(c),
                                        child: ClientCardWidget(
                                          debt: 'Bs. ${deuda.toStringAsFixed(2)}',
                                          name: nombre,
                                          isOverdue: deuda > 1000,
                                        ),
                                      ),
                                    );
                                  }),
                                ].divide(const SizedBox(height: 12)),
                              ),
                          ].divide(const SizedBox(height: 24)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 1),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primaryBackground,
                      Colors.transparent,
                    ],
                    stops: const [0, 1],
                    begin: const AlignmentDirectional(0, 1),
                    end: const AlignmentDirectional(0, -1),
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    child: wrapWithModel(
                      model: _model.buttonModel,
                      updateCallback: () => safeSetState(() {}),
                      child: ButtonWidget(
                        icon: Icon(
                          Icons.add_card_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24,
                        ),
                        iconPresent: true,
                        iconEndPresent: false,
                        content: 'Registrar Abono Rápido',
                        variant: 'primary',
                        size: 'large',
                        fullWidth: true,
                        loading: false,
                        disabled: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 1),
              child: Container(
                child: wrapWithModel(
                  model: _model.bottomNavModel,
                  updateCallback: () => safeSetState(() {}),
                  child: BottomNavWidget(child: () => const BottomNavChild3Widget()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
