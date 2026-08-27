import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/producto_model.dart';

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
      version: 1,
      onCreate: _createDB,
    );
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
      'password': 'admin123', // En un futuro usaremos hashing
      'nombre': 'Administrador',
      'rol': 'admin',
      'activo': 1
    });

    // Insertar algunos productos de ejemplo para pruebas
    await db.insert('productos', {
      'codigo': 'MOT-001',
      'nombre': 'Aceite de Motor 20W-50',
      'precio': 85.0,
      'costo': 60.0,
      'stock': 12,
      'categoria': 'Aceites'
    });
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
      columns: ['id', 'codigo', 'nombre', 'precio', 'costo', 'stock', 'categoria', 'imagen'],
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
