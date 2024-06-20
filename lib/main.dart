import 'package:flutter/material.dart';
import 'package:pos_system/const/categoryProvider.dart';
import 'package:pos_system/const/itemProvider.dart';
import 'package:pos_system/const/shiftController.dart';
import 'package:pos_system/pages/OnBoardingPage.dart';
import 'package:pos_system/receiptPrint/completeReceipt.dart';
import 'package:pos_system/themes/theme.dart';
import 'package:pos_system/themes/themes_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        ChangeNotifierProvider(create:(_)=>CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Provide ThemeProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // Use Provider.of<ThemeProvider> here to access the themeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => ShiftState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Loyverse system',
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: themeProvider.themeMode,
        home: const OnBoardingPage(), //CompleteReceipt()
      ),
    );
  }
}
