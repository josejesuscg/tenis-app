import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tenis_app/feature/reservation/domain/models/reservation_model.dart';

class DatabaseProvider {
  static const String tableName = 'reservations';

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  late Database _database;

  Future<Database> get database async {
    if (_database.isOpen) {
      return _database;
    } else {
      return await initDB();
    }
  }

  Future<Database> initDB() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'reservations.db');
    _database = await openDatabase(path, version: 5, onCreate: _createDB);
    return _database;
  }

void _createDB(Database db, int version) async {
  await db.execute('''
    CREATE TABLE $tableName(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      date TEXT,
      user TEXT,
      imageUrl TEXT,
      price TEXT,
      instructor TEXT,
      time INTEGER
    )
  ''');
}




  Future<int> addReservation(Reservation reservation) async {
    final db = await database;
    return await db.insert(tableName, reservation.toMap());
  }

  Future<List<Reservation>> getReservations() async {
    final db = await database;
    var res = await db.query(tableName);
    return res.isNotEmpty ? res.map((c) => Reservation.fromMap(c)).toList() : [];
  }

  Future<int> deleteReservation(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
