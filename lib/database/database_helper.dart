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
      version: 4,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 4) {
      print('Actualizando DB a versión $newVersion...');
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
        activo $boolType DEFAULT 1
      )
    ''');

    // Tabla Productos
    await db.execute('''
      CREATE TABLE productos (
        id $idType,
        codigo $textType UNIQUE,
        nombre $textType,
        precio $realType,
        costo $realType,
        stock $integerType,
        stock_minimo $integerType DEFAULT 5,
        categoria $textNullable,
        imagen $textNullable
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
        deuda $realType DEFAULT 0.0
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
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
      )
    ''');

    // Insertar un usuario administrador por defecto
    await db.insert('usuarios', {
      'username': 'admin',
      'password': 'admin123',
      'nombre': 'Administrador',
      'rol': 'admin',
      'activo': 1
    });
  }

  Future<void> clearDatabase() async {
    print('Limpiando base de datos...');
    final db = await instance.database;
    await db.delete('productos');
    await db.delete('clientes');
    await db.delete('ventas');
    await db.delete('ventas_detalle');
    await db.delete('movimientos_caja');
    print('Base de datos limpia.');
  }

  Future<void> populateInventory(String businessType) async {
    print('Poblando inventario para: $businessType');
    final db = await instance.database;
    final items = InventoryInitializer.getItemsFor(businessType);
    final random = Random();

    for (var item in items) {
      // Generar precios y stock aleatorios para pruebas
      double costoBase = (random.nextDouble() * 50) + 5; // Costo entre 5 y 55
      double precioVenta = costoBase * 1.3; // Margen del 30%
      int stockAleatorio = random.nextInt(101); // Stock entre 0 y 100
      int stockMinimo = 10; // Stock mínimo estándar para alertas

      await db.insert('productos', {
        'codigo': item['codigo'],
        'nombre': item['nombre'],
        'precio': double.parse(precioVenta.toStringAsFixed(2)),
        'costo': double.parse(costoBase.toStringAsFixed(2)),
        'stock': stockAleatorio,
        'stock_minimo': stockMinimo,
        'categoria': 'General'
      });
    }
    print('Inventario poblado exitosamente.');
  }

  // --- MÉTODOS PARA PRODUCTOS ---

  Future<int> createProducto(Producto producto) async {
    final db = await instance.database;
    return await db.insert('productos', producto.toMap());
  }

  Future<List<Producto>> readAllProductos() async {
    final db = await instance.database;
    final result = await db.query('productos', orderBy: 'nombre ASC');
    return result.map((json) => Producto.fromMap(json)).toList();
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
