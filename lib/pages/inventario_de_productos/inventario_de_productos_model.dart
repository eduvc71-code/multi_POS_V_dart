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
import 'inventario_de_productos_widget.dart' show InventarioDeProductosWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InventarioDeProductosModel
    extends FlutterFlowModel<InventarioDeProductosWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for InventoryStat.
  late InventoryStatModel inventoryStatModel1;
  // Model for InventoryStat.
  late InventoryStatModel inventoryStatModel2;
  // Model for ProductItem.
  late ProductItemModel productItemModel1;
  // Model for ProductItem.
  late ProductItemModel productItemModel2;
  // Model for ProductItem.
  late ProductItemModel productItemModel3;
  // Model for ProductItem.
  late ProductItemModel productItemModel4;
  // Model for ProductItem.
  late ProductItemModel productItemModel5;
  // Model for ProductItem.
  late ProductItemModel productItemModel6;
  // Model for ProductItem.
  late ProductItemModel productItemModel7;
  // Model for BottomNav.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    inventoryStatModel1 = createModel(context, () => InventoryStatModel());
    inventoryStatModel2 = createModel(context, () => InventoryStatModel());
    productItemModel1 = createModel(context, () => ProductItemModel());
    productItemModel2 = createModel(context, () => ProductItemModel());
    productItemModel3 = createModel(context, () => ProductItemModel());
    productItemModel4 = createModel(context, () => ProductItemModel());
    productItemModel5 = createModel(context, () => ProductItemModel());
    productItemModel6 = createModel(context, () => ProductItemModel());
    productItemModel7 = createModel(context, () => ProductItemModel());
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    inventoryStatModel1.dispose();
    inventoryStatModel2.dispose();
    productItemModel1.dispose();
    productItemModel2.dispose();
    productItemModel3.dispose();
    productItemModel4.dispose();
    productItemModel5.dispose();
    productItemModel6.dispose();
    productItemModel7.dispose();
    bottomNavModel.dispose();
  }
}
