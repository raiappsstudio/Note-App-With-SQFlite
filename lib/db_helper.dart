import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();

  ///=======================================
  static final String TABLE_NOTE = "note";
  static final String COLUMN_NOTE_SNO = "s_no";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DESC = "desc";

  Database? myDB;

  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();
      return myDB!;
    }
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDir.path, "noteDB.db");

    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        ///create table-=================
        db.execute(
          "create table $TABLE_NOTE($COLUMN_NOTE_SNO integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text)",
        );
      },
      version: 1,
    );
  }

  ///Data add =========================================================
  Future<bool> addNote({required String mTitle, required String mDesc}) async {
    var db = await getDB();

    int rowsEffecteds = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: mTitle,
      COLUMN_NOTE_DESC: mDesc,
    });
    return rowsEffecteds > 0;
  }

  ///Data query==================================
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();

    List<Map<String, dynamic>> mData = await db.query(TABLE_NOTE);

    return mData;
  }

  ///updateNote==========================================
  Future<bool> updateNote({
    required String title,
    required String desc,
    required int sno,
  }) async {
    var db = await getDB();

    int rowsEffects = await db.update(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: title,
      COLUMN_NOTE_DESC: desc,
    }, where: "$COLUMN_NOTE_SNO = $sno");

    return rowsEffects > 0;
  }

  ///deleteNote==========================================
  Future<bool> deleteNote({required int sno}) async {
    var db = await getDB();

    int rowsEffects = await db.delete(
      TABLE_NOTE,
      where: "$COLUMN_NOTE_SNO = $sno",
    );

    return rowsEffects > 0;
  }
}
