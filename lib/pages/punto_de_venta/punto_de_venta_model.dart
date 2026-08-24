import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/cart_item/cart_item_widget.dart';
import 'package:multi_p_o_s/components/product_search_item/product_search_item_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:multi_p_o_s/index.dart';
import 'punto_de_venta_widget.dart' show PuntoDeVentaWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PuntoDeVentaModel extends FlutterFlowModel<PuntoDeVentaWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for ProductSearchItem.
  late ProductSearchItemModel productSearchItemModel1;
  // Model for ProductSearchItem.
  late ProductSearchItemModel productSearchItemModel2;
  // Model for ProductSearchItem.
  late ProductSearchItemModel productSearchItemModel3;
  // Model for ProductSearchItem.
  late ProductSearchItemModel productSearchItemModel4;
  // Model for ProductSearchItem.
  late ProductSearchItemModel productSearchItemModel5;
  // Model for CartItem.
  late CartItemModel cartItemModel1;
  // Model for CartItem.
  late CartItemModel cartItemModel2;
  // Model for CartItem.
  late CartItemModel cartItemModel3;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    productSearchItemModel1 =
        createModel(context, () => ProductSearchItemModel());
    productSearchItemModel2 =
        createModel(context, () => ProductSearchItemModel());
    productSearchItemModel3 =
        createModel(context, () => ProductSearchItemModel());
    productSearchItemModel4 =
        createModel(context, () => ProductSearchItemModel());
    productSearchItemModel5 =
        createModel(context, () => ProductSearchItemModel());
    cartItemModel1 = createModel(context, () => CartItemModel());
    cartItemModel2 = createModel(context, () => CartItemModel());
    cartItemModel3 = createModel(context, () => CartItemModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    productSearchItemModel1.dispose();
    productSearchItemModel2.dispose();
    productSearchItemModel3.dispose();
    productSearchItemModel4.dispose();
    productSearchItemModel5.dispose();
    cartItemModel1.dispose();
    cartItemModel2.dispose();
    cartItemModel3.dispose();
    buttonModel.dispose();
  }
}
