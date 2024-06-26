import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/AssignItem.dart';
import 'package:pos_system/pages/InsideItemPages/CreateItem.dart';
import 'package:pos_system/widgets/dataModel/categoryDataModel.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  TextEditingController CtgyNameController = TextEditingController();
  Color _selectedColor = Color(0xffe0e0e0);
  bool _validateName = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('Create category', style: heading3Regular.copyWith(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: (){
              //need to handle save function
              
                 setState(() {
                  _validateName = CtgyNameController.text.isEmpty;
                });
                
                if(!_validateName) {
                DataCategory newCategory = DataCategory(
                  color: _selectedColor.toString(), 
                  name: CtgyNameController.text,
                );
                Navigator.pop(context,newCategory);
                  /* Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=>SubCategories(),),
                  ); */
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
          
        ],
      ),


    );
  }

  Widget _buildColorSelection(){
    List<Color>colors = [
      Color(0xffe0e0e0),
      Color(0xffff2626),
      Color(0xffff0094),
      Color(0xffffa146),
      Color(0xffefdd60),
      Color(0xff71d200),
      Color(0xff4e9bff),
      Color(0xffc11bff),
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