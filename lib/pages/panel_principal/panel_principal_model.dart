import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/services/supabase_service.dart';
import 'package:multi_p_o_s/components/quick_action/quick_action_widget.dart';
import 'package:multi_p_o_s/components/stat_card/stat_card_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'panel_principal_widget.dart' show PanelPrincipalWidget;
import 'package:flutter/material.dart';

class PanelPrincipalModel extends FlutterFlowModel<PanelPrincipalWidget> {
  ///  State fields for stateful widgets in this page.

  int lowStockCount = 0;
  double todayTotalVentas = 0.0;
  int todayNumVentas = 0;
  bool isCajaAbierta = false;
  List<Map<String, dynamic>> ultimasVentas = [];

  Future fetchDashboardMetrics() async {
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? 1;

    try {
      final metrics =
          await SupabaseService.instance.getDashboardMetrics(empresaId);
      todayTotalVentas =
          (metrics['todayTotalVentas'] as num? ?? 0.0).toDouble();
      todayNumVentas = (metrics['todayNumVentas'] as num? ?? 0).toInt();
      isCajaAbierta = metrics['isCajaAbierta'] ?? false;
      lowStockCount = (metrics['lowStockCount'] as num? ?? 0).toInt();
      ultimasVentas =
          List<Map<String, dynamic>>.from(metrics['ultimasVentas'] ?? []);
    } catch (e) {
      debugPrint('Error al cargar métricas de Supabase: $e');
    }
  }

  // Model for QuickAction.
  late QuickActionModel quickActionModel1;
  // Model for QuickAction.
  late QuickActionModel quickActionModel2;
  // Model for QuickAction.
  late QuickActionModel quickActionModel3;
  // Model for QuickAction.
  late QuickActionModel quickActionModel4;
  // Model for StatCard.
  late StatCardModel statCardModel1;
  // Model for StatCard.
  late StatCardModel statCardModel2;
  // Model for Button.
  late ButtonModel buttonModel;
  // Model for BottomNav.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    quickActionModel1 = createModel(context, () => QuickActionModel());
    quickActionModel2 = createModel(context, () => QuickActionModel());
    quickActionModel3 = createModel(context, () => QuickActionModel());
    quickActionModel4 = createModel(context, () => QuickActionModel());
    statCardModel1 = createModel(context, () => StatCardModel());
    statCardModel2 = createModel(context, () => StatCardModel());
    buttonModel = createModel(context, () => ButtonModel());
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    quickActionModel1.dispose();
    quickActionModel2.dispose();
    quickActionModel3.dispose();
    quickActionModel4.dispose();
    statCardModel1.dispose();
    statCardModel2.dispose();
    buttonModel.dispose();
    bottomNavModel.dispose();
  }
}
