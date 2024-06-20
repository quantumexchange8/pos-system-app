import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_system/const/itemProvider.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/CreateItem.dart';
import 'package:pos_system/pages/InsideItemPages/Edit_Item.dart';
import 'package:pos_system/widgets/customDropDownMenu.dart';
import 'package:pos_system/widgets/itemDataModel.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class SubItems extends StatefulWidget {
  const SubItems({Key? key}) : super(key: key);

  @override
  State<SubItems> createState() => _SubItemsState();
}

class _SubItemsState extends State<SubItems> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: isSearching
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    isSearching = false;
                  });
                },
              )
            : null,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: isSearching
            ? TextField(
                autofocus: true,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle:
                      TextStyle(color: Colors.white.withOpacity(0.3)),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  // handle search
                },
              )
            : CustomDropdownMenu(
                dropdownMenuEntries: ['All items'],
                initialSelectedItem: 'All items',
                onChanged: (String selectedItem) {
                  // Handle dropdown menu item selection
                },
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
            icon: isSearching ? SizedBox() : Icon(Icons.search),
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
            MaterialPageRoute(builder: (context) => CreateItem()),
          );

          if (newItem != null) {
            Provider.of<ItemProvider>(context, listen: false)
                .addItem(newItem);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, _) {
          if (itemProvider.items.isEmpty) {
            return _buildDefaultView();
          } else {
            return _buildItemsList(itemProvider.items);
          }
        },
      ),
    );
  }

  Widget _buildDefaultView() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
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
                onPressed: () {},
                child: Text(
                  'Learn more',
                  style: bodySregular.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(List<Item> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (item.imagePath != null)
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
                          Text(
                            (item.stock.isEmpty || item.stock == '0')
                                ? '-'
                                : '${item.stock} in stock',
                            style: bodyXSregular,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    item.price.isNotEmpty ? item.price : 'Variable',
                    style: bodySregular,
                  ),
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
          onTap: () async {
            // handle edit method
            final updatedItem = await 
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context)=>EditItem(item:item),
              ),
            );
            if(updatedItem !=null ){
              Provider.of<ItemProvider>(context,listen: false).updateItem(item, updatedItem);
            }
          },
        );
      },
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



  /* Color _convertColor(String colorString) {
  // Remove 'Color(' prefix and ')' suffix
  if (colorString.startsWith('Color(')) {
    colorString = colorString.substring(6, colorString.length - 1);
  }

  // Ensure the string starts with '0x' or '0xFF'
  if (!colorString.startsWith('0x') && !colorString.startsWith('0xFF')) {
    colorString = '0xFF' + colorString;
  }

  // Parse the color string to an integer and return Color object
  return Color(int.parse(colorString));
} */

 
   /* Color _convertColor(String colorString) {
    // Remove 'Color(' prefix and ')' suffix
    if (colorString.startsWith('Color(')) {
      colorString = colorString.substring(6, colorString.length - 1);
    }

    // Ensure the string starts with '0xff'
    if (!colorString.startsWith('0xff')) {
      colorString = '0xff' + colorString;
    }

    return Color(int.parse(colorString));
  } */
}
