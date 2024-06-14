import 'package:flutter/material.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/DrawerPages/Items.dart';
import 'package:pos_system/pages/DrawerPages/Receipts.dart';
import 'package:pos_system/pages/DrawerPages/Settings.dart';
import 'package:pos_system/pages/DrawerPages/Shift.dart';
import 'package:pos_system/pages/DrawerPages/backOffice.dart';
import 'package:pos_system/pages/DrawerPages/support.dart';
import 'package:pos_system/pages/Homepage.dart';
import 'package:pos_system/widgets/appDrawer.dart';

class Apps extends StatefulWidget {
  const Apps({super.key});

  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  int _selectedIndex = 6;

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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Items(),
            ),
          );
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
              builder: (context) => const BackOffice(),
            ),
          );
          break;
        case 6:
           
          break;
        case 7:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Support(),
            ),
          );
          break;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue.shade900,
        title: Text('Apps', style: bodyMregular.copyWith(color: Colors.white)),
      ),
       drawer: AppDrawer(selectedIndex: _selectedIndex, onTap: _onItemTapped),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('List of related apps')),
        ],
      ),
    );
  }
}