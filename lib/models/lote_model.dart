class LoteProducto {
  final int? id;
  final int productoId;
  final int empresaId;
  final String numeroLote;
  final DateTime fechaVencimiento;
  final int stockUnidades;

  LoteProducto({
    this.id,
    required this.productoId,
    required this.empresaId,
    required this.numeroLote,
    required this.fechaVencimiento,
    required this.stockUnidades,
  });

  factory LoteProducto.fromJson(Map<String, dynamic> json) {
    return LoteProducto(
      id: json['id'] != null ? (json['id'] as num).toInt() : null,
      productoId: (json['producto_id'] as num).toInt(),
      empresaId: (json['empresa_id'] as num).toInt(),
      numeroLote: json['numero_lote'] ?? '',
      fechaVencimiento: DateTime.parse(
        json['fecha_vencimiento'] ?? DateTime.now().toIso8601String(),
      ),
      stockUnidades: (json['stock_unidades'] as num? ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'producto_id': productoId,
      'empresa_id': empresaId,
      'numero_lote': numeroLote,
      'fecha_vencimiento': fechaVencimiento.toIso8601String().split('T').first,
      'stock_unidades': stockUnidades,
    };
  }

  /// Retorna si el lote ya está vencido a la fecha actual
  bool get esVencido {
    final now = DateTime.now();
    final hoySinHora = DateTime(now.year, now.month, now.day);
    final vencSinHora = DateTime(fechaVencimiento.year, fechaVencimiento.month, fechaVencimiento.day);
    return vencSinHora.isBefore(hoySinHora);
  }

  /// Retorna si el lote está próximo a vencer (<= 60 días)
  bool get esProximoAVencer {
    if (esVencido) return false;
    final now = DateTime.now();
    final diasRestantes = fechaVencimiento.difference(now).inDays;
    return diasRestantes <= 60;
  }

  /// Días restantes hasta la fecha de expiración
  int get diasParaVencer {
    final now = DateTime.now();
    return fechaVencimiento.difference(now).inDays;
  }
}
