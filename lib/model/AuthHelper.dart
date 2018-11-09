import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:guardiao_mobile/model/Auth.dart';


class AuthHelper {

  static final AuthHelper _instance = new AuthHelper.internal();
  factory AuthHelper() => _instance;

  final String tableAuth = 'auth';
  final String columnId = 'id';
  final String columnToken = 'token';

  static Database _db;

  AuthHelper.internal();

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

    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
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

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableAuth($columnId INTEGER PRIMARY KEY, $columnToken TEXT)');
  }



  Future<Auth> getOnlyOneAuth() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableAuth,
        columns: [columnId, columnToken]);

//  var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
    if (result.length > 0) {
      return new Auth.fromMap(result.first);
    }

    return null;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }


}