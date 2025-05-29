import 'package:flutter/material.dart';
import 'package:noteappwithsqflige/db_helper.dart';
import 'package:noteappwithsqflige/db_provider.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DBProvider(dbHelper: DBHelper.getInstance),
      child: NoteApp(),
    ),
  );
}
