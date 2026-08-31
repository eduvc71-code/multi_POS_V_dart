import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/database/database_helper.dart';
import 'package:multi_p_o_s/components/quick_action/quick_action_widget.dart';
import 'package:multi_p_o_s/components/stat_card/stat_card_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'panel_principal_widget.dart' show PanelPrincipalWidget;
import 'package:flutter/material.dart';

class PanelPrincipalModel extends FlutterFlowModel<PanelPrincipalWidget> {
  ///  State fields for stateful widgets in this page.

  int lowStockCount = 0;

  Future fetchLowStockCount() async {
    final productos = await DatabaseHelper.instance.readAllProductos();
    lowStockCount = productos.where((p) => p.stock <= p.stockMinimo).length;
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
