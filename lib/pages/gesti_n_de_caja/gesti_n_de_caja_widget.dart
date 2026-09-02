import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/components/cash_stat/cash_stat_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/movement_item/movement_item_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:multi_p_o_s/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'gesti_n_de_caja_model.dart';
export 'gesti_n_de_caja_model.dart';

@Preview()
Widget previewGestionDeCaja() {
  return const GestionDeCajaWidget();
}

class GestionDeCajaWidget extends StatefulWidget {
  const GestionDeCajaWidget({super.key});

  static String routeName = 'GestionDeCaja';
  static String routePath = '/gestionDeCaja';

  @override
  State<GestionDeCajaWidget> createState() => _GestionDeCajaWidgetState();
}

class _GestionDeCajaWidgetState extends State<GestionDeCajaWidget> {
  late GestionDeCajaModel _model;
  Map<String, dynamic>? _sesionActiva;
  List<Map<String, dynamic>> _movimientos = [];
  bool _isLoading = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GestionDeCajaModel());
    _loadCajaData();
  }

  Future<void> _loadCajaData() async {
    final sesion = await DatabaseHelper.instance.getCajaSesionActiva();
    final movs = await DatabaseHelper.instance.readAllMovimientosCaja();
    if (mounted) {
      setState(() {
        _sesionActiva = sesion;
        _movimientos = movs;
        _isLoading = false;
      });
    }
  }

  Future<void> _handleAbrirCaja() async {
    double montoInicial = 0.0;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Apertura de Caja'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Ingrese el monto inicial con el que abre la caja:'),
              const SizedBox(height: 12),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Monto Inicial (Bs.)', hintText: '100.00'),
                onChanged: (val) {
                  montoInicial = double.tryParse(val) ?? 0.0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Abrir Caja'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await DatabaseHelper.instance.abrirCajaSesion(montoInicial);
        await _loadCajaData();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Caja abierta con monto inicial de Bs. ${montoInicial.toStringAsFixed(2)}'),
              backgroundColor: FlutterFlowTheme.of(context).success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
        }
      }
    }
  }

  Future<void> _handleCerrarCaja() async {
    if (_sesionActiva == null) return;
    final int sesionId = _sesionActiva!['id'];
    double montoFinal = 0.0;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Arqueo y Cierre de Caja'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Monto Inicial: Bs. ${(_sesionActiva!['monto_inicial'] as num).toStringAsFixed(2)}'),
              const SizedBox(height: 12),
              const Text('Ingrese el conteo físico de dinero al cierre:'),
              const SizedBox(height: 12),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Monto Conteo Físico (Bs.)'),
                onChanged: (val) {
                  montoFinal = double.tryParse(val) ?? 0.0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Cerrar Turno'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await DatabaseHelper.instance.cerrarCajaSesion(sesionId, montoFinal);
        await _loadCajaData();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Caja cerrada exitosamente.'),
              backgroundColor: FlutterFlowTheme.of(context).success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al cerrar caja: $e'),
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
                      child: Row(
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
                                    'Gestión de Caja',
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
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: _sesionActiva != null
                                              ? FlutterFlowTheme.of(context).success
                                              : FlutterFlowTheme.of(context).error,
                                          borderRadius: BorderRadius.circular(9999),
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                      Text(
                                        _sesionActiva != null
                                            ? 'Caja abierta · Inicial: Bs. ${(_sesionActiva!['monto_inicial'] as num).toStringAsFixed(2)}'
                                            : 'Caja Cerrada · Sin turno activo',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .copyWith(
                                              fontFamily: "Space Grotesk",
                                              color: Colors.black,
                                              letterSpacing: 0.0,
                                              fontWeight: FlutterFlowTheme.of(
                                                context,
                                              ).labelMedium.fontWeight,
                                              height: 1.3,
                                            ),
                                      ),
                                    ].divide(const SizedBox(width: 4)),
                                  ),
                                ].divide(const SizedBox(height: 4)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: _sesionActiva != null ? _handleCerrarCaja : _handleAbrirCaja,
                                icon: Icon(_sesionActiva != null ? Icons.lock_outline : Icons.lock_open, size: 18),
                                label: Text(_sesionActiva != null ? 'Cerrar Caja' : 'Abrir Caja'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _sesionActiva != null
                                      ? FlutterFlowTheme.of(context).warning
                                      : FlutterFlowTheme.of(context).primary,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
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
                                        model: _model.cashStatModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: CashStatWidget(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).info,
                                          icon: Icon(
                                            Icons
                                                .account_balance_wallet_rounded,
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).info,
                                            size: 20,
                                          ),
                                          label: 'Monto Inicial',
                                          value: 'Bs. 500,00',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: wrapWithModel(
                                        model: _model.cashStatModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: CashStatWidget(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).success,
                                          icon: Icon(
                                            Icons.shopping_cart_rounded,
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).info,
                                            size: 20,
                                          ),
                                          label: 'Ventas Hoy',
                                          value: 'Bs. 2.450,50',
                                        ),
                                      ),
                                    ),
                                  ].divide(const SizedBox(width: 16)),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: wrapWithModel(
                                        model: _model.cashStatModel3,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: CashStatWidget(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          icon: Icon(
                                            Icons.payments_rounded,
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).info,
                                            size: 20,
                                          ),
                                          label: 'Egresos',
                                          value: 'Bs. 120,00',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: wrapWithModel(
                                        model: _model.cashStatModel4,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: CashStatWidget(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primary,
                                          icon: Icon(
                                            Icons.functions_rounded,
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).info,
                                            size: 20,
                                          ),
                                          label: 'Saldo Esperado',
                                          value: 'Bs. 2.830,50',
                                        ),
                                      ),
                                    ),
                                  ].divide(const SizedBox(width: 16)),
                                ),
                              ].divide(const SizedBox(height: 16)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.buttonModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ButtonWidget(
                                      icon: Icon(
                                        Icons.add_rounded,
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).primaryText,
                                        size: 24,
                                      ),
                                      iconPresent: true,
                                      iconEndPresent: false,
                                      content: 'Registrar Ingreso',
                                      variant: 'secondary',
                                      size: 'medium',
                                      fullWidth: true,
                                      loading: false,
                                      disabled: false,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.buttonModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ButtonWidget(
                                      icon: Icon(
                                        Icons.remove_rounded,
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).primaryText,
                                        size: 24,
                                      ),
                                      iconPresent: true,
                                      iconEndPresent: false,
                                      content: 'Registrar Egreso',
                                      variant: 'secondary',
                                      size: 'medium',
                                      fullWidth: true,
                                      loading: false,
                                      disabled: false,
                                    ),
                                  ),
                                ),
                              ].divide(const SizedBox(width: 16)),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Movimientos Recientes',
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
                                    Text(
                                      'Ver todos',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .copyWith(
                                            fontFamily: "Space Grotesk",
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).primary,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontWeight,
                                            height: 1.3,
                                          ),
                                    ),
                                  ],
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).secondaryBackground,
                                      borderRadius: BorderRadius.circular(24),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).alternate,
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        wrapWithModel(
                                          model: _model.movementItemModel1,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MovementItemWidget(
                                            amount: '+ Bs. 150,00',
                                            time: '10:45 AM',
                                            tone: FlutterFlowTheme.of(
                                              context,
                                            ).success,
                                            type: 'Venta #1024',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.movementItemModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MovementItemWidget(
                                            amount: '- Bs. 85,00',
                                            time: '09:30 AM',
                                            tone: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            type: 'Egreso: Pago Luz',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.movementItemModel3,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MovementItemWidget(
                                            amount: '+ Bs. 45,50',
                                            time: '09:15 AM',
                                            tone: FlutterFlowTheme.of(
                                              context,
                                            ).success,
                                            type: 'Venta #1023',
                                          ),
                                        ),
                                        wrapWithModel(
                                          model: _model.movementItemModel4,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MovementItemWidget(
                                            amount: '+ Bs. 500,00',
                                            time: '08:00 AM',
                                            tone: FlutterFlowTheme.of(
                                              context,
                                            ).info,
                                            type: 'Ingreso: Cambio',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ].divide(const SizedBox(height: 16)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary10,
                                borderRadius: BorderRadius.circular(24),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).primary30,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.storefront_rounded,
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).onPrimary,
                                            size: 24,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Arqueo de Efectivo',
                                                  style:
                                                      FlutterFlowTheme.of(
                                                        context,
                                                      ).titleSmall.copyWith(
                                                        fontFamily: "Urbanist",
                                                        color:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        height: 1.4,
                                                      ),
                                                ),
                                                Text(
                                                  'Realiza el conteo físico antes de cerrar',
                                                  style:
                                                      FlutterFlowTheme.of(
                                                        context,
                                                      ).bodySmall.copyWith(
                                                        fontFamily: "Poppins",
                                                        color:
                                                            FlutterFlowTheme.of(
                                                              context,
                                                            ).onPrimary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                  context,
                                                                )
                                                                .bodySmall
                                                                .fontWeight,
                                                        height: 1.4,
                                                      ),
                                                ),
                                              ].divide(const SizedBox(height: 4)),
                                            ),
                                          ),
                                        ].divide(const SizedBox(width: 16)),
                                      ),
                                      wrapWithModel(
                                        model: _model.textFieldModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: TextFieldWidget(
                                          label: 'Monto en Efectivo Real',
                                          labelPresent: true,
                                          helper: '',
                                          helperPresent: false,
                                          leadingIcon: Icon(
                                            Icons.payments_rounded,
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).primaryText,
                                            size: 24,
                                          ),
                                          leadingIconPresent: true,
                                          trailingIconPresent: false,
                                          hint: 'Bs. 0,00',
                                          value: '',
                                          onSubmit: '',
                                          variant: 'outlined',
                                          error: false,
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.buttonModel3,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ButtonWidget(
                                          icon: Icon(
                                            Icons.lock_outline_rounded,
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).primaryText,
                                            size: 24,
                                          ),
                                          iconPresent: true,
                                          iconEndPresent: false,
                                          content: 'Cerrar Caja',
                                          variant: 'primary',
                                          size: 'medium',
                                          fullWidth: true,
                                          loading: false,
                                          disabled: false,
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 16)),
                                  ),
                                ),
                              ),
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
