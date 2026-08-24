import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/cash_stat/cash_stat_widget.dart';
import 'package:multi_p_o_s/components/movement_item/movement_item_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'gesti_n_de_caja_model.dart';
export 'gesti_n_de_caja_model.dart';

class GestiNDeCajaWidget extends StatefulWidget {
  const GestiNDeCajaWidget({super.key});

  static String routeName = 'GestiNDeCaja';
  static String routePath = '/gestiNDeCaja';

  @override
  State<GestiNDeCajaWidget> createState() => _GestiNDeCajaWidgetState();
}

class _GestiNDeCajaWidgetState extends State<GestiNDeCajaWidget> {
  late GestiNDeCajaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GestiNDeCajaModel());
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
                    padding: EdgeInsets.all(24),
                    child: Container(
                      child: Row(
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
                                'Gestión de Caja',
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
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color:
                                      FlutterFlowTheme.of(context).success,
                                      borderRadius: BorderRadius.circular(9999),
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                  Text(
                                    'Caja abierta · Turno Mañana',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .copyWith(
                                      fontFamily: "Space Grotesk",
                                      color: FlutterFlowTheme.of(context)
                                          .onSurface,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      height: 1.3,
                                    ),
                                  ),
                                ].divide(SizedBox(width: 4)),
                              ),
                            ].divide(SizedBox(height: 4)),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 40,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.history_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
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
                                          color:
                                          FlutterFlowTheme.of(context).info,
                                          icon: Icon(
                                            Icons
                                                .account_balance_wallet_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
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
                                          color: FlutterFlowTheme.of(context)
                                              .success,
                                          icon: Icon(
                                            Icons.shopping_cart_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            size: 20,
                                          ),
                                          label: 'Ventas Hoy',
                                          value: 'Bs. 2.450,50',
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 16)),
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
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          icon: Icon(
                                            Icons.payments_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
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
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          icon: Icon(
                                            Icons.functions_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            size: 20,
                                          ),
                                          label: 'Saldo Esperado',
                                          value: 'Bs. 2.830,50',
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 16)),
                                ),
                              ].divide(SizedBox(height: 16)),
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
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
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
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
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
                              ].divide(SizedBox(width: 16)),
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
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
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
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        letterSpacing: 0.0,
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontWeight,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Container(
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
                                            tone: FlutterFlowTheme.of(context)
                                                .success,
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
                                            tone: FlutterFlowTheme.of(context)
                                                .error,
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
                                            tone: FlutterFlowTheme.of(context)
                                                .success,
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
                                            tone: FlutterFlowTheme.of(context)
                                                .info,
                                            type: 'Ingreso: Cambio',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 16)),
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
                                padding: EdgeInsets.all(24),
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
                                            color: FlutterFlowTheme.of(context)
                                                .onPrimary,
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
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .titleSmall
                                                      .copyWith(
                                                    fontFamily: "Urbanist",
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    height: 1.4,
                                                  ),
                                                ),
                                                Text(
                                                  'Realiza el conteo físico antes de cerrar',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodySmall
                                                      .copyWith(
                                                    fontFamily: "Poppins",
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .onPrimary,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodySmall
                                                        .fontWeight,
                                                    height: 1.4,
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 4)),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 16)),
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
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24,
                                          ),
                                          leadingIconPresent: true,
                                          trailingIconPresent: false,
                                          hint: 'Bs. 0,00',
                                          value: '',
                                          onChange: '',
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
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
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
                                    ].divide(SizedBox(height: 16)),
                                  ),
                                ),
                              ),
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
