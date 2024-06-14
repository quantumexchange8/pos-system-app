import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/CreateItem.dart';
import 'package:pos_system/widgets/customDropDownMenu.dart';
import 'package:pos_system/widgets/itemDataModel.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class SubItems extends StatefulWidget {
  const SubItems({super.key});

  @override
  State<SubItems> createState() => _SubItemsState();
}

class _SubItemsState extends State<SubItems> {
  bool isSearching = false;
  List<Item> items = [];


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
          ): null,
          
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
          onPressed: () async {
            final newItem = await Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=> CreateItem(),
              ),
            );

            if(newItem != null){
              setState(() {
                items.add(newItem);
              });
            }
          },    
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: items.isEmpty? _buildDefaultView(): _buildItemsList(),
    );
  }
  
  Widget _buildDefaultView(){
    return Padding(
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
      );
  }

  Widget _buildItemsList(){
    //List<String> shapes = ['square', 'circle', 'polygon', 'star'];
    /* List<Shape>shape = [
    RoundRectShape(borderRadius: BorderRadius.circular(0)),
    CircleShape(),
    PolygonShape(numberOfSides: 8),
    StarShape(noOfPoints: 5),
    ];  */

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index){
      final item = items[index];
      
      //Shape shape;
      //method to make user choose the shape 

        return ListTile(
          //leading: 
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
  // Remove 'Color(' prefix and ')' suffix
  if (colorString.startsWith('Color(')) {
    colorString = colorString.substring(6, colorString.length - 1);
  }

  // Ensure the string starts with '0xff'
  if (!colorString.startsWith('0xff')) {
    colorString = '0xff' + colorString;
  }

  return Color(int.parse(colorString));
}





}