import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {

  static final DBHelper _instance = new DBHelper.internal();
  factory DBHelper() => _instance;

  static Database _db;

  DBHelper.internal();

  Future<Database> get db async {
    if (_db != null && _db.isOpen) {
      return _db;
    }

    if (_db != null && !_db.isOpen) {
      _db = await openConnection();
      return _db;
    }

    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'guardiao-mobile.db');
    print("-------------PATH DB: $path");
    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('CREATE TABLE auth(id INTEGER PRIMARY KEY, token TEXT)');
  }

  testConnection() async{
    var dbClient = await db;
    if(dbClient.isOpen){
      return true;
    }else{
      return false;
    }
  }

  openConnection() async{
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'guardiao-mobile.db');
    var db = await openDatabase(path, version: 1);
    return db;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

}