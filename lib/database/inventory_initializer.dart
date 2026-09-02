
class InventoryInitializer {
  static List<Map<String, dynamic>> getItemsFor(String businessType) {
    switch (businessType) {
      case 'Tienda':
        return [
          {'nombre': 'Leche Entera 1L', 'codigo': '7771234567890'},
          {'nombre': 'Pan de Molde', 'codigo': '7771234567891'},
          {'nombre': 'Arroz Grano de Oro 1kg', 'codigo': '7771234567892'},
          {'nombre': 'Fideo Tallarín 400g', 'codigo': '7771234567893'},
          {'nombre': 'Aceite Vegetal 1L', 'codigo': '7771234567894'},
          {'nombre': 'Coca-Cola 2L', 'codigo': '7771234567895'},
          {'nombre': 'Galletas Surtidas', 'codigo': '7771234567896'},
          {'nombre': 'Azúcar Blanca 1kg', 'codigo': '7771234567897'},
          {'nombre': 'Café Instantáneo 100g', 'codigo': '7771234567898'},
          {'nombre': 'Detergente en Polvo 500g', 'codigo': '7771234567899'},
        ];
      case 'Ferretería':
        return [
          {'nombre': 'Martillo de Carpintero', 'codigo': '8881234567890'},
          {'nombre': 'Juego de Destornilladores', 'codigo': '8881234567891'},
          {'nombre': 'Alicate Universal', 'codigo': '8881234567892'},
          {'nombre': 'Cinta Métrica 5m', 'codigo': '8881234567893'},
          {'nombre': 'Clavos de 2 pulgadas (1kg)', 'codigo': '8881234567894'},
          {'nombre': 'Tornillos Autoperforantes (caja)', 'codigo': '8881234567895'},
          {'nombre': 'Cemento Portland 50kg', 'codigo': '8881234567896'},
          {'nombre': 'Pintura Látex Blanca 4L', 'codigo': '8881234567897'},
          {'nombre': 'Brocha de 3 pulgadas', 'codigo': '8881234567898'},
          {'nombre': 'Llave Inglesa 10"', 'codigo': '8881234567899'},
        ];
      case 'Autopartes':
        return [
          {'nombre': 'Filtro de Aceite Universal', 'codigo': '9991234567890'},
          {'nombre': 'Juego de Bujías (4 unidades)', 'codigo': '9991234567891'},
          {'nombre': 'Pastillas de Freno Delanteras', 'codigo': '9991234567892'},
          {'nombre': 'Amortiguador Delantero', 'codigo': '9991234567893'},
          {'nombre': 'Batería 12V 60Ah', 'codigo': '9991234567894'},
          {'nombre': 'Líquido de Frenos 500ml', 'codigo': '9991234567895'},
          {'nombre': 'Aceite Sintético 5W-30 4L', 'codigo': '9991234567896'},
          {'nombre': 'Refrigerante 1L', 'codigo': '9991234567897'},
          {'nombre': 'Correa de Distribución', 'codigo': '9991234567898'},
          {'nombre': 'Filtro de Aire', 'codigo': '9991234567899'},
        ];
      case 'Motopartes':
        return [
          {'nombre': 'Casco Integral Homologado', 'codigo': '6661234567890'},
          {'nombre': 'Cadena de Transmisión 428', 'codigo': '6661234567891'},
          {'nombre': 'Aceite 4T 20W-50 1L', 'codigo': '6661234567892'},
          {'nombre': 'Juego de Espejos Retrovisores', 'codigo': '6661234567893'},
          {'nombre': 'Llanta Delantera 2.75-18', 'codigo': '6661234567894'},
          {'nombre': 'Pastillas de Freno Traseras', 'codigo': '6661234567895'},
          {'nombre': 'Batería para Moto 12V 7Ah', 'codigo': '6661234567896'},
          {'nombre': 'Bujía para Moto', 'codigo': '6661234567897'},
          {'nombre': 'Kit de Transmisión (Piñón/Corona)', 'codigo': '6661234567898'},
          {'nombre': 'Manubrio Estándar', 'codigo': '6661234567899'},
        ];
      case 'Farmacia':
        return [
          {'nombre': 'Paracetamol 500mg (Caja)', 'codigo': '5551234567890'},
          {'nombre': 'Ibuprofeno 400mg (Caja)', 'codigo': '5551234567891'},
          {'nombre': 'Aspirina 100mg', 'codigo': '5551234567892'},
          {'nombre': 'Alcohol Etílico 70% 500ml', 'codigo': '5551234567893'},
          {'nombre': 'Algodón Hidrófilo 100g', 'codigo': '5551234567894'},
          {'nombre': 'Gasa Estéril (Paquete)', 'codigo': '5551234567895'},
          {'nombre': 'Termómetro Digital', 'codigo': '5551234567896'},
          {'nombre': 'Vitamina C 1g efervescente', 'codigo': '5551234567897'},
          {'nombre': 'Jarabe para la tos 120ml', 'codigo': '5551234567898'},
          {'nombre': 'Curitas (Caja 20 unidades)', 'codigo': '5551234567899'},
        ];
      default:
        return [];
    }
  }

  static Map<String, dynamic>? lookupProductInLibrary(String codigo, String businessType) {
    final items = getItemsFor(businessType);
    for (var item in items) {
      if (item['codigo'] == codigo) return item;
    }
    return null;
  }
}
