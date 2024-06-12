import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/AssignItem.dart';
import 'package:pos_system/pages/InsideItemPages/CreateItem.dart';
import 'package:pos_system/pages/InsideItemPages/SubCategoriesPage.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
 TextEditingController CtgyNameController = TextEditingController();
  Color _selectedColor = Colors.grey.shade400;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('Edit category', style: heading3Regular.copyWith(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: (){
              //need to handle save function, havent done
              
                /* setState(() {
                  _validateName = CtgyNameController.text.isEmpty;
                });
                
                if(!_validateName) {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=>SubItems(),),
                  );
                } */
            }, 
            child: Text('SAVE', style: bodySregular.copyWith(color: Colors.white)),
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            color: Colors.grey.shade200,
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
                      //errorText: _validateName? 'This field cannot be blank' : null,
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
          const SizedBox(height: 15),
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
      
                              //delete Item function
      
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context)=> SubCategories(),
                                ),
                              );
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
}