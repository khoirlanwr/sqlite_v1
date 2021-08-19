import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_v1/models/product_model.dart';

class ProductProvider {
  final String databaseName = 'product_database_v3.db';

  insertProduct(ProductModel newItem) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, '$databaseName');

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Product ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnProductName TEXT, $columnProductDesc TEXT, $columnProductPrice TEXT, $columnProductFavorites INTEGER, $columnProductPhoto TEXT)',
        );
      },
    );

    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
        'INSERT INTO Product($columnProductName, $columnProductDesc, $columnProductPrice, $columnProductFavorites, $columnProductPhoto) VALUES("${newItem.name}", "${newItem.desc}", "${newItem.price}", ${newItem.isFavorite}, "${newItem.photo}")',
      );

      print(id1);
    });

    await database.close();
  }

  Future<List<ProductModel>> getAllProducts() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, '$databaseName');
    List<ProductModel> products = [];

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Product ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnProductName TEXT, $columnProductDesc TEXT, $columnProductPrice TEXT, $columnProductFavorites INTEGER, $columnProductPhoto TEXT)',
        );
      },
    );

    List<Map> records = await database.rawQuery('SELECT * FROM Product');
    print('records: $records');

    records.forEach((element) {
      products.add(ProductModel.fromMap(element));
    });

    await database.close();
    return products;
  }

  Future<ProductModel> getDetailProduct(int? id) async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, '$databaseName');
    ProductModel productModel = ProductModel();

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Product ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnProductName TEXT, $columnProductDesc TEXT, $columnProductPrice TEXT, $columnProductFavorites INTEGER, $columnProductPhoto TEXT)',
        );
      },
    );

    List<Map> result =
        await database.rawQuery('SELECT * FROM Product WHERE _id=$id');

    result.forEach((element) {
      productModel = ProductModel.fromMap(element);
    });

    await database.close();
    return productModel;
  }

  removeProduct(int id) async {
    var databasePath = await getDatabasesPath();
    String fullPath = join(databasePath, '$databaseName');

    Database database = await openDatabase(
      fullPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Product ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnProductName TEXT, $columnProductDesc TEXT, $columnProductPrice TEXT, $columnProductFavorites INTEGER, $columnProductPhoto TEXT)',
        );
      },
    );

    var count = await database.rawDelete('DELETE FROM Product WHERE _id=$id');
    print(count);

    await database.close();
  }

  Future<int> updateProduct(ProductModel updatedItem) async {
    var databasePath = await getDatabasesPath();
    String fullPath = join(databasePath, '$databaseName');

    Database database = await openDatabase(
      fullPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Product ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnProductName TEXT, $columnProductDesc TEXT, $columnProductPrice TEXT, $columnProductFavorites INTEGER, $columnProductPhoto TEXT)',
        );
      },
    );

    int count = await database.rawUpdate(
      'UPDATE Product SET $columnProductName = ?, $columnProductDesc = ?, $columnProductPrice = ?, $columnProductFavorites = ? WHERE $columnId = ?',
      [
        '${updatedItem.name}',
        '${updatedItem.desc}',
        '${updatedItem.price}',
        updatedItem.isFavorite,
        updatedItem.id,
      ],
    );

    // print(count);
    await database.close();

    return count;
  }
}
