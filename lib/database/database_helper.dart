import 'dart:async';
import 'dart:math';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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
      version: 5,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 5) {
      print('Actualizando DB a versión $newVersion (Multitenancy)...');
      // Para desarrollo, simplemente borramos y recreamos si el esquema cambia
      await db.execute('DROP TABLE IF EXISTS usuarios');
      await db.execute('DROP TABLE IF EXISTS productos');
      await db.execute('DROP TABLE IF EXISTS clientes');
      await db.execute('DROP TABLE IF EXISTS ventas');
      await db.execute('DROP TABLE IF EXISTS ventas_detalle');
      await db.execute('DROP TABLE IF EXISTS movimientos_caja');
      await _createDB(db, newVersion);
    }
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
      CREATE TABLE usuarios (
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
      CREATE TABLE empresas (
        id $idType,
        nombre $textType,
        tipo $textType,
        nit $textNullable,
        telefono $textNullable
      )
    ''');

    // Tabla Productos
    await db.execute('''
      CREATE TABLE productos (
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
      CREATE TABLE clientes (
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
      CREATE TABLE ventas (
        id $idType,
        fecha $textType,
        total $realType,
        cliente_id INTEGER,
        usuario_id INTEGER,
        empresa_id INTEGER,
        metodo_pago $textType,
        estado $textType,
        FOREIGN KEY (cliente_id) REFERENCES clientes (id),
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
      )
    ''');

    // Tabla Detalle de Ventas
    await db.execute('''
      CREATE TABLE ventas_detalle (
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
      CREATE TABLE movimientos_caja (
        id $idType,
        fecha $textType,
        tipo $textType, -- 'INGRESO' o 'EGRESO'
        monto $realType,
        descripcion $textType,
        usuario_id INTEGER,
        empresa_id INTEGER,
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
      )
    ''');

    // YA NO insertar usuario por defecto aquí para dejar la DB limpia
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

      // 3. Poblar Inventario para esta empresa específica
      final items = InventoryInitializer.getItemsFor(businessType);
      final random = Random();

      for (var item in items) {
        double costoBase = (random.nextDouble() * 50) + 5;
        double precioVenta = costoBase * 1.3;
        
        await txn.insert('productos', {
          'codigo': item['codigo'],
          'nombre': item['nombre'],
          'precio': double.parse(precioVenta.toStringAsFixed(2)),
          'costo': double.parse(costoBase.toStringAsFixed(2)),
          'stock': random.nextInt(101),
          'stock_minimo': 10,
          'categoria': 'General',
          'empresa_id': empresaId,
        });
      }

      return empresaId;
    });
  }

  Future<void> populateInventory(String businessType) async {
    // Este método queda depreciado por registerFullBusiness pero lo mantenemos por compatibilidad si es necesario
    print('ADVERTENCIA: Usar registerFullBusiness para nueva estructura.');
  }

  // --- MÉTODOS FILTRADOS POR EMPRESA (Ejemplos) ---

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

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
