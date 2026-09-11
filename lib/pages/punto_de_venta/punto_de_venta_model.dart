import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/services/supabase_service.dart';
import 'package:multi_p_o_s/models/producto_model.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'punto_de_venta_widget.dart' show PuntoDeVentaWidget;
import 'package:flutter/material.dart';

class PosCartItem {
  // ✅ CONSTANTES PARA TIPOS DE UNIDAD (FARMACIA)
  static const String TIPO_CAJA = 'Caja';
  static const String TIPO_BLISTER = 'Blíster';
  static const String TIPO_PASTILLA = 'Pastilla';
  static const String TIPO_UNIDAD = 'Unidad';

  final int? productoId;
  String nombre;
  String codigo;
  double precioUnitario;
  int cantidad;
  int stockDisponible;
  String unidadVenta;

  // ✅ CORREGIDO: Agregado loteId y fechaVencimiento como String? para coincidir con el Widget
  final int? loteId;
  final String? numeroLote;
  final String? fechaVencimiento;

  PosCartItem({
    this.productoId,
    required this.nombre,
    required this.codigo,
    required this.precioUnitario,
    required this.cantidad,
    this.stockDisponible = 999999,
    this.unidadVenta = TIPO_CAJA,
    this.loteId,
    this.numeroLote,
    this.fechaVencimiento,
  });

  double get subtotal => precioUnitario * cantidad;

  PosCartItem copyWith({
    int? productoId,
    String? nombre,
    String? codigo,
    double? precioUnitario,
    int? cantidad,
    int? stockDisponible,
    String? unidadVenta,
    int? loteId,
    String? numeroLote,
    String? fechaVencimiento,
  }) {
    return PosCartItem(
      productoId: productoId ?? this.productoId,
      nombre: nombre ?? this.nombre,
      codigo: codigo ?? this.codigo,
      precioUnitario: precioUnitario ?? this.precioUnitario,
      cantidad: cantidad ?? this.cantidad,
      stockDisponible: stockDisponible ?? this.stockDisponible,
      unidadVenta: unidadVenta ?? this.unidadVenta,
      loteId: loteId ?? this.loteId,
      numeroLote: numeroLote ?? this.numeroLote,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
    );
  }
}

class PuntoDeVentaModel extends FlutterFlowModel<PuntoDeVentaWidget> {
  /// State fields for stateful widgets in this page.

  List<Producto> searchResults = [];
  List<PosCartItem> cartItems = [];
  bool isLoading = false;

  Future<void> searchProducts(String query) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? 1;

    try {
      final all = await SupabaseService.instance.readAllProductos(empresaId);
      if (query.trim().isEmpty) {
        searchResults = all;
      } else {
        searchResults = all
            .where(
              (p) =>
          p.nombre.toLowerCase().contains(query.toLowerCase()) ||
              p.codigo.contains(query),
        )
            .toList();
      }
    } catch (e) {
      debugPrint('Error al buscar productos en Supabase: $e');
    }
    isLoading = false;
  }

  // ✅ ACTUALIZADO: Agregado parámetro 'cantidad' con valor por defecto 1 para compatibilidad
  String addProductoToCart(
      Producto producto, {
        int cantidad = 1,
        int? loteId,
        String? numeroLote,
        String? fechaVencimiento,
      }) {
    final existingIndex = cartItems.indexWhere(
          (item) => item.productoId == producto.id,
    );
    if (existingIndex >= 0) {
      final currentItem = cartItems[existingIndex];
      if (currentItem.cantidad + cantidad > producto.stock) {
        return 'Stock insuficiente para ${producto.nombre} (Solo ${producto.stock} disponibles)';
      }
      currentItem.cantidad += cantidad;
    } else {
      if (producto.stock < cantidad) {
        return 'Sin stock suficiente para ${producto.nombre} (Disponible: ${producto.stock})';
      }
      cartItems.add(
        PosCartItem(
          productoId: producto.id,
          nombre: producto.nombre,
          codigo: producto.codigo,
          precioUnitario: producto.precio,
          cantidad: cantidad, // ✅ Ahora usa la cantidad solicitada
          stockDisponible: producto.stock,
          loteId: loteId,
          numeroLote: numeroLote,
          fechaVencimiento: fechaVencimiento,
        ),
      );
    }
    return '';
  }

  void addManualItemToCart(String nombre, double precio, int cantidad) {
    cartItems.add(
      PosCartItem(
        productoId: null,
        nombre: nombre.trim().isEmpty ? 'Ítem Manual' : nombre.trim(),
        codigo: 'MANUAL',
        precioUnitario: precio,
        cantidad: cantidad <= 0 ? 1 : cantidad,
        stockDisponible: 999999,
      ),
    );
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

  // ========================================================================
  // ✅ NUEVO: LÓGICA DE PROCESAMIENTO DE COMANDOS DE VOZ
  // ========================================================================

  String processVoiceCommand(String spokenText, List<Producto> catalog) {
    String text = spokenText.toLowerCase().trim();
    if (text.isEmpty) return "No se escuchó nada.";

    // 1. Comandos de gestión del carrito
    if (text.contains('eliminar último') || text.contains('borrar último') || text.contains('quitar último')) {
      if (cartItems.isNotEmpty) {
        removeCartItem(cartItems.length - 1);
        return "✓ Último producto eliminado.";
      }
      return "El carrito ya está vacío.";
    }

    if (text.contains('vaciar carrito') || text.contains('limpiar carrito') || text.contains('cancelar venta')) {
      clearCart();
      return "✓ Carrito vaciado.";
    }

    // 2. Comando de Total Manual (Ej: "total 50", "total cincuenta bolivianos")
    RegExp totalRegex = RegExp(r'(?:total|cobrar)\s+(?:de\s+)?(\d+|uno|dos|tres|cuatro|cinco|seis|siete|ocho|nueve|diez|veinte|treinta|cuarenta|cincuenta|cien|ciento)\s*(?:bolivianos|bs)?', caseSensitive: false);
    Match? totalMatch = totalRegex.firstMatch(text);
    if (totalMatch != null) {
      String amountStr = totalMatch.group(1)!.toLowerCase();
      double amount = _parseSpanishNumber(amountStr).toDouble();
      if (amount > 0) {
        addManualItemToCart('Venta Varios / Total', amount, 1);
        return "✓ Agregado monto manual de Bs. ${amount.toStringAsFixed(2)}";
      }
    }

    // 3. Comando de Agregar Producto (Ej: "agregar dos coca colas", "dame un pan", "coca cola")
    int qty = 1;
    String productName = text;

    RegExp addRegex = RegExp(r'^(?:agregar|ponme|dame|busca|quiero|añadir)\s+(?:un|una|dos|tres|cuatro|cinco|seis|siete|ocho|nueve|diez|veinte|treinta|cuarenta|cincuenta|cien)?\s*(.+)$', caseSensitive: false);
    Match? addMatch = addRegex.firstMatch(text);

    if (addMatch != null) {
      String remainder = addMatch.group(1)!.trim();
      List<String> words = remainder.split(' ');
      if (words.isNotEmpty) {
        int parsedQty = _parseSpanishNumber(words.first);
        if (parsedQty > 1) {
          qty = parsedQty;
          // Eliminar la palabra del número del nombre del producto
          productName = remainder.replaceFirst(RegExp(r'^\w+\s+'), '').trim();
        } else {
          productName = remainder;
        }
      }
    } else {
      // Si no empieza con verbo, asumimos que es solo el nombre (Ej: el usuario solo dice "coca cola")
      productName = text;
    }

    // Buscar en el catálogo (priorizando coincidencias en nombre o código exacto)
    List<Producto> matches = catalog.where((p) =>
    p.nombre.toLowerCase().contains(productName) ||
        p.codigo.toLowerCase() == productName
    ).toList();

    if (matches.isEmpty) {
      return "✗ No encontré '$productName' en el inventario.";
    }

    // Tomar la mejor coincidencia (la primera que aparezca)
    Producto targetProduct = matches.first;

    // Validar stock antes de agregar
    if (targetProduct.stock < qty) {
      return "✗ Stock insuficiente para ${targetProduct.nombre}. Solo hay ${targetProduct.stock}.";
    }

    // Agregar al carrito
    String error = addProductoToCart(targetProduct, cantidad: qty);
    if (error.isNotEmpty) {
      return "✗ $error";
    }

    return "✓ Agregado: $qty x ${targetProduct.nombre}";
  }

  // ✅ Helper para convertir palabras en números
  int _parseSpanishNumber(String word) {
    switch (word) {
      case 'un': case 'una': case 'uno': return 1;
      case 'dos': return 2;
      case 'tres': return 3;
      case 'cuatro': return 4;
      case 'cinco': return 5;
      case 'seis': return 6;
      case 'siete': return 7;
      case 'ocho': return 8;
      case 'nueve': return 9;
      case 'diez': return 10;
      case 'veinte': return 20;
      case 'treinta': return 30;
      case 'cuarenta': return 40;
      case 'cincuenta': return 50;
      case 'cien': case 'ciento': return 100;
      default:
        int? parsed = int.tryParse(word);
        return parsed ?? 1;
    }
  }
  // ========================================================================

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