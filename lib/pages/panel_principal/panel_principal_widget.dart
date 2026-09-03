import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/components/quick_action/quick_action_widget.dart';
import 'package:multi_p_o_s/components/stat_card/stat_card_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav_child/bottom_nav_child_widget.dart';
import 'package:multi_p_o_s/pages/inventario_de_productos/inventario_de_productos_widget.dart';
import 'dart:io';
import 'package:multi_p_o_s/pages/historial_de_ventas/historial_de_ventas_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';

import 'panel_principal_model.dart';
export 'panel_principal_model.dart';

@Preview()
Widget previewPanelPrincipal() {
  return const PanelPrincipalWidget();
}

class PanelPrincipalWidget extends StatefulWidget {
  const PanelPrincipalWidget({super.key});

  static String routeName = 'PanelPrincipal';
  static String routePath = '/panelPrincipal';

  @override
  State<PanelPrincipalWidget> createState() => _PanelPrincipalWidgetState();
}

class _PanelPrincipalWidgetState extends State<PanelPrincipalWidget> {
  late PanelPrincipalModel _model;
  String _userName = 'Administrador';
  String _userRole = 'admin';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PanelPrincipalModel());
    _loadData();
  }

  Future<void> _loadData() async {
    await _model.fetchDashboardMetrics();
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _userName = prefs.getString('user_name') ?? 'Administrador';
        _userRole = prefs.getString('user_role') ?? 'admin';
      });
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
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // BLOQUE 1: CABECERA (Header del Dashboard)
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 16),
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
                                      style: FlutterFlowTheme.of(context).titleMedium
                                          .copyWith(
                                            fontFamily: "Urbanist",
                                            color: FlutterFlowTheme.of(context).primary,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$_userName · ${_userRole.toUpperCase()}',
                                          style: FlutterFlowTheme.of(context).labelSmall
                                              .copyWith(
                                                fontFamily: "Space Grotesk",
                                                color: Colors.black,
                                                fontSize: 10,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ].divide(const SizedBox(height: 0)),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FlutterFlowIconButton(
                                      borderRadius: 12,
                                      buttonSize: 32, // Reducido de 40 a 32
                                      fillColor: FlutterFlowTheme.of(
                                        context,
                                      ).surfaceVariant,
                                      icon: const Icon(Icons.search_rounded, size: 18),
                                      onPressed: () {
                                        debugPrint('IconButton pressed ...');
                                      },
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 12,
                                      buttonSize: 32, // Reducido de 40 a 32
                                      fillColor: FlutterFlowTheme.of(
                                        context,
                                      ).surfaceVariant,
                                      icon: const Icon(Icons.notifications_rounded, size: 18),
                                      onPressed: () {
                                        debugPrint('IconButton pressed ...');
                                      },
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 12,
                                      buttonSize: 32,
                                      fillColor: Colors.red.withValues(alpha: 0.1),
                                      icon: const Icon(Icons.power_settings_new_rounded, color: Colors.red, size: 18),
                                      onPressed: () {
                                        SystemNavigator.pop();
                                        exit(0); // Cierra completamente la app
                                      },
                                    ),
                                  ].divide(const SizedBox(width: 4)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // BLOQUE 2: CUERPO (Contenido del Dashboard completamente estático sin scroll)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // 1. Tarjeta Ventas del Día
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 16,
                                      color: FlutterFlowTheme.of(context).primary25,
                                      offset: const Offset(0, 8),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                  gradient: LinearGradient(
                                    colors: [
                                      FlutterFlowTheme.of(context).primary,
                                      FlutterFlowTheme.of(context).secondary,
                                    ],
                                    stops: const [0, 1],
                                    begin: const AlignmentDirectional(1, 1),
                                    end: const AlignmentDirectional(-1, -1),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Ventas del Día',
                                            style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                                                  color: Colors.white70,
                                                ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: const Text(
                                              'HOY',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Bs. ${_model.todayTotalVentas.toStringAsFixed(2)}',
                                        style: FlutterFlowTheme.of(context).headlineSmall.copyWith(
                                              fontFamily: "Poppins",
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w900,
                                            ),
                                      ),
                                      const Divider(height: 12, thickness: 0.5, color: Colors.white24),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Transacciones', style: FlutterFlowTheme.of(context).labelSmall.copyWith(color: Colors.white60, fontSize: 10)),
                                              Text('${_model.todayNumVentas} ventas', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text('Estado de Caja', style: FlutterFlowTheme.of(context).labelSmall.copyWith(color: Colors.white60, fontSize: 10)),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 6,
                                                    height: 6,
                                                    decoration: BoxDecoration(
                                                      color: _model.isCajaAbierta ? Colors.greenAccent : Colors.orangeAccent,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    _model.isCajaAbierta ? 'Abierta' : 'Cerrada',
                                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // 2. Accesos Rápidos
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Accesos Rápidos',
                                    style: FlutterFlowTheme.of(context).titleSmall.copyWith(
                                          fontFamily: "Urbanist",
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: wrapWithModel(
                                          model: _model.quickActionModel1,
                                          updateCallback: () => safeSetState(() {}),
                                          child: QuickActionWidget(
                                            icon: Icon(Icons.add_shopping_cart_rounded, color: FlutterFlowTheme.of(context).onPrimary, size: 22),
                                            label: 'Vender',
                                            target: 'PuntoDeVenta',
                                            tone: FlutterFlowTheme.of(context).primary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: wrapWithModel(
                                          model: _model.quickActionModel2,
                                          updateCallback: () => safeSetState(() {}),
                                          child: QuickActionWidget(
                                            icon: Icon(Icons.account_balance_wallet_rounded, color: FlutterFlowTheme.of(context).onPrimary, size: 22),
                                            label: 'Caja',
                                            target: 'GestionDeCaja',
                                            tone: FlutterFlowTheme.of(context).success,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: wrapWithModel(
                                          model: _model.quickActionModel3,
                                          updateCallback: () => safeSetState(() {}),
                                          child: QuickActionWidget(
                                            icon: Icon(Icons.inventory_2_rounded, color: FlutterFlowTheme.of(context).onPrimary, size: 22),
                                            label: 'Inventario',
                                            target: 'InventarioDeProductos',
                                            tone: FlutterFlowTheme.of(context).secondary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: wrapWithModel(
                                          model: _model.quickActionModel4,
                                          updateCallback: () => safeSetState(() {}),
                                          child: QuickActionWidget(
                                            icon: Icon(Icons.group_rounded, color: FlutterFlowTheme.of(context).onPrimary, size: 22),
                                            label: 'Clientes',
                                            target: 'ClientesYCreditos',
                                            tone: FlutterFlowTheme.of(context).tertiary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // 3. Stats Row
                              Row(
                                children: [
                                  Expanded(
                                    child: wrapWithModel(
                                      model: _model.statCardModel1,
                                      updateCallback: () => safeSetState(() {}),
                                      child: const StatCardWidget(
                                        icon: Icon(Icons.credit_score_rounded, color: Color(0xFFFF9100), size: 18),
                                        label: 'Créditos Hoy',
                                        tone: Color(0xFFFF9100),
                                        value: 'Bs. 0,00',
                                        isUp: true,
                                        trend: '0%',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: wrapWithModel(
                                      model: _model.statCardModel2,
                                      updateCallback: () => safeSetState(() {}),
                                      child: const StatCardWidget(
                                        icon: Icon(Icons.payments_rounded, color: Colors.red, size: 18),
                                        label: 'Egresos',
                                        tone: Colors.red,
                                        value: 'Bs. 0,00',
                                        isUp: false,
                                        trend: '0%',
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // 4. Alerta Stock Bajo (Si aplica)
                              if (_model.lowStockCount > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0x1AFF9100),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: const Color(0x4DFF9100)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.warning_amber_rounded, color: Color(0xFFFF9100), size: 20),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Stock Bajo: ${_model.lowStockCount} productos por debajo del mínimo',
                                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFFF9100), size: 14),
                                        onPressed: () => context.goNamed(InventarioDeProductosWidget.routeName),
                                      ),
                                    ],
                                  ),
                                ),

                              // 5. Últimas Ventas (Dinámicas de SQLite)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Últimas Ventas',
                                        style: FlutterFlowTheme.of(context).titleSmall.copyWith(
                                              fontFamily: "Urbanist",
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      TextButton(
                                        onPressed: () => context.goNamed(HistorialDeVentasWidget.routeName),
                                        child: const Text('Ver Todo', style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                  if (_model.ultimasVentas.isEmpty)
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Sin ventas registradas el día de hoy',
                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                    )
                                  else
                                    Column(
                                      children: _model.ultimasVentas.map((venta) {
                                        final double tot = (venta['total'] as num?)?.toDouble() ?? 0.0;
                                        final String metodo = venta['metodo_pago'] as String? ?? 'Efectivo';
                                        final int id = venta['id'] as int? ?? 0;

                                        return Container(
                                          margin: const EdgeInsets.only(bottom: 6),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.receipt_long_rounded, color: FlutterFlowTheme.of(context).primary, size: 20),
                                                  const SizedBox(width: 8),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Venta #$id', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                                      Text(metodo, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Text('Bs. ${tot.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // BLOQUE 3: FOOTER (Bottom Navigation)
                      Align(
                        alignment: const AlignmentDirectional(0, 1),
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
                                  child: () => const BottomNavChildWidget(),
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
            },
          ),
        ),
      ),
    );
  }
}
