import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/database/database_helper.dart';
import 'package:multi_p_o_s/models/producto_model.dart';
import 'package:multi_p_o_s/components/inventory_stat/inventory_stat_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'inventario_de_productos_widget.dart' show InventarioDeProductosWidget;
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class InventarioDeProductosModel
    extends FlutterFlowModel<InventarioDeProductosWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for InventoryStat.
  late InventoryStatModel inventoryStatModel1;
  // Model for InventoryStat.
  late InventoryStatModel inventoryStatModel2;
  // Model for BottomNav.
  late BottomNavModel bottomNavModel;

  List<Producto> productos = [];
  bool isLoading = true;

  PlutoGridStateManager? stateManager;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    inventoryStatModel1 = createModel(context, () => InventoryStatModel());
    inventoryStatModel2 = createModel(context, () => InventoryStatModel());
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  Future fetchProductos() async {
    isLoading = true;
    productos = await DatabaseHelper.instance.readAllProductos();
    isLoading = false;
  }

  double get totalCosto => productos.fold(0, (sum, p) => sum + (p.costo * p.stock));
  double get totalVenta => productos.fold(0, (sum, p) => sum + (p.precio * p.stock));

  @override
  void dispose() {
    textFieldModel.dispose();
    inventoryStatModel1.dispose();
    inventoryStatModel2.dispose();
    bottomNavModel.dispose();
  }
}
