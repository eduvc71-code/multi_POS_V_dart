import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav_child/bottom_nav_child_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/quick_action/quick_action_widget.dart';
import 'package:multi_p_o_s/components/stat_card/stat_card_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'package:multi_p_o_s/index.dart';
import 'package:flutter/material.dart';

import 'panel_principal_model.dart';
export 'panel_principal_model.dart';

class PanelPrincipalWidget extends StatefulWidget {
  const PanelPrincipalWidget({super.key});

  static String routeName = 'PanelPrincipal';
  static String routePath = '/panelPrincipal';

  @override
  State<PanelPrincipalWidget> createState() => _PanelPrincipalWidgetState();
}

class _PanelPrincipalWidgetState extends State<PanelPrincipalWidget> {
  late PanelPrincipalModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PanelPrincipalModel());
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
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 16),
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
                            'MultiPOS',
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .copyWith(
                              fontFamily: "Urbanist",
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.store_rounded,
                                color:
                                FlutterFlowTheme.of(context).secondaryText,
                                size: 14,
                              ),
                              Text(
                                'Sucursal Central',
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .copyWith(
                                  fontFamily: "Space Grotesk",
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  height: 1.2,
                                ),
                              ),
                            ].divide(SizedBox(width: 4)),
                          ),
                        ].divide(SizedBox(height: 4)),
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
                            FlutterFlowTheme.of(context).surfaceVariant,
                            icon: Icon(
                              Icons.search_rounded,
                              size: 24,
                            ),
                            onPressed: () {
                              debugPrint('IconButton pressed ...');
                            },
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 12,
                            buttonSize: 40,
                            fillColor:
                            FlutterFlowTheme.of(context).surfaceVariant,
                            icon: Icon(
                              Icons.notifications_rounded,
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
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 24,
                                    color:
                                    FlutterFlowTheme.of(context).primary25,
                                    offset: Offset(
                                      0,
                                      12,
                                    ),
                                    spreadRadius: 0,
                                  )
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    FlutterFlowTheme.of(context).primary,
                                    FlutterFlowTheme.of(context).secondary
                                  ],
                                  stops: [0, 1],
                                  begin: AlignmentDirectional(1, 1),
                                  end: AlignmentDirectional(-1, -1),
                                ),
                                borderRadius: BorderRadius.circular(32),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(32),
                                child: Container(
                                  child: Column(
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
                                            'Ventas del Día',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .copyWith(
                                              fontFamily: "Space Grotesk",
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .onBackground80,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelLarge
                                                  .fontWeight,
                                              height: 1.3,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .onPrimary20,
                                              borderRadius:
                                              BorderRadius.circular(9999),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 4, 8, 4),
                                              child: Container(
                                                child: Text(
                                                  'HOY',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .labelSmall
                                                      .copyWith(
                                                    fontFamily: "Space Grotesk",
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .onSurface,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    height: 1.2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Bs. 4.850,00',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .copyWith(
                                          fontFamily: "Poppins",
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .onBackground,
                                          fontSize: 36,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w900,
                                          height: 1.5,
                                        ),
                                      ),
                                      Divider(
                                        height: 16,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                        color: FlutterFlowTheme.of(context)
                                            .onPrimary20,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Transacciones',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .copyWith(
                                                  fontFamily: "Space Grotesk",
                                                  color: FlutterFlowTheme
                                                      .of(context)
                                                      .onBackground70,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .labelSmall
                                                      .fontWeight,
                                                  height: 1.2,
                                                ),
                                              ),
                                              Text(
                                                '24 ventas',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .copyWith(
                                                  fontFamily: "Poppins",
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .onBackground,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 4)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Estado de Caja',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .copyWith(
                                                  fontFamily: "Space Grotesk",
                                                  color: FlutterFlowTheme
                                                      .of(context)
                                                      .onBackground70,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .labelSmall
                                                      .fontWeight,
                                                  height: 1.2,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration: BoxDecoration(
                                                      color:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .tertiary,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          9999),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Abierta',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .copyWith(
                                                      fontFamily: "Poppins",
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .onBackground,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 4)),
                                              ),
                                            ].divide(SizedBox(height: 4)),
                                          ),
                                        ],
                                      ),
                                    ].divide(SizedBox(height: 16)),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Accesos Rápidos',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .copyWith(
                                    fontFamily: "Urbanist",
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w800,
                                    height: 1.4,
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
                                        model: _model.quickActionModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: QuickActionWidget(
                                          icon: Icon(
                                            Icons.add_shopping_cart_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .onPrimary,
                                            size: 28,
                                          ),
                                          label: 'Vender',
                                          target: 'PuntoDeVenta',
                                          tone: FlutterFlowTheme.of(context)
                                              .primary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: wrapWithModel(
                                        model: _model.quickActionModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: QuickActionWidget(
                                          icon: Icon(
                                            Icons
                                                .account_balance_wallet_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .onPrimary,
                                            size: 28,
                                          ),
                                          label: 'Caja',
                                          target: 'GestiNDeCaja',
                                          tone: FlutterFlowTheme.of(context)
                                              .success,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: wrapWithModel(
                                        model: _model.quickActionModel3,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: QuickActionWidget(
                                          icon: Icon(
                                            Icons.inventory_2_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .onPrimary,
                                            size: 28,
                                          ),
                                          label: 'Inventario',
                                          target: 'InventarioDeProductos',
                                          tone: FlutterFlowTheme.of(context)
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: wrapWithModel(
                                        model: _model.quickActionModel4,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: QuickActionWidget(
                                          icon: Icon(
                                            Icons.group_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .onPrimary,
                                            size: 28,
                                          ),
                                          label: 'Clientes',
                                          target: 'ClientesYCrDitos',
                                          tone: FlutterFlowTheme.of(context)
                                              .tertiary,
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
                                    model: _model.statCardModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: StatCardWidget(
                                      icon: Icon(
                                        Icons.credit_score_rounded,
                                        color: Color(0xFFFF9100),
                                        size: 22,
                                      ),
                                      label: 'Créditos Hoy',
                                      tone: Color(0xFFFF9100),
                                      value: 'Bs. 1.200',
                                      isUp: true,
                                      trend: '+12%',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.statCardModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: StatCardWidget(
                                      icon: Icon(
                                        Icons.payments_rounded,
                                        color: Color(0xFFFF9100),
                                        size: 22,
                                      ),
                                      label: 'Egresos',
                                      tone: Colors.red,
                                      value: 'Bs. 450',
                                      isUp: false,
                                      trend: '-5%',
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 16)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0x1AFF9100),
                                borderRadius: BorderRadius.circular(24),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Color(0x4DFF9100),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(24),
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFF9100),
                                          borderRadius:
                                          BorderRadius.circular(16),
                                          shape: BoxShape.rectangle,
                                        ),
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Icon(
                                          Icons.warning_amber_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .onSurface,
                                          size: 24,
                                        ),
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
                                              'Stock Bajo',
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .labelLarge
                                                  .copyWith(
                                                fontFamily: "Space Grotesk",
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .onSurface,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w800,
                                                height: 1.3,
                                              ),
                                            ),
                                            Text(
                                              '3 productos están por debajo del mínimo',
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodySmall
                                                  .copyWith(
                                                fontFamily: "Poppins",
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight: FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                                height: 1.4,
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 4)),
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderRadius: 8,
                                        buttonSize: 40,
                                        fillColor: Colors.transparent,
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(0xFFFF9100),
                                          size: 16,
                                        ),
                                        onPressed: () async {
                                          GoRouter.of(context).goNamed(
                                              InventarioDeProductosWidget
                                                  .routeName);
                                        },
                                      ),
                                    ].divide(SizedBox(width: 16)),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Últimas Ventas',
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .copyWith(
                                        fontFamily: "Urbanist",
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w800,
                                        height: 1.4,
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        GoRouter.of(context).goNamed(
                                            HistorialDeVentasWidget.routeName);
                                      },
                                      child: wrapWithModel(
                                        model: _model.buttonModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ButtonWidget(
                                          iconPresent: false,
                                          iconEndPresent: false,
                                          content: 'Ver Todo',
                                          variant: 'ghost',
                                          size: 'small',
                                          fullWidth: false,
                                          loading: false,
                                          disabled: false,
                                        ),
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
                                        Padding(
                                          padding: EdgeInsets.all(24),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .surfaceVariant,
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                alignment:
                                                AlignmentDirectional(0, 0),
                                                child: Icon(
                                                  Icons.receipt_long_rounded,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primary,
                                                  size: 24,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Venta #F-2041',
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .copyWith(
                                                        fontFamily: "Poppins",
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        height: 1.5,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Hace 5 min • Efectivo',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelSmall
                                                          .copyWith(
                                                        fontFamily: "Space Grotesk",
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        letterSpacing:
                                                        0.0,
                                                        fontWeight: FlutterFlowTheme.of(
                                                            context)
                                                            .labelSmall
                                                            .fontWeight,
                                                        height: 1.2,
                                                      ),
                                                    ),
                                                  ].divide(SizedBox(height: 4)),
                                                ),
                                              ),
                                              Text(
                                                'Bs. 150,00',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyLarge
                                                    .copyWith(
                                                  fontFamily: "Poppins",
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .onSurface,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.w800,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 16)),
                                          ),
                                        ),
                                        Divider(
                                          height: 16,
                                          thickness: 1,
                                          indent: 24,
                                          endIndent: 24,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(24),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .surfaceVariant,
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                alignment:
                                                AlignmentDirectional(0, 0),
                                                child: Icon(
                                                  Icons.receipt_long_rounded,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primary,
                                                  size: 24,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Venta #F-2040',
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .copyWith(
                                                        fontFamily: "Poppins",
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        height: 1.5,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Hace 12 min • Tarjeta',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelSmall
                                                          .copyWith(
                                                        fontFamily: "Space Grotesk",
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        letterSpacing:
                                                        0.0,
                                                        fontWeight: FlutterFlowTheme.of(
                                                            context)
                                                            .labelSmall
                                                            .fontWeight,
                                                        height: 1.2,
                                                      ),
                                                    ),
                                                  ].divide(SizedBox(height: 4)),
                                                ),
                                              ),
                                              Text(
                                                'Bs. 842,50',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyLarge
                                                    .copyWith(
                                                  fontFamily: "Poppins",
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .onSurface,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.w800,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 16)),
                                          ),
                                        ),
                                      ],
                                    ),
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
            Align(
              alignment: AlignmentDirectional(0, 1),
              child: Container(
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
                    wrapWithModel(
                      model: _model.bottomNavModel,
                      updateCallback: () => safeSetState(() {}),
                      child: BottomNavWidget(
                        child: () => BottomNavChildWidget(),
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
