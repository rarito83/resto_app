import 'package:path/path.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class RestoDatabase {
  static RestoDatabase? _restoDatabase;
  static late Database _database;

  RestoDatabase.internal() {
    _restoDatabase = this;
  }

  factory RestoDatabase() => _restoDatabase ?? RestoDatabase.internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static String _favouriteTable = 'favourite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'resto_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_favouriteTable (
               id TEXT PRIMARY KEY,
               name TEXT, 
               description TEXT
               pictureId TEXT, 
               city TEXT,
               rating NUMERIC, 
             )''',
        );
      },
      version: 2,
    );

    return db;
  }

  Future<void> insertFavourite(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_favouriteTable, restaurant.toJson());
    print('Data saved');
  }

  Future<List<Restaurant>> getFavourite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_favouriteTable);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _favouriteTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> deleteRestaurant(String id) async {
    final db = await database;

    await db.delete(
      _favouriteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
