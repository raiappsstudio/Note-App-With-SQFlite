import 'package:flutter/material.dart';
import 'package:noteappwithsqflige/home_page.dart';
import 'package:noteappwithsqflige/theme_provider.dart';
import 'package:provider/provider.dart';

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode:
          context.watch<ThemeProvider>().getThemeValu()
              ? ThemeMode.dark
              : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
