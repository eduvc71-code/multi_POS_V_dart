
class InventoryInitializer {
  static List<Map<String, dynamic>> getItemsFor(String businessType) {
    List<Map<String, dynamic>> baseItems = [];
    String prefix = '100';

    if (businessType == 'Tienda') {
      prefix = '777';
      baseItems = [
        'Leche Entera 1L', 'Pan de Molde', 'Arroz Grano de Oro 1kg', 'Fideo Tallarín 400g',
        'Aceite Vegetal 1L', 'Coca-Cola 2L', 'Galletas Surtidas', 'Azúcar Blanca 1kg',
        'Café Instantáneo 100g', 'Detergente en Polvo 500g', 'Jabón de Tocador 90g',
        'Shampoo Control Caspa 400ml', 'Pasta Dental 90g', 'Papel Higiénico 4 rollos',
        'Atún en Lata 170g', 'Sardinas en Tomate 425g', 'Mantequilla 200g', 'Queso Criollo 500g',
        'Yogurt Fresa 1L', 'Cereal de Maíz 300g', 'Harina de Trigo 1kg', 'Sal Yodada 1kg',
        'Mayonesa 200g', 'Ketchup 200g', 'Mostaza 200g', 'Vinagre Blanco 500ml',
        'Té Negro 20 sobres', 'Manzanilla 20 sobres', 'Agua Mineral 2L', 'Jugo de Naranja 1L'
      ].map((n) => {'nombre': n}).toList();
    } else if (businessType == 'Ferretería') {
      prefix = '888';
      baseItems = [
        'Martillo de Carpintero', 'Juego de Destornilladores', 'Alicate Universal',
        'Cinta Métrica 5m', 'Clavos de 2" (1kg)', 'Tornillos Autoperforantes (caja)',
        'Cemento Portland 50kg', 'Pintura Látex Blanca 4L', 'Brocha de 3"',
        'Llave Inglesa 10"', 'Taladro Percutor 650W', 'Discos de Corte 4.5"',
        'Lija de Agua #180', 'Silicona Transparente', 'Cinta Aislante Negra',
        'Tubo PVC 1/2" 3m', 'Codo PVC 1/2"', 'Teflón 1/2" 10m', 'Candado 40mm',
        'Manguera de Riego 15m', 'Cerradura de Pomo', 'Nivel de Mano 18"',
        'Serrucho 18"', 'Cincel 10"', 'Gafas de Protección'
      ].map((n) => {'nombre': n}).toList();
    } else if (businessType == 'Autopartes') {
      prefix = '999';
      baseItems = [
        'Filtro de Aceite Universal', 'Juego de Bujías 4u', 'Pastillas Freno Delanteras',
        'Amortiguador Delantero', 'Batería 12V 60Ah', 'Líquido de Frenos 500ml',
        'Aceite Sintético 5W-30 4L', 'Refrigerante 1L', 'Correa Distribución',
        'Filtro de Aire', 'Filtro de Combustible', 'Líquido Parabrisas 1L',
        'Foco Halógeno H4', 'Juego de Limpiaparabrisas', 'Bomba de Agua',
        'Termostato Motor', 'Sensor de Oxígeno', 'Cable de Bujía Kit',
        'Filtro de Cabina', 'Líquido de Dirección 1L'
      ].map((n) => {'nombre': n}).toList();
    } else if (businessType == 'Motopartes') {
      prefix = '666';
      baseItems = [
        'Casco Integral Homologado', 'Cadena Transmisión 428', 'Aceite 4T 20W-50 1L',
        'Juego Espejos Retrovisores', 'Llanta Delantera 2.75-18', 'Pastillas Freno Traseras',
        'Batería Moto 12V 7Ah', 'Bujía para Moto', 'Kit Transmisión (Piñón/Corona)',
        'Manubrio Estándar', 'Filtro Aire Moto', 'Cámara de Aire 2.75-18',
        'Foco LED Principal', 'Guantes de Protección', 'Cable de Acelerador',
        'Cable de Embrague', 'Amortiguador Trasero Moto', 'Carburador PZ27'
      ].map((n) => {'nombre': n}).toList();
    } else if (businessType == 'Farmacia') {
      prefix = '555';
      baseItems = [
        'Paracetamol 500mg', 'Ibuprofeno 400mg', 'Aspirina 100mg', 'Alcohol 70% 500ml',
        'Algodón Hidrófilo 100g', 'Gasa Estéril', 'Termómetro Digital', 'Vitamina C 1g',
        'Jarabe para la tos 120ml', 'Curitas Caja 20u', 'Omeprazol 20mg',
        'Amoxicilina 500mg', 'Loratadina 10mg', 'Antiácido Suspensión 200ml',
        'Suero Oral Rehidratante', 'Crema Antiinflamatoria', 'Alcohol en Gel 250ml',
        'Mascarillas Quirúrgicas 10u', 'Tirita Adhesiva Rollo', 'Jeringa 5ml c/aguja'
      ].map((n) => {'nombre': n}).toList();
    } else {
      prefix = '100';
      baseItems = [
        'Producto General 1', 'Producto General 2', 'Producto General 3'
      ].map((n) => {'nombre': n}).toList();
    }

    List<Map<String, dynamic>> items = [];
    for (int i = 0; i < 150; i++) {
      String baseName = baseItems[i % baseItems.length]['nombre'];
      int variant = (i ~/ baseItems.length) + 1;
      String finalName = variant == 1 ? baseName : '$baseName (Var. $variant)';
      String code = '$prefix${(1000000000 + i).toString()}';
      items.add({
        'nombre': finalName,
        'codigo': code,
      });
    }

    return items;
  }

  static Map<String, dynamic>? lookupProductInLibrary(String codigo, String businessType) {
    final items = getItemsFor(businessType);
    for (var item in items) {
      if (item['codigo'] == codigo) return item;
    }
    return null;
  }
}
