import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/producto_model.dart';
import '../models/lote_model.dart';
import 'open_food_facts_service.dart';
import '../database/inventory_initializer.dart';

class SupabaseService {
  static final SupabaseService instance = SupabaseService._internal();

  SupabaseService._internal();

  /// URL de tu proyecto en Supabase (Reemplazar si tienes credenciales específicas)
  static const String supabaseUrl = 'https://xoumrgubfadltkxnaivn.supabase.co';

  /// Anon Key Pública de Supabase (Reemplazar con tu Anon Key)
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhvdW1yZ3ViZmFkbHRreG5haXZuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODg0OTQzMzgsImV4cCI6MjEwNDA3MDMzOH0.MbvjiOABx6opwcwkpk_6fml6MbKsZRQ2RGtfU4rYT3Q';

  static SupabaseClient get client => Supabase.instance.client;

  /// Inicializa la conexión a Supabase
  static Future<void> initialize({String? url, String? anonKey}) async {
    final activeUrl = url ?? supabaseUrl;
    final activeAnonKey = anonKey ?? supabaseAnonKey;

    try {
      await Supabase.initialize(
        url: activeUrl,
        publishableKey: activeAnonKey,
      );
      debugPrint('Supabase inicializado correctamente.');
    } catch (e) {
      debugPrint('Error inicializando Supabase: $e');
    }
  }

  // ===========================================================================
  // EMPRESAS Y USUARIOS
  // ===========================================================================

  /// Registra una empresa completa en Supabase y retorna el ID único asignado.
  Future<int> registerFullBusiness({
    required String businessName,
    required String businessType,
    required String nit,
    required String phone,
    required String ownerName,
    required String username,
    required String password,
    bool populateStandardInventory = false,
  }) async {
    // 1. Insertar la empresa en Supabase
    final empresaResponse = await client
        .from('empresas')
        .insert({
      'nombre': businessName,
      'tipo': businessType,
      'nit': nit.isEmpty ? null : nit,
      'telefono': phone.isEmpty ? null : phone,
    })
        .select('id')
        .single();

    final int empresaId = (empresaResponse['id'] as num).toInt();

    // 2. Insertar el usuario Propietario/Admin
    await client.from('usuarios').insert({
      'username': username,
      'password': password,
      'nombre': ownerName,
      'rol': 'admin',
      'empresa_id': empresaId,
      'activo': true,
    });

    // 3. Cargar 20 productos iniciales para empresas reales con precio 10, costo 7, stock 20, stock_minimo 12
    if (populateStandardInventory) {
      List<Map<String, dynamic>> items = [];
      try {
        items = await OpenFoodFactsService.fetchProductsBySector(businessType);
      } catch (e) {
        debugPrint('Error al obtener catálogo por rubro ($businessType): $e');
      }

      if (items.isEmpty) {
        items = InventoryInitializer.getItemsFor(businessType);
      }

      items.shuffle();
      final initial20 = items.take(20).toList();

      if (initial20.isNotEmpty) {
        final List<Map<String, dynamic>> productosToInsert = [];
        for (var item in initial20) {
          productosToInsert.add({
            'codigo': item['codigo'] ?? '',
            'nombre': item['nombre'] ?? '',
            'precio': 10.0,
            'costo': 7.0,
            'stock': 20,
            'stock_minimo': 12,
            'categoria': item['categoria'] ?? businessType,
            'empresa_id': empresaId,
          });
        }
        await client.from('productos').insert(productosToInsert);
      }
    }

    return empresaId;
  }

  /// Inicia sesión verificando credenciales en Supabase
  Future<Map<String, dynamic>?> loginUsuario(
      String username,
      String password,
      ) async {
    final response = await client
        .from('usuarios')
        .select()
        .eq('username', username)
        .eq('password', password)
        .eq('activo', true)
        .maybeSingle();

    return response != null ? Map<String, dynamic>.from(response) : null;
  }

  /// Obtiene los datos de una empresa en Supabase por ID
  Future<Map<String, dynamic>?> getEmpresa(int empresaId) async {
    final response = await client
        .from('empresas')
        .select()
        .eq('id', empresaId)
        .maybeSingle();

    return response != null ? Map<String, dynamic>.from(response) : null;
  }

  /// Lee todos los usuarios pertenecientes a una empresa en Supabase
  Future<List<Map<String, dynamic>>> readAllUsuarios(int empresaId) async {
    final response = await client
        .from('usuarios')
        .select()
        .eq('empresa_id', empresaId)
        .order('id', ascending: true);

    return List<Map<String, dynamic>>.from(response);
  }

  /// Crea un nuevo usuario/empleado en Supabase
  Future<int> createUsuario({
    required String username,
    required String password,
    required String nombre,
    required String rol,
    required int empresaId,
  }) async {
    final response = await client
        .from('usuarios')
        .insert({
      'username': username,
      'password': password,
      'nombre': nombre,
      'rol': rol,
      'empresa_id': empresaId,
      'activo': true,
    })
        .select('id')
        .single();

    return (response['id'] as num).toInt();
  }

  /// Actualiza un usuario existente en Supabase
  Future<void> updateUsuario({
    required int id,
    required String nombre,
    required String username,
    required String password,
    required String rol,
  }) async {
    final Map<String, dynamic> updates = {
      'nombre': nombre,
      'username': username,
      'rol': rol,
    };
    if (password.isNotEmpty) {
      updates['password'] = password;
    }

    await client.from('usuarios').update(updates).eq('id', id);
  }

  /// Actualiza el estado activo/inactivo de un usuario en Supabase
  Future<void> updateUsuarioStatus(int id, bool activo) async {
    await client.from('usuarios').update({'activo': activo}).eq('id', id);
  }

  /// Elimina un usuario en Supabase
  Future<void> deleteUsuario(int id) async {
    await client.from('usuarios').delete().eq('id', id);
  }

  // ===========================================================================
  // PRODUCTOS (INVENTARIO)
  // ===========================================================================

  /// Carga todos los productos de la empresa activa desde Supabase.
  Future<List<Producto>> readAllProductos(int empresaId) async {
    final response = await client
        .from('productos')
        .select()
        .eq('empresa_id', empresaId)
        .order('id', ascending: false);

    final List list = response as List;
    return list.map((json) {
      return Producto(
        id: (json['id'] as num).toInt(),
        codigo: json['codigo'] ?? '',
        nombre: json['nombre'] ?? '',
        precio: (json['precio'] as num? ?? 0.0).toDouble(),
        costo: (json['costo'] as num? ?? 0.0).toDouble(),
        stock: (json['stock'] as num? ?? 0).toInt(),
        stockMinimo: (json['stock_minimo'] as num? ?? 12).toInt(),
        categoria: json['categoria'] ?? 'General',
        imagen: json['imagen'],
        // ✅ PROPIEDADES DE FARMACIA AGREGADAS (FEFO Y SENASAG)
        requiereReceta: json['requiere_receta'] ?? false,
        esPsicotropico: json['es_psicotropico'] ?? false,
        principioActivo: json['principio_activo'],
        registroSanitario: json['registro_sanitario'],
        unidadesPorCaja: (json['unidades_por_caja'] as num? ?? 1).toInt(),
        unidadesPorBlister: (json['unidades_por_blister'] as num? ?? 10).toInt(),
      );
    }).toList();
  }

  /// Busca un producto por código de barras para la empresa activa.
  Future<Producto?> readProductoByCodigo(String codigo, int empresaId) async {
    final response = await client
        .from('productos')
        .select()
        .eq('empresa_id', empresaId)
        .eq('codigo', codigo)
        .maybeSingle();

    if (response == null) return null;

    return Producto(
      id: (response['id'] as num).toInt(),
      codigo: response['codigo'] ?? '',
      nombre: response['nombre'] ?? '',
      precio: (response['precio'] as num? ?? 0.0).toDouble(),
      costo: (response['costo'] as num? ?? 0.0).toDouble(),
      stock: (response['stock'] as num? ?? 0).toInt(),
      stockMinimo: (response['stock_minimo'] as num? ?? 12).toInt(),
      categoria: response['categoria'] ?? 'General',
      imagen: response['imagen'],
      // ✅ PROPIEDADES DE FARMACIA AGREGADAS (FEFO Y SENASAG)
      requiereReceta: response['requiere_receta'] ?? false,
      esPsicotropico: response['es_psicotropico'] ?? false,
      principioActivo: response['principio_activo'],
      registroSanitario: response['registro_sanitario'],
      unidadesPorCaja: (response['unidades_por_caja'] as num? ?? 1).toInt(),
      unidadesPorBlister: (response['unidades_por_blister'] as num? ?? 10).toInt(),
    );
  }

  /// Crea un producto nuevo en Supabase.
  Future<int> createProducto(Producto producto, int empresaId) async {
    final Map<String, dynamic> data = {
      'codigo': producto.codigo,
      'nombre': producto.nombre,
      'precio': producto.precio,
      'costo': producto.costo,
      'stock': producto.stock,
      'stock_minimo': producto.stockMinimo <= 0 ? 12 : producto.stockMinimo,
      'categoria': producto.categoria,
      'empresa_id': empresaId,
      // Propiedades de farmacia (opcionales al crear manualmente)
      'requiere_receta': producto.requiereReceta,
      'es_psicotropico': producto.esPsicotropico,
      'principio_activo': producto.principioActivo,
      'registro_sanitario': producto.registroSanitario,
      'unidades_por_caja': producto.unidadesPorCaja,
      'unidades_por_blister': producto.unidadesPorBlister,
    };
    if (producto.imagen != null && producto.imagen!.isNotEmpty) {
      data['imagen'] = producto.imagen;
    }

    final response = await client
        .from('productos')
        .insert(data)
        .select('id')
        .single();

    return (response['id'] as num).toInt();
  }

  /// Actualiza un producto existente en Supabase.
  Future<void> updateProducto(Producto producto) async {
    if (producto.id == null) return;
    final Map<String, dynamic> updates = {
      'codigo': producto.codigo,
      'nombre': producto.nombre,
      'precio': producto.precio,
      'costo': producto.costo,
      'stock': producto.stock,
      'stock_minimo': producto.stockMinimo,
      'categoria': producto.categoria,
      // Propiedades de farmacia
      'requiere_receta': producto.requiereReceta,
      'es_psicotropico': producto.esPsicotropico,
      'principio_activo': producto.principioActivo,
      'registro_sanitario': producto.registroSanitario,
      'unidades_por_caja': producto.unidadesPorCaja,
      'unidades_por_blister': producto.unidadesPorBlister,
    };
    if (producto.imagen != null && producto.imagen!.isNotEmpty) {
      updates['imagen'] = producto.imagen;
    }

    await client.from('productos').update(updates).eq('id', producto.id!);
  }

  // ==========================================================================
  // GESTIÓN DE LOTES Y REGLA FEFO (MÓDULO FARMACÉUTICO)
  // ==========================================================================

  /// Lee todos los lotes de un producto ordenados por fecha de vencimiento (FEFO)
  Future<List<LoteProducto>> readLotesProducto(int productoId, int empresaId) async {
    try {
      final response = await client
          .from('producto_lotes')
          .select()
          .eq('producto_id', productoId)
          .eq('empresa_id', empresaId)
          .order('fecha_vencimiento', ascending: true);

      final List list = response as List;
      return list.map((json) => LoteProducto.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error leyendo lotes del producto $productoId: $e');
      return [];
    }
  }

  /// Lee el primer lote activo (no vencido y con stock > 0) ordenado por FEFO
  Future<LoteProducto?> readLoteFEFOActivo(int productoId, int empresaId) async {
    try {
      final nowStr = DateTime.now().toIso8601String().split('T').first;
      final response = await client
          .from('producto_lotes')
          .select()
          .eq('producto_id', productoId)
          .eq('empresa_id', empresaId)
          .gt('stock_unidades', 0)
          .gte('fecha_vencimiento', nowStr)
          .order('fecha_vencimiento', ascending: true)
          .limit(1)
          .maybeSingle();

      if (response == null) return null;
      return LoteProducto.fromJson(response);
    } catch (e) {
      debugPrint('Error leyendo lote FEFO activo: $e');
      return null;
    }
  }

  /// Crea un nuevo lote para un producto
  Future<int?> createLoteProducto(LoteProducto lote) async {
    try {
      final response = await client
          .from('producto_lotes')
          .insert(lote.toJson())
          .select('id')
          .single();
      return (response['id'] as num).toInt();
    } catch (e) {
      debugPrint('Error creando lote de producto: $e');
      return null;
    }
  }

  /// Actualiza un lote existente
  Future<void> updateLoteProducto(LoteProducto lote) async {
    if (lote.id == null) return;
    try {
      await client
          .from('producto_lotes')
          .update(lote.toJson())
          .eq('id', lote.id!);
    } catch (e) {
      debugPrint('Error actualizando lote: $e');
    }
  }

  /// Elimina un lote
  Future<void> deleteLoteProducto(int loteId) async {
    try {
      await client.from('producto_lotes').delete().eq('id', loteId);
    } catch (e) {
      debugPrint('Error eliminando lote: $e');
    }
  }

  /// Elimina un producto de Supabase por ID.
  Future<void> deleteProducto(int id) async {
    await client.from('productos').delete().eq('id', id);
  }

  /// Lee el historial Kardex de un producto desde Supabase.
  Future<List<Map<String, dynamic>>> readMovimientosInventario(
      int productoId,
      ) async {
    final response = await client
        .from('movimientos_inventario')
        .select()
        .eq('producto_id', productoId)
        .order('id', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // ===========================================================================
  // CLIENTES
  // ===========================================================================

  /// Lee todos los clientes de la empresa activa en Supabase.
  Future<List<Map<String, dynamic>>> readAllClientes(int empresaId) async {
    final response = await client
        .from('clientes')
        .select()
        .eq('empresa_id', empresaId)
        .order('nombre', ascending: true);

    return List<Map<String, dynamic>>.from(response);
  }

  /// Registra un cliente nuevo en Supabase.
  Future<int> createCliente({
    required String nombre,
    String? nit,
    String? telefono,
    String? email,
    String? direccion,
    required int empresaId,
  }) async {
    final response = await client
        .from('clientes')
        .insert({
      'nombre': nombre,
      'nit': nit,
      'telefono': telefono,
      'email': email,
      'dirección': direccion,
      'deuda': 0.0,
      'empresa_id': empresaId,
    })
        .select('id')
        .single();

    return (response['id'] as num).toInt();
  }

  /// Registra un abono a crédito en Supabase y actualiza la deuda del cliente.
  Future<void> processAbonoCredito({
    required int clienteId,
    required double monto,
    required String descripcion,
    required int empresaId,
  }) async {
    // 1. Obtener deuda actual
    final clienteRes = await client
        .from('clientes')
        .select('deuda')
        .eq('id', clienteId)
        .single();

    final double deudaActual = (clienteRes['deuda'] as num? ?? 0.0).toDouble();
    final double nuevaDeuda = (deudaActual - monto) < 0 ? 0.0 : (deudaActual - monto);

    // 2. Actualizar deuda del cliente
    await client.from('clientes').update({'deuda': nuevaDeuda}).eq('id', clienteId);

    // 3. Registrar el movimiento de crédito
    await client.from('movimientos_credito').insert({
      'empresa_id': empresaId,
      'cliente_id': clienteId,
      'tipo': 'ABONO',
      'monto': monto,
      'descripcion': descripcion,
      'fecha': DateTime.now().toIso8601String(),
    });
  }

  // ===========================================================================
  // CAJA Y SESIONES
  // ===========================================================================

  /// Revisa si existe una caja abierta para la empresa activa.
  Future<Map<String, dynamic>?> getCajaAbierta(int empresaId) async {
    final response = await client
        .from('caja_sesiones')
        .select()
        .eq('empresa_id', empresaId)
        .eq('estado', 'ABIERTA')
        .maybeSingle();

    return response != null ? Map<String, dynamic>.from(response) : null;
  }

  /// Abre una nueva sesión de caja en Supabase.
  Future<int> abrirCaja({
    required int empresaId,
    int? usuarioId,
    required double montoInicial,
  }) async {
    final response = await client
        .from('caja_sesiones')
        .insert({
      'empresa_id': empresaId,
      'usuario_id': usuarioId,
      'monto_inicial': montoInicial,
      'monto_final': 0.0,
      'estado': 'ABIERTA',
      'fecha_apertura': DateTime.now().toIso8601String(),
    })
        .select('id')
        .single();

    return (response['id'] as num).toInt();
  }

  /// Cierra la sesión de caja en Supabase.
  Future<void> cerrarCaja({
    required int cajaSesionId,
    required double montoFinal,
  }) async {
    await client.from('caja_sesiones').update({
      'monto_final': montoFinal,
      'estado': 'CERRADA',
      'fecha_cierre': DateTime.now().toIso8601String(),
    }).eq('id', cajaSesionId);
  }

  /// Registra un movimiento de ingreso o egreso de caja en Supabase.
  Future<void> insertMovimientoCaja({
    required int empresaId,
    int? usuarioId,
    int? cajaSesionId,
    required String tipo,
    required double monto,
    required String descripcion,
  }) async {
    await client.from('movimientos_caja').insert({
      'empresa_id': empresaId,
      'usuario_id': usuarioId,
      'caja_sesión_id': cajaSesionId,
      'tipo': tipo,
      'monto': monto,
      'descripcion': descripcion,
      'fecha': DateTime.now().toIso8601String(),
    });
  }

  /// Lee todos los movimientos de caja de Supabase.
  Future<List<Map<String, dynamic>>> fetchMovimientosCaja(
      int empresaId, {
        int? cajaSesionId,
      }) async {
    final response = cajaSesionId != null
        ? await client
        .from('movimientos_caja')
        .select()
        .eq('empresa_id', empresaId)
        .eq('caja_sesión_id', cajaSesionId)
        .order('id', ascending: false)
        : await client
        .from('movimientos_caja')
        .select()
        .eq('empresa_id', empresaId)
        .order('id', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // ===========================================================================
  // VENTAS Y CHECKOUT
  // ===========================================================================

  /// Registra una venta completa y sus detalles en Supabase.
  Future<int> processSale({
    required int empresaId,
    int? usuarioId,
    int? clienteId,
    required double total,
    double subtotal = 0.0,
    double descuento = 0.0,
    required String metodoPago,
    required List<Map<String, dynamic>> items,
  }) async {
    // 1. Insertar venta principal
    final ventaResponse = await client
        .from('ventas')
        .insert({
      'empresa_id': empresaId,
      'usuario_id': usuarioId,
      'cliente_id': clienteId,
      'total': total,
      'subtotal': subtotal == 0.0 ? total : subtotal,
      'descuento': descuento,
      'metodo_pago': metodoPago,
      'estado': 'COMPLETADA',
      'fecha': DateTime.now().toIso8601String(),
    })
        .select('id')
        .single();

    final int ventaId = (ventaResponse['id'] as num).toInt();

    // 2. Insertar detalles de la venta
    // ✅ CORRECCIÓN: Ahora incluimos lote_id y unidad_venta
    final List<Map<String, dynamic>> detallesToInsert = [];
    for (var item in items) {
      detallesToInsert.add({
        'venta_id': ventaId,
        'producto_id': item['producto_id'],
        'cantidad': item['cantidad'],
        'precio_unitario': item['precio_unitario'],
        'subtotal': item['subtotal'],
        'empresa_id': empresaId,
        // Datos de Farmacia / FEFO
        if (item.containsKey('lote_id')) 'lote_id': item['lote_id'],
        if (item.containsKey('unidad_venta')) 'unidad_venta': item['unidad_venta'],
      });
    }

    await client.from('ventas_detalle').insert(detallesToInsert);

    // 3. Si fue a Crédito, aumentar deuda del cliente
    if (metodoPago == 'CREDITO' && clienteId != null) {
      final clienteRes = await client
          .from('clientes')
          .select('deuda')
          .eq('id', clienteId)
          .single();

      final double deudaActual = (clienteRes['deuda'] as num? ?? 0.0).toDouble();
      await client
          .from('clientes')
          .update({'deuda': deudaActual + total})
          .eq('id', clienteId);

      await client.from('movimientos_credito').insert({
        'empresa_id': empresaId,
        'cliente_id': clienteId,
        'tipo': 'CARGO',
        'monto': total,
        'descripcion': 'Compra a crédito (Venta #$ventaId)',
        'fecha': DateTime.now().toIso8601String(),
      });
    }

    return ventaId;
  }

  /// Lee el historial de ventas de Supabase.
  Future<List<Map<String, dynamic>>> readAllVentas(int empresaId) async {
    final response = await client
        .from('ventas')
        .select()
        .eq('empresa_id', empresaId)
        .order('id', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  /// Anula una venta en Supabase (El Trigger de Supabase repondrá el stock en la tabla productos).
  Future<void> processReturnSale({
    required int ventaId,
    required int empresaId,
    required String motivo,
  }) async {
    await client.from('ventas').update({
      'estado': 'ANULADA',
    }).eq('id', ventaId);

    await client.from('devoluciones').insert({
      'empresa_id': empresaId,
      'venta_id': ventaId,
      'motivo': motivo,
      'fecha': DateTime.now().toIso8601String(),
    });
  }

  // ===========================================================================
  // DASHBOARD / MÉTRICAS
  // ===========================================================================

  /// Carga métricas rápidas del Dashboard desde Supabase.
  Future<Map<String, dynamic>> getDashboardMetrics(int empresaId) async {
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);

    // Ventas completadas de hoy
    final ventasTodayRes = await client
        .from('ventas')
        .select('total')
        .eq('empresa_id', empresaId)
        .eq('estado', 'COMPLETADA')
        .gte('fecha', '$todayStr T00:00:00');

    final List ventasToday = ventasTodayRes as List;
    double todayTotalVentas = 0.0;
    for (var v in ventasToday) {
      todayTotalVentas += (v['total'] as num? ?? 0.0).toDouble();
    }

    // Estado de Caja
    final cajaAbierta = await getCajaAbierta(empresaId);

    // Conteo de Stock Bajo
    final productosBajosRes = await client
        .from('productos')
        .select('id, stock, stock_minimo')
        .eq('empresa_id', empresaId);

    int lowStockCount = 0;
    for (var p in (productosBajosRes as List)) {
      final int stock = (p['stock'] as num? ?? 0).toInt();
      final int min = (p['stock_minimo'] as num? ?? 12).toInt();
      if (stock <= min) lowStockCount++;
    }

    // Últimas 5 ventas
    final ultimasVentas = await client
        .from('ventas')
        .select('id, total, metodo_pago, estado, fecha')
        .eq('empresa_id', empresaId)
        .order('id', ascending: false)
        .limit(5);

    return {
      'todayTotalVentas': todayTotalVentas,
      'todayNumVentas': ventasToday.length,
      'isCajaAbierta': cajaAbierta != null,
      'lowStockCount': lowStockCount,
      'ultimasVentas': List<Map<String, dynamic>>.from(ultimasVentas),
    };
  }
}