import 'package:flutter/material.dart';
import 'package:noteappwithsqflige/home_page.dart';

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),

    );
  }
}
