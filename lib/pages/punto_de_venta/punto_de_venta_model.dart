import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/database/database_helper.dart';
import 'package:multi_p_o_s/models/producto_model.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/components/product_search_item/product_search_item_widget.dart';
import 'package:multi_p_o_s/components/cart_item/cart_item_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'punto_de_venta_widget.dart' show PuntoDeVentaWidget;
import 'package:flutter/material.dart';

class PuntoDeVentaModel extends FlutterFlowModel<PuntoDeVentaWidget> {
  ///  State fields for stateful widgets in this page.

  List<Producto> searchResults = [];
  Map<int, int> cart = {}; // productId -> quantity
  List<Producto> cartProducts = [];
  bool isLoading = false;

  Future searchProducts(String query) async {
    isLoading = true;
    final all = await DatabaseHelper.instance.readAllProductos();
    searchResults = all.where((p) => 
      p.nombre.toLowerCase().contains(query.toLowerCase()) || 
      p.codigo.contains(query)
    ).toList();
    isLoading = false;
  }

  String addToCart(Producto producto) {
    int currentQty = cart[producto.id!] ?? 0;
    if (currentQty + 1 > producto.stock) {
      return 'Stock insuficiente para ${producto.nombre} (${producto.stock} disponibles)';
    }
    
    cart[producto.id!] = currentQty + 1;
    if (!cartProducts.any((p) => p.id == producto.id)) {
      cartProducts.add(producto);
    }
    return '';
  }

  void removeFromCart(Producto producto) {
    int currentQty = cart[producto.id!] ?? 0;
    if (currentQty > 1) {
      cart[producto.id!] = currentQty - 1;
    } else {
      cart.remove(producto.id);
      cartProducts.removeWhere((p) => p.id == producto.id);
    }
  }

  double get total {
    double sum = 0;
    cart.forEach((productId, qty) {
      final p = cartProducts.firstWhere((p) => p.id == productId);
      sum += p.precio * qty;
    });
    return sum;
  }

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
