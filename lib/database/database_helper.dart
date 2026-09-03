import 'dart:async';
import 'dart:math';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/producto_model.dart';
import 'inventory_initializer.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('multipos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 9,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    print('Migrando Base de Datos incrementalmente de v$oldVersion a v$newVersion...');
    // Ejecutar _createDB con CREATE TABLE IF NOT EXISTS para conservar todos los datos locales
    await _createDB(db, newVersion);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textNullable = 'TEXT';
    const boolType = 'INTEGER NOT NULL'; // 0 for false, 1 for true
    const integerType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    // Tabla Usuarios
    await db.execute('''
      CREATE TABLE IF NOT EXISTS usuarios (
        id $idType,
        username $textType UNIQUE,
        password $textType,
        nombre $textType,
        rol $textType,
        empresa_id INTEGER,
        activo $boolType DEFAULT 1
      )
    ''');

    // Tabla Empresas
    await db.execute('''
      CREATE TABLE IF NOT EXISTS empresas (
        id $idType,
        nombre $textType,
        tipo $textType,
        nit $textNullable,
        telefono $textNullable
      )
    ''');

    // Tabla Productos
    await db.execute('''
      CREATE TABLE IF NOT EXISTS productos (
        id $idType,
        codigo $textType,
        nombre $textType,
        precio $realType,
        costo $realType,
        stock $integerType,
        stock_minimo $integerType DEFAULT 5,
        categoria $textNullable,
        imagen $textNullable,
        empresa_id INTEGER,
        UNIQUE(codigo, empresa_id)
      )
    ''');

    // Tabla Clientes
    await db.execute('''
      CREATE TABLE IF NOT EXISTS clientes (
        id $idType,
        nombre $textType,
        nit $textNullable,
        telefono $textNullable,
        email $textNullable,
        direccion $textNullable,
        deuda $realType DEFAULT 0.0,
        empresa_id INTEGER
      )
    ''');

    // Tabla Ventas
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ventas (
        id $idType,
        fecha $textType,
        total $realType,
        cliente_id INTEGER,
        usuario_id INTEGER,
        empresa_id INTEGER,
        metodo_pago $textType,
        estado $textType,
        subtotal $realType DEFAULT 0.0,
        descuento $realType DEFAULT 0.0,
        impuesto $realType DEFAULT 0.0,
        FOREIGN KEY (cliente_id) REFERENCES clientes (id),
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
      )
    ''');

    // Tabla Detalle de Ventas
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ventas_detalle (
        id $idType,
        venta_id INTEGER,
        producto_id INTEGER,
        cantidad $integerType,
        precio_unitario $realType,
        subtotal $realType,
        empresa_id INTEGER,
        FOREIGN KEY (venta_id) REFERENCES ventas (id),
        FOREIGN KEY (producto_id) REFERENCES productos (id)
      )
    ''');

    // Tabla Movimientos de Caja
    await db.execute('''
      CREATE TABLE IF NOT EXISTS movimientos_caja (
        id $idType,
        fecha $textType,
        tipo $textType, -- 'INGRESO' o 'EGRESO'
        monto $realType,
        descripcion $textType,
        usuario_id INTEGER,
        empresa_id INTEGER,
        caja_sesion_id INTEGER,
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
      )
    ''');

    // Tabla Caja Sesiones (Turnos)
    await db.execute('''
      CREATE TABLE IF NOT EXISTS caja_sesiones (
        id $idType,
        empresa_id INTEGER,
        usuario_id INTEGER,
        fecha_apertura $textType,
        fecha_cierre $textNullable,
        monto_inicial $realType,
        monto_final $realType DEFAULT 0.0,
        estado $textType DEFAULT 'ABIERTA'
      )
    ''');

    // Tabla Movimientos Inventario (Kardex)
    await db.execute('''
      CREATE TABLE IF NOT EXISTS movimientos_inventario (
        id $idType,
        empresa_id INTEGER,
        producto_id INTEGER,
        tipo $textType, -- 'ENTRADA', 'SALIDA', 'AJUSTE', 'VENTA', 'DEVOLUCION'
        cantidad $integerType,
        motivo $textNullable,
        fecha $textType,
        usuario_id INTEGER
      )
    ''');

    // Tabla Devoluciones
    await db.execute('''
      CREATE TABLE IF NOT EXISTS devoluciones (
        id $idType,
        empresa_id INTEGER,
        venta_id INTEGER,
        fecha $textType,
        usuario_id INTEGER,
        motivo $textType,
        total_devuelto $realType
      )
    ''');

    // Tabla Detalle Devoluciones
    await db.execute('''
      CREATE TABLE IF NOT EXISTS devoluciones_detalle (
        id $idType,
        devolucion_id INTEGER,
        producto_id INTEGER,
        cantidad $integerType,
        precio_unitario $realType
      )
    ''');

    // Tabla Movimientos Credito
    await db.execute('''
      CREATE TABLE IF NOT EXISTS movimientos_credito (
        id $idType,
        empresa_id INTEGER,
        cliente_id INTEGER,
        tipo $textType, -- 'CARGO', 'ABONO'
        monto $realType,
        fecha $textType,
        descripcion $textNullable
      )
    ''');

    // Tabla Auditoria
    await db.execute('''
      CREATE TABLE IF NOT EXISTS auditoria (
        id $idType,
        empresa_id INTEGER,
        usuario_id INTEGER,
        accion $textType,
        entidad $textType,
        entidad_id $textNullable,
        detalle $textType,
        fecha $textType
      )
    ''');

    // Tabla Credenciales Clientes (QR / PIN)
    await db.execute('''
      CREATE TABLE IF NOT EXISTS credenciales_clientes (
        id $idType,
        empresa_id INTEGER,
        cliente_id INTEGER,
        credential_id $textType,
        pin $textNullable,
        estado $textType DEFAULT 'ACTIVA',
        fecha_emision $textType
      )
    ''');
  }

  Future<void> clearDatabase() async {
    print('Limpiando base de datos...');
    final db = await instance.database;
    await db.delete('productos');
    await db.delete('clientes');
    await db.delete('ventas');
    await db.delete('ventas_detalle');
    await db.delete('movimientos_caja');
    await db.delete('usuarios');
    await db.delete('empresas');
    print('Base de datos limpia.');
  }

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
    final db = await instance.database;
    
    return await db.transaction((txn) async {
      // 1. Crear Empresa
      final empresaId = await txn.insert('empresas', {
        'nombre': businessName,
        'tipo': businessType,
        'nit': nit,
        'telefono': phone,
      });

      // 2. Crear Usuario Propietario vinculado a la Empresa
      await txn.insert('usuarios', {
        'username': username,
        'password': password,
        'nombre': ownerName,
        'rol': 'admin',
        'empresa_id': empresaId,
        'activo': 1,
      });

      // 3. Generar inventario estándar si el usuario lo activó
      if (populateStandardInventory) {
        final items = InventoryInitializer.getItemsFor(businessType);
        final random = Random();

        // Mezclar índices para seleccionar 10 productos aleatorios con precio y stock
        List<int> indices = List.generate(items.length, (i) => i);
        indices.shuffle(random);
        Set<int> selectedWithStock = indices.take(10).toSet();

        for (int i = 0; i < items.length; i++) {
          final item = items[i];
          double costo = 0.0;
          double precio = 0.0;
          int stock = 0;

          if (selectedWithStock.contains(i)) {
            costo = double.parse(((random.nextDouble() * 50) + 5).toStringAsFixed(2));
            precio = double.parse((costo * 1.3).toStringAsFixed(2));
            stock = random.nextInt(90) + 10; // entre 10 y 100 unidades
          }

          await txn.insert('productos', {
            'codigo': item['codigo'],
            'nombre': item['nombre'],
            'precio': precio,
            'costo': costo,
            'stock': stock,
            'stock_minimo': 10,
            'categoria': 'General',
            'empresa_id': empresaId,
          });
        }
      }

      return empresaId;
    });
  }

  Future<void> populateInventory(String businessType) async {
    // Este método queda depreciado por registerFullBusiness pero lo mantenemos por compatibilidad si es necesario
    print('ADVERTENCIA: Usar registerFullBusiness para nueva estructura.');
  }

  // --- MÉTODOS PARA PRODUCTOS ---

  Future<int> createProducto(Producto producto) async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;
    
    final map = producto.toMap();
    map['empresa_id'] = empresaId;
    
    return await db.insert('productos', map);
  }

  Future<List<Producto>> readAllProductos() async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;

    final result = await db.query(
      'productos', 
      where: 'empresa_id = ?', 
      whereArgs: [empresaId],
      orderBy: 'nombre ASC'
    );
    return result.map((json) => Producto.fromMap(json)).toList();
  }

  Future<Producto?> readProductoByCodigo(String codigo) async {
    final db = await instance.database;
    final maps = await db.query(
      'productos',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (maps.isNotEmpty) {
      return Producto.fromMap(maps.first);
    }
    return null;
  }

  Future<Producto?> readProducto(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'productos',
      columns: [
        'id',
        'codigo',
        'nombre',
        'precio',
        'costo',
        'stock',
        'stock_minimo',
        'categoria',
        'imagen'
      ],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Producto.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateProducto(Producto producto) async {
    final db = await instance.database;
    return db.update(
      'productos',
      producto.toMap(),
      where: 'id = ?',
      whereArgs: [producto.id],
    );
  }

  Future<int> deleteProducto(int id) async {
    final db = await instance.database;
    return await db.delete(
      'productos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> readAllVentas() async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;
    
    return await db.query(
      'ventas', 
      where: 'empresa_id = ?', 
      whereArgs: [empresaId],
      orderBy: 'fecha DESC'
    );
  }

  Future<List<Map<String, dynamic>>> readAllClientes() async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;

    return await db.query(
      'clientes', 
      where: 'empresa_id = ?', 
      whereArgs: [empresaId],
      orderBy: 'nombre ASC'
    );
  }

  // --- MÉTODOS PARA EMPLEADOS Y ROLES ---

  Future<List<Map<String, dynamic>>> readAllUsuarios() async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    int empresaId = prefs.getInt('empresa_id') ?? -1;

    if (empresaId == -1) {
      final empresas = await db.query('empresas', limit: 1);
      if (empresas.isNotEmpty) {
        empresaId = empresas.first['id'] as int;
      }
    }

    return await db.query(
      'usuarios',
      where: 'empresa_id = ?',
      whereArgs: [empresaId],
      orderBy: 'nombre ASC',
    );
  }

  Future<int> createUsuario({
    required String username,
    required String password,
    required String nombre,
    required String rol,
  }) async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;

    return await db.insert('usuarios', {
      'username': username,
      'password': password,
      'nombre': nombre,
      'rol': rol,
      'empresa_id': empresaId,
      'activo': 1,
    });
  }

  Future<int> updateUsuarioStatus(int usuarioId, bool activo) async {
    final db = await instance.database;
    return await db.update(
      'usuarios',
      {'activo': activo ? 1 : 0},
      where: 'id = ?',
      whereArgs: [usuarioId],
    );
  }

  // --- MÉTODOS PARA CLIENTES Y CRÉDITO ---

  Future<int> createCliente({
    required String nombre,
    String? nit,
    String? telefono,
    String? email,
    String? direccion,
  }) async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;

    return await db.insert('clientes', {
      'nombre': nombre,
      'nit': nit,
      'telefono': telefono,
      'email': email,
      'direccion': direccion,
      'deuda': 0.0,
      'empresa_id': empresaId,
    });
  }

  Future<int> processAbonoCredito({
    required int clienteId,
    required double monto,
    String? descripcion,
  }) async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;
    final usuarioId = prefs.getInt('usuario_id') ?? -1;
    final now = DateTime.now().toIso8601String();

    return await db.transaction((txn) async {
      // 1. Reducir deuda del cliente
      await txn.rawUpdate(
        'UPDATE clientes SET deuda = MAX(0, deuda - ?) WHERE id = ? AND empresa_id = ?',
        [monto, clienteId, empresaId],
      );

      // 2. Registrar movimiento de crédito
      final abonoId = await txn.insert('movimientos_credito', {
        'empresa_id': empresaId,
        'cliente_id': clienteId,
        'tipo': 'ABONO',
        'monto': monto,
        'fecha': now,
        'descripcion': descripcion ?? 'Abono a deuda de cliente',
      });

      // 3. Obtener sesión de caja activa para ingresar el dinero
      final sesionActiva = await txn.query(
        'caja_sesiones',
        where: 'empresa_id = ? AND estado = ?',
        whereArgs: [empresaId, 'ABIERTA'],
        limit: 1,
      );
      final int? cajaSesionId = sesionActiva.isNotEmpty ? sesionActiva.first['id'] as int? : null;

      await txn.insert('movimientos_caja', {
        'fecha': now,
        'tipo': 'INGRESO',
        'monto': monto,
        'descripcion': 'Abono Crédito Cliente #$clienteId',
        'usuario_id': usuarioId,
        'empresa_id': empresaId,
        'caja_sesion_id': cajaSesionId,
      });

      // 4. Auditoría
      await txn.insert('auditoria', {
        'empresa_id': empresaId,
        'usuario_id': usuarioId,
        'accion': 'REGISTRAR_ABONO',
        'entidad': 'clientes',
        'entidad_id': '$clienteId',
        'detalle': 'Abono a crédito por total de \$ $monto',
        'fecha': now,
      });

      return abonoId;
    });
  }

  Future<List<Map<String, dynamic>>> readAllMovimientosCaja() async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;

    return await db.query(
      'movimientos_caja', 
      where: 'empresa_id = ?', 
      whereArgs: [empresaId],
      orderBy: 'fecha DESC'
    );
  }

  Future<Map<String, dynamic>?> login(String username, String password) async {
    final db = await instance.database;
    final normalizedUsername = username.trim().toLowerCase();
    final cleanPassword = password.trim();

    print('DEBUG LOGIN: intentando login con user="$normalizedUsername" pass="$cleanPassword"');

    final maps = await db.query(
      'usuarios',
      where: 'LOWER(username) = ? AND password = ? AND activo = 1',
      whereArgs: [normalizedUsername, cleanPassword],
    );

    if (maps.isNotEmpty) {
      print('DEBUG LOGIN: Exitoso para ID=${maps.first['id']} rol=${maps.first['rol']}');
      return maps.first;
    } else {
      print('DEBUG LOGIN: Falló. Verificando si usuario existe...');
      final checkUser = await db.query('usuarios', where: 'LOWER(username) = ?', whereArgs: [normalizedUsername]);
      if (checkUser.isNotEmpty) {
        print('DEBUG LOGIN: Usuario existe en DB pero la contraseña no coincide. Pass guardado="${checkUser.first['password']}"');
      } else {
        print('DEBUG LOGIN: Usuario "$normalizedUsername" NO existe en la base de datos.');
      }
    }
    return null;
  }

  Future<int> updateUsuario({
    required int usuarioId,
    required String nombre,
    required String password,
    required String rol,
  }) async {
    final db = await instance.database;
    final map = <String, dynamic>{
      'nombre': nombre.trim(),
      'rol': rol,
    };
    if (password.trim().isNotEmpty) {
      map['password'] = password.trim();
    }
    return await db.update(
      'usuarios',
      map,
      where: 'id = ?',
      whereArgs: [usuarioId],
    );
  }

  Future<int> deleteUsuario(int usuarioId) async {
    final db = await instance.database;
    return await db.delete(
      'usuarios',
      where: 'id = ? AND rol != ?',
      whereArgs: [usuarioId, 'admin'],
    );
  }

  // --- MÉTODOS PARA ATOMICIDAD DE VENTAS Y CAJA ---

  Future<int> processAtomicSale({
    required List<Map<String, dynamic>> items, // producto_id, cantidad, precio_unitario, subtotal
    required double total,
    required double subtotal,
    required double descuento,
    required String metodoPago,
    int? clienteId,
  }) async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;
    final usuarioId = prefs.getInt('usuario_id') ?? -1;
    final now = DateTime.now().toIso8601String();

    return await db.transaction((txn) async {
      // 1. Insertar Venta
      final ventaId = await txn.insert('ventas', {
        'fecha': now,
        'total': total,
        'subtotal': subtotal,
        'descuento': descuento,
        'impuesto': 0.0,
        'cliente_id': clienteId,
        'usuario_id': usuarioId,
        'empresa_id': empresaId,
        'metodo_pago': metodoPago,
        'estado': 'COMPLETADA',
      });

      // 2. Insertar Detalles y Descontar Stock + Registrar Kardex
      for (var item in items) {
        final int prodId = item['producto_id'];
        final int cantidad = item['cantidad'];
        final double precio = (item['precio_unitario'] as num).toDouble();
        final double sub = (item['subtotal'] as num).toDouble();

        await txn.insert('ventas_detalle', {
          'venta_id': ventaId,
          'producto_id': prodId,
          'cantidad': cantidad,
          'precio_unitario': precio,
          'subtotal': sub,
          'empresa_id': empresaId,
        });

        // Actualizar Stock
        await txn.rawUpdate(
          'UPDATE productos SET stock = stock - ? WHERE id = ? AND empresa_id = ?',
          [cantidad, prodId, empresaId],
        );

        // Kardex
        await txn.insert('movimientos_inventario', {
          'empresa_id': empresaId,
          'producto_id': prodId,
          'tipo': 'VENTA',
          'cantidad': cantidad,
          'motivo': 'Venta #$ventaId',
          'fecha': now,
          'usuario_id': usuarioId,
        });
      }

      // 3. Registrar Movimiento Financiero (Caja o Crédito)
      if (metodoPago == 'CREDITO' && clienteId != null) {
        // Aumentar deuda del cliente
        await txn.rawUpdate(
          'UPDATE clientes SET deuda = deuda + ? WHERE id = ? AND empresa_id = ?',
          [total, clienteId, empresaId],
        );
        await txn.insert('movimientos_credito', {
          'empresa_id': empresaId,
          'cliente_id': clienteId,
          'tipo': 'CARGO',
          'monto': total,
          'fecha': now,
          'descripcion': 'Venta a Crédito #$ventaId',
        });
      } else {
        // Ingreso de Caja
        final sesionActiva = await txn.query(
          'caja_sesiones',
          where: 'empresa_id = ? AND estado = ?',
          whereArgs: [empresaId, 'ABIERTA'],
          limit: 1,
        );
        final int? cajaSesionId = sesionActiva.isNotEmpty ? sesionActiva.first['id'] as int? : null;

        await txn.insert('movimientos_caja', {
          'fecha': now,
          'tipo': 'INGRESO',
          'monto': total,
          'descripcion': 'Venta #$ventaId ($metodoPago)',
          'usuario_id': usuarioId,
          'empresa_id': empresaId,
          'caja_sesion_id': cajaSesionId,
        });
      }

      // 4. Registrar Auditoría
      await txn.insert('auditoria', {
        'empresa_id': empresaId,
        'usuario_id': usuarioId,
        'accion': 'REGISTRAR_VENTA',
        'entidad': 'ventas',
        'entidad_id': '$ventaId',
        'detalle': 'Venta realizada por total de \$ $total ($metodoPago)',
        'fecha': now,
      });

      return ventaId;
    });
  }

  // --- GESTIÓN DE TURNOS DE CAJA ---

  Future<Map<String, dynamic>?> getCajaSesionActiva() async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;

    final result = await db.query(
      'caja_sesiones',
      where: 'empresa_id = ? AND estado = ?',
      whereArgs: [empresaId, 'ABIERTA'],
      limit: 1,
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<int> abrirCajaSesion(double montoInicial) async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;
    final usuarioId = prefs.getInt('usuario_id') ?? -1;
    final now = DateTime.now().toIso8601String();

    final activa = await getCajaSesionActiva();
    if (activa != null) {
      throw Exception('Ya existe un turno de caja abierto.');
    }

    return await db.insert('caja_sesiones', {
      'empresa_id': empresaId,
      'usuario_id': usuarioId,
      'fecha_apertura': now,
      'monto_inicial': montoInicial,
      'estado': 'ABIERTA',
    });
  }

  Future<int> cerrarCajaSesion(int sesionId, double montoFinal) async {
    final db = await instance.database;
    final now = DateTime.now().toIso8601String();

    return await db.update(
      'caja_sesiones',
      {
        'fecha_cierre': now,
        'monto_final': montoFinal,
        'estado': 'CERRADA',
      },
      where: 'id = ?',
      whereArgs: [sesionId],
    );
  }

  // --- ANULACIÓN Y DEVOLUCIONES ---

  Future<int> processReturnSale({
    required int ventaId,
    required String motivo,
  }) async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;
    final usuarioId = prefs.getInt('usuario_id') ?? -1;
    final now = DateTime.now().toIso8601String();

    return await db.transaction((txn) async {
      // 1. Obtener la venta
      final ventaMaps = await txn.query(
        'ventas',
        where: 'id = ? AND empresa_id = ?',
        whereArgs: [ventaId, empresaId],
      );
      if (ventaMaps.isEmpty) throw Exception('Venta no encontrada.');

      final venta = ventaMaps.first;
      final double totalDevuelto = (venta['total'] as num).toDouble();

      // 2. Marcar Venta como ANULADA
      await txn.update(
        'ventas',
        {'estado': 'ANULADA'},
        where: 'id = ?',
        whereArgs: [ventaId],
      );

      // 3. Registrar Devolución
      final devolucionId = await txn.insert('devoluciones', {
        'empresa_id': empresaId,
        'venta_id': ventaId,
        'fecha': now,
        'usuario_id': usuarioId,
        'motivo': motivo,
        'total_devuelto': totalDevuelto,
      });

      // 4. Recomponer inventario y registrar kardex
      final detalles = await txn.query(
        'ventas_detalle',
        where: 'venta_id = ?',
        whereArgs: [ventaId],
      );

      for (var d in detalles) {
        final int prodId = d['producto_id'] as int;
        final int cant = d['cantidad'] as int;
        final double precioUnit = (d['precio_unitario'] as num).toDouble();

        await txn.insert('devoluciones_detalle', {
          'devolucion_id': devolucionId,
          'producto_id': prodId,
          'cantidad': cant,
          'precio_unitario': precioUnit,
        });

        // Devolver Stock
        await txn.rawUpdate(
          'UPDATE productos SET stock = stock + ? WHERE id = ? AND empresa_id = ?',
          [cant, prodId, empresaId],
        );

        // Kardex
        await txn.insert('movimientos_inventario', {
          'empresa_id': empresaId,
          'producto_id': prodId,
          'tipo': 'DEVOLUCION',
          'cantidad': cant,
          'motivo': 'Anulación Venta #$ventaId',
          'fecha': now,
          'usuario_id': usuarioId,
        });
      }

      // 5. Egreso de Caja o Ajuste de Crédito
      final String metodo = venta['metodo_pago'] as String? ?? 'EFECTIVO';
      final int? clienteId = venta['cliente_id'] as int?;

      if (metodo == 'CREDITO' && clienteId != null) {
        await txn.rawUpdate(
          'UPDATE clientes SET deuda = MAX(0, deuda - ?) WHERE id = ? AND empresa_id = ?',
          [totalDevuelto, clienteId, empresaId],
        );
      } else {
        await txn.insert('movimientos_caja', {
          'fecha': now,
          'tipo': 'EGRESO',
          'monto': totalDevuelto,
          'descripcion': 'Anulación/Devolución Venta #$ventaId',
          'usuario_id': usuarioId,
          'empresa_id': empresaId,
        });
      }

      // 6. Auditoría
      await txn.insert('auditoria', {
        'empresa_id': empresaId,
        'usuario_id': usuarioId,
        'accion': 'ANULAR_VENTA',
        'entidad': 'ventas',
        'entidad_id': '$ventaId',
        'detalle': 'Anulación de venta por total de \$ $totalDevuelto. Motivo: $motivo',
        'fecha': now,
      });

      return devolucionId;
    });
  }

  Future<List<Map<String, dynamic>>> readMovimientosInventario(int productoId) async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;

    return await db.query(
      'movimientos_inventario',
      where: 'empresa_id = ? AND producto_id = ?',
      whereArgs: [empresaId, productoId],
      orderBy: 'fecha DESC',
    );
  }

  Future<Map<String, dynamic>> fetchDashboardMetrics() async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);

    final ventasHoy = await db.rawQuery(
      'SELECT SUM(total) as total_ventas, COUNT(id) as num_ventas FROM ventas WHERE empresa_id = ? AND fecha LIKE ? AND estado = ?',
      [empresaId, '$todayStr%', 'COMPLETADA'],
    );

    double totalVentas = 0.0;
    int numVentas = 0;
    if (ventasHoy.isNotEmpty) {
      totalVentas = (ventasHoy.first['total_ventas'] as num?)?.toDouble() ?? 0.0;
      numVentas = (ventasHoy.first['num_ventas'] as num?)?.toInt() ?? 0;
    }

    final cajaActiva = await db.query(
      'caja_sesiones',
      where: 'empresa_id = ? AND estado = ?',
      whereArgs: [empresaId, 'ABIERTA'],
      limit: 1,
    );

    final ultimasVentas = await db.query(
      'ventas',
      where: 'empresa_id = ?',
      whereArgs: [empresaId],
      orderBy: 'fecha DESC',
      limit: 2,
    );

    return {
      'total_ventas': totalVentas,
      'num_ventas': numVentas,
      'caja_abierta': cajaActiva.isNotEmpty,
      'ultimas_ventas': ultimasVentas,
    };
  }

  Future<bool> hasAnyCompany() async {
    final db = await instance.database;
    final result = await db.query('empresas', limit: 1);
    return result.isNotEmpty;
  }

  Future<Map<String, dynamic>?> getEmpresaActiva() async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    int empresaId = prefs.getInt('empresa_id') ?? -1;

    if (empresaId == -1) {
      final empresas = await db.query('empresas', limit: 1);
      if (empresas.isNotEmpty) {
        empresaId = empresas.first['id'] as int;
      }
    }

    final result = await db.query(
      'empresas',
      where: 'id = ?',
      whereArgs: [empresaId],
      limit: 1,
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<int> createUsuarioWithPermissions({
    required String username,
    required String password,
    required String nombre,
    required String rol,
    required Map<String, bool> permisos,
  }) async {
    final db = await instance.database;
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? -1;

    final normalizedUser = username.trim().toLowerCase();

    // Verificar si el usuario ya existe
    final existing = await db.query(
      'usuarios',
      where: 'username = ?',
      whereArgs: [normalizedUser],
    );

    if (existing.isNotEmpty) {
      throw Exception('El usuario "$normalizedUser" ya existe. Intente con otro nombre de usuario.');
    }

    return await db.insert('usuarios', {
      'username': normalizedUser,
      'password': password.trim(),
      'nombre': nombre.trim().isEmpty ? normalizedUser : nombre.trim(),
      'rol': rol,
      'empresa_id': empresaId,
      'activo': 1,
    });
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
