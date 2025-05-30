import 'package:flutter/material.dart';
import 'package:noteappwithsqflige/db_helper.dart';
import 'package:noteappwithsqflige/db_provider.dart';
import 'package:noteappwithsqflige/theme_provider.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => DBProvider(dbHelper: DBHelper.getInstance)),
        ChangeNotifierProvider(create:(context) => ThemeProvider()),
      ],
  child: NoteApp(),
    ),
  );
}
