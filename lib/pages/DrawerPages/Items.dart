import 'package:flutter/material.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/DrawerPages/Receipts.dart';
import 'package:pos_system/pages/DrawerPages/Settings.dart';
import 'package:pos_system/pages/DrawerPages/Shift.dart';
import 'package:pos_system/pages/Homepage.dart';
import 'package:pos_system/widgets/appDrawer.dart';

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    Navigator.pop(context);
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      // Navigate to the appropriate page
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Receipts(),
            ),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Shift(),
            ),
          );
          break;
        case 3:
          
          break;
        case 4:
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Settings(),
            ),
          );
          break;
        case 5:
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Settings(),
            ),
          );
          break;
        // Add more cases if needed
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue.shade900,
        title: Text('Items', style: bodyMregular.copyWith(color: Colors.white)),
      ),
      drawer: AppDrawer(selectedIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}