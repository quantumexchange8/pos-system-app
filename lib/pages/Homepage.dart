import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/DrawerPages/Items.dart';
import 'package:pos_system/pages/DrawerPages/Receipts.dart';
import 'package:pos_system/pages/DrawerPages/Settings.dart';
import 'package:pos_system/pages/DrawerPages/Shift.dart';
import 'package:pos_system/widgets/appDrawer.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
              builder: (context) => const Settings(),
            ),
          );
          break;
        // Add more cases if needed
      }
    }
  }

  List<bool> isSelected = [true,false];
  double chargeAmount = 0.00;
  String dropdownValue = "All items";
  bool isSearching = false;

  Widget _buildContent() {
    if (isSearching) {
      return _SearchContent();
    }

    switch (dropdownValue) {
      case "All items":
        return _AllItemsContent();
      case "Discounts":
        return _DiscountsContent();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        
        backgroundColor: primaryBlue.shade900,
        title: Row(
          children: [
            Text('Ticket', style: bodyMregular.copyWith(color: Colors.white)),
            const SizedBox(width:10),
            const Icon(Icons.receipt, color: Colors.white),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.person_add, color: Colors.white),
          ),
          PopupMenuButton<String>(
           icon: const Icon(
              Icons.more_vert,
              color: Colors.white, // Set the color of the popup menu icon
            ),
            onSelected: (String value){
              //action
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
            } 
            
          ),
        ],
         
        
      ),
      drawer: AppDrawer(selectedIndex: _selectedIndex, onTap: _onItemTapped),

      //start ticket page (toggle buttons)
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
                    isSelected: isSelected,
                    onPressed: (int index) {
                      isSelected[index] = !isSelected[index];
                      // Add logic here to update chargeAmount if needed
                    },
                    color: Colors.white, // Default color
                    selectedColor: Colors.white, // Color when selected
                    fillColor: Colors.transparent, // Background color when selected
                   
                    borderWidth: 2,
                    children: [
                      Container(
                        width: 165,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primaryBlue.shade300
                        ),
                        child: Text('OPEN TICKETS', style: bodySregular),
                      ),
                      Container(
                        width:165,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primaryBlue.shade300
                        ),
                        child: Text('CHARGE \n RM${chargeAmount.toStringAsFixed(2)}', style: bodySregular),
                      ),  //the number always update
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
                flex: isSearching? 6:6,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey.shade200,
                    border: isSearching?
                    Border(
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
                  child: isSearching? 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                      onChanged: (value){
                        //handle search
                      },
                    ),
                  ):
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DropdownButton<String>(
                        value: dropdownValue,
                        items: <String>["All items", "Discounts"]
                        .map<DropdownMenuItem<String>>((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            );
                        }).toList(), 
                        onChanged: (String? newValue){
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                  ),
                ),
              ),
              Expanded(
                flex: isSearching? 1:1,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.rectangle,
                    border: isSearching? 
                    Border(
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
                    icon: isSearching? Icon(Icons.close):Icon(Icons.search),
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
              color: Colors.grey.shade100,
              child: _buildContent(),
            ),
            
          ),
        ],
      ),


    );
  }

  PopupMenuEntry<String> _popUpItem (String value, IconData icon, String title){
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 15),
          Text(title),
        ],
      )
    );
  }
}

class _AllItemsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(//if there is no item
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.schedule, size: 100),
          Text('Shift is closed', style: heading4Regular),
          const SizedBox(height: 5),
          Text('Open a shift to perform sales', style: bodySregular),
          const SizedBox(height: 15),
          BlueButton(
            onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context)=>const Shift(),),
              );
            }, 
            text: 'OPEN SHIFT'),
        ],
      ),
    );
  }
}

class _DiscountsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center( //if no discounts
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You have no discounts yet', style: heading4Regular),
          const SizedBox(height: 5),
          Text('Go to items menu to add a discount', style: bodySregular),
          const SizedBox(height: 15),
          BlueButton(
            onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context)=>const Items(),),
              );
            }, 
            text: 'GO TO ITEMS'),
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

