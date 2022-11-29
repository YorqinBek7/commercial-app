import 'package:commercial_app/data/db/cached_products.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDataBase {
  static final LocalDataBase getInstance = LocalDataBase._();
  factory LocalDataBase() => getInstance;
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("Products.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const intType = "INTEGER DEFAULT 0";
    const textType = "TEXT NOT NULL";

    await db.execute('''
    CREATE TABLE $tableName (
      ${SelectedProductsRows.count} $intType,
      ${SelectedProductsRows.image} $textType,
      ${SelectedProductsRows.price} $intType,
      ${SelectedProductsRows.rate} $intType,
      ${SelectedProductsRows.title} $textType,
      ${SelectedProductsRows.id} $idType,
      ${SelectedProductsRows.countSelect} $intType
    )
''');
  }

  static Future<SelectedProducts> insert(
      SelectedProducts selectedProducts) async {
    final db = await getInstance.database;
    final id = await db.insert(tableName, selectedProducts.toJson());
    return selectedProducts.copyWith(id: id);
  }

  static Future<int> deleteAllProducts() async {
    final db = await getInstance.database;
    return await db.delete(tableName);
  }

  static Future<int> deleteByID(int id) async {
    final db = await getInstance.database;
    final t = await db.delete(tableName,
        where: "${SelectedProductsRows.id} = ?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<List<SelectedProducts>> getAllProducts() async {
    final db = await getInstance.database;
    final result = await db.query(tableName);
    return result.map((json) => SelectedProducts.fromJson(json)).toList();
  }

  static Future<int> editProducts({required int id}) async {
    Map<String, Object?> row = {
      SelectedProductsRows.id: id,
    };

    final db = await getInstance.database;
    return await db.update(
      tableName,
      row,
      where: '${SelectedProductsRows.id} = ?',
      whereArgs: [id],
    );
  }

  static Future<int> editProductCount(
      {required int count, required int id}) async {
    Map<String, Object?> row = {SelectedProductsRows.countSelect: count};

    final db = await getInstance.database;
    return await db.update(
      tableName,
      row,
      where: '${SelectedProductsRows.id} = ?',
      whereArgs: [id],
    );
  }

  LocalDataBase._();
}
