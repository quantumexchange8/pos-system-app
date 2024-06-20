import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/itemProvider.dart';
import 'package:pos_system/const/shiftController.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/DrawerPages/Items.dart';
import 'package:pos_system/pages/DrawerPages/Receipts.dart';
import 'package:pos_system/pages/DrawerPages/Settings.dart';
import 'package:pos_system/pages/DrawerPages/Shift.dart';
import 'package:pos_system/pages/DrawerPages/apps.dart';
import 'package:pos_system/pages/DrawerPages/backOffice.dart';
import 'package:pos_system/pages/DrawerPages/support.dart';
import 'package:pos_system/widgets/appDrawer.dart';
import 'package:pos_system/widgets/itemDataModel.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

bool isShiftOpen = true;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isSearching = false;
  String dropdownValue = "All items";

  void _onItemTapped(int index) {
    Navigator.pop(context);
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      // Navigate to the appropriate page
      switch (index) {
        case 0:
          // Stay on the HomePage
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

  Widget _buildContent(bool isShiftOpen) {
    if (isSearching) {
      return _SearchContent();
    }

    switch (dropdownValue) {
      case "All items":
        return _AllItemsContent(isShiftOpen: isShiftOpen);
      case "Discounts":
        return _DiscountsContent();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final shiftState = Provider.of<ShiftState>(context);
    //var shiftStatus = Provider.of<ShiftStatus>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryBlue.shade900,
        title: Row(
          children: [
            Text('Ticket', style: bodyMregular.copyWith(color: Colors.white)),
            const SizedBox(width: 10),
            const Icon(Icons.receipt, color: Colors.white),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.person_add, color: Colors.white),
          ),
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white, // Set the color of the popup menu icon
            ),
            onSelected: (String value) {
              // action
            },
            itemBuilder: (BuildContext context) {
              return [
                _popUpItem('Option 1', Icons.delete, 'Clear ticket'),
                _popUpItem('Option 2', Icons.edit, 'Edit ticket'),
                _popUpItem('Option 3', Icons.contact_mail, 'Assign ticket'),
                _popUpItem('Option 4', Icons.call_merge, 'Merge ticket'),
                _popUpItem('Option 5', Icons.call_split, 'Split ticket'),
                _popUpItem('Option 6', Icons.sync, 'Sync'),
              ];
            },
          ),
        ],
      ),
      drawer: AppDrawer(selectedIndex: _selectedIndex, onTap: _onItemTapped),
      // Start ticket page (toggle buttons)
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ToggleButtons(
                    isSelected: [true, false],
                    onPressed: (int index) {
                      setState(() {
                        isShiftOpen = !isShiftOpen; // Toggle the shift state
                      });
                    },
                    color: Colors.white, // Default color
                    selectedColor: Colors.white, // Color when selected
                    fillColor: Colors.transparent, // Background color when selected
                    borderRadius: BorderRadius.circular(5),
                    borderWidth: 2,
                    children: [
                      Container(
                        width: 165,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: primaryBlue.shade300),
                        child: Text('OPEN TICKETS', style: bodySregular),
                      ),
                      Container(
                        width: 165,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: primaryBlue.shade300),
                        child: Text('CHARGE \n RM0.00', style: bodySregular),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: isSearching ? 6 : 6,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).colorScheme.background,
                    border: isSearching
                        ? Border(
                            top: BorderSide(color: Colors.grey.shade400, width: 1),
                            bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                          )
                        : Border(
                            top: BorderSide(color: Colors.grey.shade400, width: 1),
                            left: BorderSide(color: Colors.grey.shade400, width: 1),
                            right: BorderSide(color: Colors.grey.shade400, width: 1),
                            bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                          ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: isSearching
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              // handle search
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            items: <String>["All items", "Discounts"]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                          ),
                        ),
                ),
              ),
              Expanded(
                flex: isSearching ? 1 : 1,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    shape: BoxShape.rectangle,
                    border: isSearching
                        ? Border(
                            top: BorderSide(color: Colors.grey.shade400, width: 1),
                            bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                          )
                        : Border(
                            top: BorderSide(color: Colors.grey.shade400, width: 1),
                            left: BorderSide(color: Colors.grey.shade400, width: 1),
                            right: BorderSide(color: Colors.grey.shade400, width: 1),
                            bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                          ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: IconButton(
                    icon: isSearching ? Icon(Icons.close) : Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        isSearching = !isSearching; // Toggle the search state
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Consumer<ShiftState>(
                builder: (context,shiftState,_){
                  return _buildContent(shiftState.isShiftOpen??false);
                },
                
                ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuEntry<String> _popUpItem(String value, IconData icon, String title) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 15),
          Text(title),
          // need to action
        ],
      ),
    );
  }
}

class _AllItemsContent extends StatelessWidget {
  final bool isShiftOpen;

  const _AllItemsContent({required this.isShiftOpen});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isShiftOpen ? _buildShiftOpenedContent(context) : _buildShiftClosedContent(context),
    );
  }
}

Widget _buildShiftClosedContent(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.schedule, size: 100),
      Text('Shift is closed', style: heading4Regular),
      const SizedBox(height: 5),
      Text('Open a shift to perform sales', style: bodySregular),
      const SizedBox(height: 15),
      BlueButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Shift(),
            ),
          );
        },
        text: 'OPEN SHIFT',
      ),
    ],
  );
}

Widget _buildShiftOpenedContent(BuildContext context) {
  final itemProvider = Provider.of<ItemProvider>(context);
  if ( itemProvider.items.isEmpty) {
    return  _buildNoItemView(context);
  } else {
    return _buildItemsList(itemProvider.items);
  }
   
}

Widget _buildNoItemView(BuildContext context){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('You have no items yet', style: heading4Regular),
      const SizedBox(height: 5),
      Text('Here you can manage your items.', style: bodySregular),
      const SizedBox(height: 15),
      BlueButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Items(),
            ),
          );
        },
        text: 'GO TO ITEMS',
      )
    ],
  );
}

Widget _buildItemsList(List<Item>items){
    
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index){
      final item = items[index];
      
      //Shape shape;
      //method to make user choose the shape 

        return ListTile(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if(item.imagePath!=null)
                        Image.file(
                          File(item.imagePath!),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        )
                        else
                          ShapeOfView(
                            shape: item.shape,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                              color: _convertColor(item.color),
                              ),
                            ),
                          ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name, style: bodySregular),
                          Text((item.stock.isEmpty||item.stock =='0')? '-': '${item.stock} in stock', style: bodyXSregular),
                        ],
                      ),
                    ],
                  ),
                  
                  Text(item.price.isNotEmpty? item.price: 'Variable',style: bodySregular),
                ],
              ),
              Divider(
                height: 30,
                color: Colors.grey.shade300, 
                thickness: 1, 
                indent: 40, 
                endIndent: 0,
              ),
            ],
          ),
          
          onTap: (){
            //handle edit method
          },
          

        );
      }
    );
  }

 Color _convertColor(String colorString) {
  // Remove 'Color(' prefix and ')' suffix if present
  if (colorString.startsWith('Color(')) {
    colorString = colorString.substring(6, colorString.length - 1);
  }

  // Remove any '#' characters
  colorString = colorString.replaceAll('#', '');

  // Ensure the string starts with '0x' or '0xFF'
  if (!colorString.startsWith('0x')) {
    colorString = '0xFF' + colorString;
  } else if (colorString.length == 8) {
    colorString = '0xFF' + colorString.substring(2);
  }

  // Parse the color string to an integer and return Color object
  //return Color(int.parse(colorString));
  return Color(int.parse(colorString));
}

class _DiscountsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You have no discounts yet', style: heading4Regular),
          const SizedBox(height: 5),
          Text('Go to items menu to add a discount', style: bodySregular),
          const SizedBox(height: 15),
          BlueButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Items(),
                ),
              );
            },
            text: 'GO TO ITEMS',
          ),
        ],
      ),
    );
  }
}

class _SearchContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search results will appear here.', style: bodySregular),
    );
  }
}
