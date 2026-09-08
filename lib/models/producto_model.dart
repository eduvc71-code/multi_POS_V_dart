class Producto {
  final int? id;
  final String codigo;
  final String nombre;
  final double precio;
  final double costo;
  final int stock;
  final int stockMinimo;
  final String? categoria;
  final String? imagen;
  final bool permiteFraccionamiento;
  final int unidadesPorCaja;
  final int unidadesPorBlister;

  Producto({
    this.id,
    required this.codigo,
    required this.nombre,
    required this.precio,
    required this.costo,
    required this.stock,
    required this.stockMinimo,
    this.categoria,
    this.imagen,
    this.permiteFraccionamiento = false,
    this.unidadesPorCaja = 1,
    this.unidadesPorBlister = 10,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigo': codigo,
      'nombre': nombre,
      'precio': precio,
      'costo': costo,
      'stock': stock,
      'stock_minimo': stockMinimo,
      'categoria': categoria,
      'imagen': imagen,
      'permite_fraccionamiento': permiteFraccionamiento,
      'unidades_por_caja': unidadesPorCaja,
      'unidades_por_blister': unidadesPorBlister,
    };
  }

  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'],
      codigo: map['codigo'],
      nombre: map['nombre'],
      precio: map['precio']?.toDouble() ?? 0.0,
      costo: map['costo']?.toDouble() ?? 0.0,
      stock: map['stock'] ?? 0,
      stockMinimo: map['stock_minimo'] ?? 12,
      categoria: map['categoria'],
      imagen: map['imagen'],
      permiteFraccionamiento: map['permite_fraccionamiento'] ?? false,
      unidadesPorCaja: map['unidades_por_caja'] ?? 1,
      unidadesPorBlister: map['unidades_por_blister'] ?? 10,
    );
  }

  Producto copyWith({
    int? id,
    String? codigo,
    String? nombre,
    double? precio,
    double? costo,
    int? stock,
    int? stockMinimo,
    String? categoria,
    String? imagen,
    bool? permiteFraccionamiento,
    int? unidadesPorCaja,
    int? unidadesPorBlister,
  }) {
    return Producto(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nombre: nombre ?? this.nombre,
      precio: precio ?? this.precio,
      costo: costo ?? this.costo,
      stock: stock ?? this.stock,
      stockMinimo: stockMinimo ?? this.stockMinimo,
      categoria: categoria ?? this.categoria,
      imagen: imagen ?? this.imagen,
      permiteFraccionamiento: permiteFraccionamiento ?? this.permiteFraccionamiento,
      unidadesPorCaja: unidadesPorCaja ?? this.unidadesPorCaja,
      unidadesPorBlister: unidadesPorBlister ?? this.unidadesPorBlister,
    );
  }
}
