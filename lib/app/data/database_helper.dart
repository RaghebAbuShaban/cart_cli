import 'package:sqflite/sqflite.dart';
import 'package:cart_cli/app/data/cart_item.dart';
import 'package:cart_cli/app/data/product.dart';

class DatabaseHelper {
  static Database? database;

  static String createCartTable =
      'CREATE TABLE cart (name TEXT PRIMARY KEY, price REAL, quantity INTEGER)';

  static Future<Database> getDatabase() async {
    if (database != null) {
      return database!;
    }

    String path = await getDatabasesPath();

    database = await openDatabase(
      '$path/cart.db',
      version: 2,
      onCreate: (db, version) async {
        await db.execute(createCartTable);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS cart');
        await db.execute(createCartTable);
      },
    );

    return database!;
  }

  static Future<List<CartItem>> getCartItems() async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> rows = await db.query('cart');

    List<CartItem> items = [];
    for (Map<String, dynamic> row in rows) {
      items.add(
        CartItem(
          product: Product(name: row['name'], price: row['price']),
          quantity: row['quantity'],
        ),
      );
    }
    return items;
  }

  static Future<void> insertItem(CartItem item) async {
    Database db = await getDatabase();
    await db.insert('cart', {
      'name': item.product.name,
      'price': item.product.price,
      'quantity': item.quantity,
    });
  }

  static Future<void> updateItem(CartItem item) async {
    Database db = await getDatabase();
    await db.update(
      'cart',
      {'quantity': item.quantity},
      where: 'name = ?',
      whereArgs: [item.product.name],
    );
  }

  static Future<void> deleteItem(CartItem item) async {
    Database db = await getDatabase();
    await db.delete(
      'cart',
      where: 'name = ?',
      whereArgs: [item.product.name],
    );
  }

  static Future<void> clearCart() async {
    Database db = await getDatabase();
    await db.delete('cart');
  }
}