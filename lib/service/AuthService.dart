import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:guardiao_mobile/model/Auth.dart';
import 'package:guardiao_mobile/db/DBHelper.dart';


class AuthService{

  DBHelper dbHelper               = new DBHelper();
  final String tableAuth          = 'auth';
  final String columnId           = 'id';
  final String columnToken        = 'token';

  Future<int> saveAuth(Auth auth) async {
    var dbClient = await dbHelper.db;
    var result = await dbClient.insert(tableAuth, auth.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');
    return result;
  }

  Future<Auth> getOnlyOneAuth() async {
    var dbClient = await dbHelper.db;
    List<Map> result = await dbClient.query(tableAuth, columns: [columnId, columnToken]);

//  var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
    if (result.length > 0) {
      return new Auth.fromMap(result.first);
    }

    return null;
  }

  Future<List> getAllNotes() async {
    var dbClient = await dbHelper.db;
    var result = await dbClient.query(tableAuth, columns: [columnId, columnToken]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');
    return result.toList();
  }

}