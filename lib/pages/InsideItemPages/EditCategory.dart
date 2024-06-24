import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/controller/categoryProvider.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/AssignItem.dart';
import 'package:pos_system/pages/InsideItemPages/CreateItem.dart';
import 'package:pos_system/pages/InsideItemPages/SubCategoriesPage.dart';
import 'package:pos_system/widgets/dataModel/categoryDataModel.dart';
import 'package:provider/provider.dart';

class EditCategory extends StatefulWidget {
  final DataCategory dataCategory;

  EditCategory({Key? key, required this.dataCategory}):super(key: key);

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  late TextEditingController CtgyNameController;
  late Color _selectedColor;

  bool _validateName = false;

  @override
  void initState(){
    CtgyNameController = TextEditingController(text: widget.dataCategory.name);
    _selectedColor = _convertColor(widget.dataCategory.color);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('Edit category', style: heading3Regular.copyWith(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: (){
              //need to handle save function
                 setState(() {
                  _validateName = CtgyNameController.text.isEmpty;
                });
                
                if(!_validateName) {
                  DataCategory updatedCategory = DataCategory(
                    name: CtgyNameController.text, 
                    color: '#${_selectedColor.value.toRadixString(16).padLeft(8,'0')}',
                  );
                  final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
                  categoryProvider.updateCategory(widget.dataCategory, updatedCategory);
                  Navigator.pop(context, updatedCategory);
                } 
            }, 
            child: Text('SAVE', style: bodySregular.copyWith(color: Colors.white)),
          ),
        ],
      ),

      body: Column(
        children: [
          
          Container(
            //color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: CtgyNameController,
                    decoration: InputDecoration(
                      labelText: 'Category name',
                      labelStyle: heading4Regular,
                      contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                      errorText: _validateName? 'This field cannot be blank' : null,
                    ),
                  ),
              
                  const SizedBox(height: 40),
              
                  Text('Category color', 
                    style: bodySregular.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 10),
                  _buildColorSelection(),
                  Divider(thickness: 1, color: Colors.white),
              
                  Row(
                    children: [
                      Expanded(
                        child: BlueOutlineButton(
                          onPressed: (){
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context)=>AssignItem(),),
                            );
                          }, 
                          text: 'ASSIGN ITEMS',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: BlueOutlineButton(
                          onPressed: (){
                            //add category into the list, the function

                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context)=>CreateItem(),),
                            );
                          }, 
                          text: 'CREATE ITEM',
                        ),
                      ),
                    ],
                  ),
              
                 
              
                ],
              ),
            ),
          ),
        
           Container(
            height: 40,
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Expanded(
                  child: FilledButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                      iconColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.secondary),
                      
                    ),
                    onPressed: (){
                      showDialog(
                      context: context, 
                      builder: (context)=> AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.background,
                        title: Text('Delete category', style: heading3Bold),
                        content: Text('Are you sure you want to delete the category?',style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),),
            
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                              
                            child: Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: (){
                              //delete function
                              final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
                              categoryProvider.removeCategory(widget.dataCategory);
                              Navigator.pop(context);
                              Navigator.pop(context); 
                            }, 
                            child: const Text('DELETE'),
                          ),
                        ],
                      )
                    );
                    }, 
                    icon: Icon(Icons.delete), 
                    label: Text('DELETE CATEGORY', style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),


    );
  }

  Widget _buildColorSelection(){
    List<Color>colors = [
      Colors.grey.shade400,
      Colors.red,
      Color(0xffff0094),
      Color(0xffffa146),
      Color(0xffefdd60),
      Colors.green,
      Colors.blue,
      Colors.purple,
    ];
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        height: 200,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
          ), 
          itemCount: colors.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = colors[index];
                });
                //_showColorPicker(context, colors[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: colors[index],
                  border: _selectedColor == colors[index]?
                    Border.all(color: Colors.transparent, width: 2):null,
                ),
                child: _selectedColor == colors[index]? 
                  Icon(Icons.check, color: Colors.white, size: 35): null,
              ),
            );
          })
        ),
      ),
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
}