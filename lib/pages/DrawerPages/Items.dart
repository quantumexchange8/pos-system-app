import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/DrawerPages/Receipts.dart';
import 'package:pos_system/pages/DrawerPages/Settings.dart';
import 'package:pos_system/pages/DrawerPages/Shift.dart';
import 'package:pos_system/pages/DrawerPages/apps.dart';
import 'package:pos_system/pages/DrawerPages/backOffice.dart';
import 'package:pos_system/pages/DrawerPages/support.dart';
import 'package:pos_system/pages/Homepage.dart';
import 'package:pos_system/pages/InsideItemPages/SubCategoriesPage.dart';
import 'package:pos_system/pages/InsideItemPages/SubDiscountsPage.dart';
import 'package:pos_system/pages/InsideItemPages/SubItemPage.dart';
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
        title: Text('Items', style: bodyMregular.copyWith(color: Colors.white)),
      ),
      drawer: AppDrawer(selectedIndex: _selectedIndex, onTap: _onItemTapped),


      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            _ItemsListOnTap(
              Icons.list, 'Items',(){
                Navigator.push(context, 
                MaterialPageRoute(builder: (context)=>SubItems(),
                ),);
              },
            ),
            _ItemsListOnTap(
              Icons.filter_none_outlined, 'Categories', () { 
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>SubCategories(),
                ),);
              },
            ),
            _ItemsListOnTap(
            Icons.sell_outlined, 'Discounts', () { 
              Navigator.push(context, 
                MaterialPageRoute(builder: (context)=>SubDiscounts()),
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
            SizedBox(
            height: 40,
            child: ListTile(
              onTap: onTap,
              leading: Icon(icon, size: 20),
              title: Text(title, style: bodySregular),
              contentPadding: const EdgeInsets.symmetric(horizontal: 1),
            ),
          ),
           
            Divider(
              color: Colors.grey.shade300, 
              thickness: 1, 
              indent: 40, 
              endIndent: 0,
            ),
          ],
        );
}

}