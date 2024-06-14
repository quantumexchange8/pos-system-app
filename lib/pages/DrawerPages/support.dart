import 'package:flutter/material.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/DrawerPages/Items.dart';
import 'package:pos_system/pages/DrawerPages/Receipts.dart';
import 'package:pos_system/pages/DrawerPages/Settings.dart';
import 'package:pos_system/pages/DrawerPages/Shift.dart';
import 'package:pos_system/pages/DrawerPages/apps.dart';
import 'package:pos_system/pages/DrawerPages/backOffice.dart';
import 'package:pos_system/pages/Homepage.dart';
import 'package:pos_system/pages/InsideSupportPages/Legal_Info.dart';
import 'package:pos_system/pages/InsideSupportPages/account.dart';
import 'package:pos_system/pages/InsideSupportPages/help.dart';
import 'package:pos_system/widgets/appDrawer.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  int _selectedIndex = 7;

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
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Apps(),
            ),
          );
          break;
        case 7:
          
          break;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue.shade900,
        title: Text('Support', style: bodyMregular.copyWith(color: Colors.white)),
      ),
       drawer: AppDrawer(selectedIndex: _selectedIndex, onTap: _onItemTapped),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              _ItemsListOnTap(
                Icons.help_outline_outlined, 'Help',(){
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>HelpPage(),
                  ),);
                },
              ),
              _ItemsListOnTap(
                Icons.privacy_tip_outlined, 'Legal information', () { 
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>LegalInfo(),
                  ),);
                },
              ),
              _ItemsListOnTap(
              Icons.account_circle_outlined, 'Account', () { 
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>AccountPage()),
                );
              },
            ),


            ],
            ),
          ),
        );
      }

    Widget _ItemsListOnTap(IconData icon, String title, VoidCallback onTap){
      return Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Icon(icon, size: 20),
                const SizedBox(width: 20),
                Text(title, style: bodySregular),
              ],
            ),
          ),
          
          Divider(
            height: 30,
            color: Colors.grey.shade300, 
            thickness: 1, 
            indent: 40, 
            endIndent: 0,
          ),
        ],
      );
    }
}