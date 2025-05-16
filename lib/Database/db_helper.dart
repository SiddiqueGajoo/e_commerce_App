import 'dart:io' as io;
import 'package:e_commerce_app/model/cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:e_commerce_app/model/cart_model.dart';
class DBHelper{
  static Database? _db;
  Future<Database?>get db async{
    if(_db !=null){
      return _db!;
    }
    _db = await initDatabase();
    return _db;
  }
  initDatabase()async{
    io.Directory documentDirectory = await getApplicationCacheDirectory();
    String path = join(documentDirectory.path,'cart.db');
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db,int version)async {
    await db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY,url VARCHAR UNIQUE, title TEXT, size TEXT, price REAL,color INTEGER)');
  }
    Future<CartModel> insert (CartModel cart)async {
      var dbClient = await db;
      try {
        await dbClient!.insert(
            'cart', cart.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (e) {
        print('Error inserting into database: $e');
      }
      return cart;
    }
  Future<List<CartModel>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('cart');
    return queryResult.map((e) => CartModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(
        'cart',
        where: 'id = ?',
        whereArgs: [id]
    );
  }
  Future<int> update(CartModel cart) async {
    var dbClient = await db;
    return await dbClient!.update(
        'cart',
        cart.toMap(),
        where: 'id = ?',
        whereArgs: [cart.id]
    );
  }
}


