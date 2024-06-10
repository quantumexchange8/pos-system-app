import 'package:flutter/material.dart';
import 'package:pos_system/pages/OnBoardingPage.dart';
import 'package:pos_system/themes/theme.dart';
import 'package:pos_system/themes/themes_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Loyverse system',
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeProvider.themeMode,
      home: const OnBoardingPage(),
    );
  }
}

