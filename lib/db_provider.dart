import 'package:flutter/cupertino.dart';
import 'package:noteappwithsqflige/db_helper.dart';

class DBProvider extends ChangeNotifier {
  DBHelper dbHelper;

  DBProvider({required this.dbHelper});

  List<Map<String, dynamic>> _mDate = [];

  List<Map<String, dynamic>> get AllNotes => _mDate;

  // add Note==============================
  Future<bool> addNote(String title, String desc) async {
    bool check = await dbHelper.addNote(mTitle: title, mDesc: desc);
    if (check) {
      _mDate = await dbHelper.getAllNotes();
      notifyListeners();
    }

    return check;
  }

  // Update Note==============================================
  Future<bool> updateNote(String title, String desc, int sno) async {
    bool check = await dbHelper.updateNote( sno: sno, title: title, desc: desc);
    if (check) {
      _mDate = await dbHelper.getAllNotes();
      notifyListeners();
    }
    return check;
  }

  // Update Note==============================================
  Future<bool> deleteNote(int sno) async {
    bool check = await dbHelper.deleteNote( sno: sno);
    if (check) {
      _mDate = await dbHelper.getAllNotes();
      notifyListeners();
    }
    return check;
  }




  void getIntrialNotes() async {
    _mDate = await dbHelper.getAllNotes();
    notifyListeners();
  }
}
