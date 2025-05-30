import 'package:flutter/material.dart';
import 'package:noteappwithsqflige/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting')),

      body: Consumer<ThemeProvider>(builder: (ctx,provider,_){

        return SwitchListTile.adaptive(
          title: Text('Dark Mode',style: TextStyle(fontSize: 24),),
          subtitle: Text("Change Theme Mode here"),
          onChanged: (value) {

            provider.updateTheme(value: value);

          },
          value: provider.getThemeValu(),
        );

      })
    );
  }
}

bool isDarkMode = false;
