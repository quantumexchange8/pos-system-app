import 'package:flutter/material.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/DrawerPages/Items.dart';
import 'package:pos_system/pages/DrawerPages/Settings.dart';
import 'package:pos_system/pages/DrawerPages/Shift.dart';
import 'package:pos_system/pages/Homepage.dart';
import 'package:pos_system/widgets/appDrawer.dart';

class Receipts extends StatefulWidget {
  const Receipts({super.key});

  @override
  State<Receipts> createState() => _ReceiptsState();
}

class _ReceiptsState extends State<Receipts> {
  int _selectedIndex = 1;
  bool isSearching = false;
  TextEditingController _searchController = TextEditingController();
  
  @override
  void dispose(){
    _searchController.dispose();
    
    super.dispose();
  }

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
      //resizeToAvoidBottomInset: false,
      onDrawerChanged: (isOpened) {
        FocusScope.of(context).unfocus();
      },
      appBar: AppBar(
        backgroundColor: primaryBlue.shade900,
        title: Text('Receipts', style: bodyMregular.copyWith(color: Colors.white)),
      ),
      drawer: AppDrawer(selectedIndex: _selectedIndex, onTap: _onItemTapped),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey.shade200,
                    border: 
                    Border(
                      bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                  ),
                  child: const Icon(Icons.search),
                ),
              ),

              Expanded(
                flex: 6,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey.shade200,
                    border: 
                    Border(
                      bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                  ),
                  child: //isSearching?
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none
                    ),
                    onTap: (){
                      setState(() {
                        isSearching = true;
                      });
                    },
                    onChanged: (value){
                       
                    },
                     
                  )
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                   height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey.shade200,
                    border: 
                    Border(
                      bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                  ),
                  child: IconButton(
                    icon: isSearching? const Icon(Icons.close):const SizedBox(), 
                    onPressed: () { 
                      setState(() {
                        isSearching = false;
                        _searchController.clear();
                        FocusScope.of(context).unfocus();
                      });
                     },
                     
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.receipt,size: 100),
                Text('You have no receipts yet', style: bodySregular),
              ],
            ),
          ),
        ],
      ),


    );
  }
}