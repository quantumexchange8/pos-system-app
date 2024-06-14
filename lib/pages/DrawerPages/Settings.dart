import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/DrawerPages/Items.dart';
import 'package:pos_system/pages/DrawerPages/Receipts.dart';
import 'package:pos_system/pages/DrawerPages/Shift.dart';
import 'package:pos_system/pages/DrawerPages/apps.dart';
import 'package:pos_system/pages/DrawerPages/backOffice.dart';
import 'package:pos_system/pages/DrawerPages/support.dart';
import 'package:pos_system/pages/Homepage.dart';
import 'package:pos_system/pages/InsideSettingsPages/general.dart';
import 'package:pos_system/pages/InsideSettingsPages/printers.dart';
import 'package:pos_system/pages/InsideSettingsPages/taxes.dart';
import 'package:pos_system/pages/OnBoardingPage.dart';
import 'package:pos_system/widgets/appDrawer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedIndex = 4;

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
        title: Text('Settings', style: bodyMregular.copyWith(color: Colors.white)),
      ),
      drawer: AppDrawer(selectedIndex: _selectedIndex, onTap: _onItemTapped),

      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              _ItemsListOnTap(
                Icons.print, 'Printers',(){
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>PrintersPage(),
                  ),);
                },
              ),
              _ItemsListOnTap(
                Icons.percent, 'Taxes', () { 
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>TaxesPage(),
                  ),);
                },
              ),
              _ItemsListOnTap(
              Icons.settings, 'General', () { 
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>GeneralPage()),
                );
              },
            ),

            const Spacer(),
            //the sign in email display
            Text('example@email.com', style: bodySregular),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: BlueOutlineButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, 
                      MaterialPageRoute(
                        builder: (context)=>OnBoardingPage(),
                        ),
                      );
                    }, 
                    text: 'SIGN OUT'
                  ),
                ),
              ],
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