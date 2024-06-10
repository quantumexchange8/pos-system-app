
import 'package:flutter/material.dart';
import 'package:pos_system/const/constant.dart';


ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white)
  ),
  colorScheme: ColorScheme.light(
    primary: primaryBlue.shade900,
    secondary: Colors.black,
    tertiary: primaryBlue.shade900,
    background: Colors.white,
    
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.white,
    secondary: Colors.white,
    tertiary: Colors.black,
    background: Colors.black,
    
  ),
);