import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/database/database_helper.dart';
import 'package:multi_p_o_s/models/producto_model.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'punto_de_venta_widget.dart' show PuntoDeVentaWidget;
import 'package:flutter/material.dart';

class PosCartItem {
  final int? productoId;
  String nombre;
  String codigo;
  double precioUnitario;
  int cantidad;
  int stockDisponible;

  PosCartItem({
    this.productoId,
    required this.nombre,
    required this.codigo,
    required this.precioUnitario,
    required this.cantidad,
    this.stockDisponible = 999999,
  });

  double get subtotal => precioUnitario * cantidad;
}

class PuntoDeVentaModel extends FlutterFlowModel<PuntoDeVentaWidget> {
  /// State fields for stateful widgets in this page.

  List<Producto> searchResults = [];
  List<PosCartItem> cartItems = [];
  bool isLoading = false;

  Future searchProducts(String query) async {
    isLoading = true;
    final all = await DatabaseHelper.instance.readAllProductos();
    if (query.trim().isEmpty) {
      searchResults = all;
    } else {
      searchResults = all.where((p) => 
        p.nombre.toLowerCase().contains(query.toLowerCase()) || 
        p.codigo.contains(query)
      ).toList();
    }
    isLoading = false;
  }

  String addProductoToCart(Producto producto) {
    final existingIndex = cartItems.indexWhere((item) => item.productoId == producto.id);
    if (existingIndex >= 0) {
      final currentItem = cartItems[existingIndex];
      if (currentItem.cantidad + 1 > producto.stock) {
        return 'Stock insuficiente para ${producto.nombre} (${producto.stock} disponibles)';
      }
      currentItem.cantidad += 1;
    } else {
      if (producto.stock < 1) {
        return 'Sin stock disponible para ${producto.nombre}';
      }
      cartItems.add(PosCartItem(
        productoId: producto.id,
        nombre: producto.nombre,
        codigo: producto.codigo,
        precioUnitario: producto.precio,
        cantidad: 1,
        stockDisponible: producto.stock,
      ));
    }
    return '';
  }

  void addManualItemToCart(String nombre, double precio, int cantidad) {
    cartItems.add(PosCartItem(
      productoId: null,
      nombre: nombre.trim().isEmpty ? 'Ítem Manual' : nombre.trim(),
      codigo: 'MANUAL',
      precioUnitario: precio,
      cantidad: cantidad <= 0 ? 1 : cantidad,
      stockDisponible: 999999,
    ));
  }

  void updateCartItemQuantity(int index, int newQty) {
    if (index >= 0 && index < cartItems.length) {
      if (newQty <= 0) {
        cartItems.removeAt(index);
      } else {
        final item = cartItems[index];
        if (item.productoId != null && newQty > item.stockDisponible) {
          item.cantidad = item.stockDisponible;
        } else {
          item.cantidad = newQty;
        }
      }
    }
  }

  void updateCartItemPrice(int index, double newPrice) {
    if (index >= 0 && index < cartItems.length) {
      if (newPrice >= 0) {
        cartItems[index].precioUnitario = newPrice;
      }
    }
  }

  void removeCartItem(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  double get total {
    double sum = 0;
    for (var item in cartItems) {
      sum += item.subtotal;
    }
    return sum;
  }

  int get totalItemsCount {
    int sum = 0;
    for (var item in cartItems) {
      sum += item.cantidad;
    }
    return sum;
  }

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    buttonModel.dispose();
  }
}
