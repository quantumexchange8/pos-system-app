import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/CreateItem.dart';
import 'package:pos_system/pages/InsideItemPages/Edit_Item.dart';
import 'package:pos_system/widgets/customDropDownMenu.dart';

class SubItems extends StatefulWidget {
  const SubItems({super.key});

  @override
  State<SubItems> createState() => _SubItemsState();
}

class _SubItemsState extends State<SubItems> {
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: isSearching?
        IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                isSearching = false;
              });
            },
          )
        : null,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: isSearching? TextField(
          autofocus: true,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
            border: InputBorder.none,
          ),
          onChanged: (value){
            //handle search
          },
        )
        :CustomDropdownMenu(
          dropdownMenuEntries: ['All items'],
          initialSelectedItem: 'All items', 
          onChanged: (String selectedItem){
            //Handle dropdown menu item selection
          },
        ),
        
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                isSearching = !isSearching;
              });
            }, 
            icon: isSearching? SizedBox():Icon(Icons.search),
          )
        ],
      ),
       floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=> CreateItem(),
              ),
            );
          },    
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150, width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
              child: Icon(Icons.list, size: 100),
            ),
            const SizedBox(height: 25),
            Text('You have no items yet', style: heading4Regular),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Here you can manage your items.', style: bodySregular),
                TextButton(
                  onPressed: (){}, 
                  child: Text('Learn more', style: bodySregular.copyWith(decoration: TextDecoration.underline),),
                ),
              ],
            ),
        
           
           
            
          ],
        ),
      ),
    );
  }
}