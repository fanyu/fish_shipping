import 'package:flutter/material.dart';

class PlatformTheme {
  static ThemeData iOS = ThemeData(
    primaryColor: Colors.grey[100],
    primarySwatch: Colors.blue,
    primaryColorBrightness: Brightness.light
  );

  static ThemeData android = ThemeData(
    primaryColor: Colors.white,// 主题色
    scaffoldBackgroundColor: Colors.grey[200],//背景色
    accentColor: Colors.deepOrangeAccent, //强调颜色
    secondaryHeaderColor: Colors.white70,// 次标题颜色
    primarySwatch: Colors.purple,
  );
}