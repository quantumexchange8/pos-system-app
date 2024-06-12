import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/CreateCategory.dart';
import 'package:pos_system/pages/InsideItemPages/SubItemPage.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

enum soldBy {Each, Weight}
enum design {Color_and_shape, Image}

class EditItem extends StatefulWidget {
  const EditItem({super.key});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController costController = TextEditingController(text: 'RM0.00');
  TextEditingController skuController = TextEditingController(text: '10000');
  TextEditingController barcodeController = TextEditingController();
  TextEditingController stockController = TextEditingController(text: '0');
  bool _validateName = false;
  String? _selectedCategory = 'No category';
  soldBy? _by = soldBy.Each;
  design? _design = design.Color_and_shape;
  Color _selectedColor = Colors.grey.shade400;
  String _selectedShape = 'square';
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source) async{
    try{
      final pickedFile = await _picker.pickImage(source: source);
      if(pickedFile == null) return;

      setState(() {
        _image = File(pickedFile.path);
      });
    }catch(e){
      print('Error: $e');
    }
    /* final image = await ImagePicker().pickImage(source: source);
    if(image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    }); */
  }

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter.currency(
      symbol: 'RM',
      decimalDigits: 2,
    );

  final Map<String, bool> _switchStates = {
    'Track stock':false,
  };



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('Edit item', style: heading3Regular.copyWith(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: (){
              //need to handle save function, havent done
              
                setState(() {
                  _validateName = nameController.text.isEmpty;
                });
                
                if(!_validateName) {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=>SubItems(),),
                  );
                }
            }, 
            child: Text('SAVE', style: bodySregular.copyWith(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: heading4Regular,
                          contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                          errorText: _validateName? 'This field cannot be blank' : null,
                        ),
                      ),
              
                    const SizedBox(height: 25),
              
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      style: TextStyle(color: Colors.grey.shade700),
                      items: ['No category', 'Create category'].map((String category){
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                          
                        );
                      }).toList(), 
                      decoration: InputDecoration(
                        labelText: 'Category',
                        labelStyle: heading4Regular,
                        contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      onChanged: (String? newValue){
                        setState(() {
                          _selectedCategory = newValue;
                        });
                        if(newValue == 'Create category'){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context)=>CreateCategory(),
                            ),
                          );
                        }
                      },
                    ),
              
                    const SizedBox(height: 25),
                    Text('Sold by', style: heading4Regular),
              
                    RadioListTile<soldBy>(
                      value: soldBy.Each, 
                      title: Text('Each', style: heading4Regular),
                      groupValue: _by, 
                      onChanged: (soldBy? value){
                        setState(() {
                          _by = value;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
              
                    RadioListTile<soldBy>(
                      value: soldBy.Weight, 
                      title: Text('Weight', style: heading4Regular),
                      groupValue: _by, 
                      onChanged: (soldBy? value){
                        setState(() {
                          _by = value;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
              
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: priceController,
                      inputFormatters: <TextInputFormatter>[
                        _formatter,
                        LengthLimitingTextInputFormatter(12),
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        labelStyle: heading4Regular,
                        contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                        helperText: 'Leave the field blank to indicate the price upon sale',
                        helperStyle: bodyXSregular.copyWith(color: Colors.grey.shade700),
                        //errorText: _validateName? 'This field cannot be blank' : null,
                      ),
                      
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: costController,
                      inputFormatters: <TextInputFormatter>[
                        _formatter,
                        LengthLimitingTextInputFormatter(12),
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Cost',
                        labelStyle: heading4Regular,
                        contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                      ),   
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: skuController,
                      decoration: InputDecoration(
                        labelText: 'SKU',
                        labelStyle: heading4Regular,
                        contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                        //errorText: _validateName? 'This field cannot be blank' : null,
                      ),
                    ),
              
                    const SizedBox(height: 20),
                    TextField(
                      controller: barcodeController,
                      decoration: InputDecoration(
                        labelText: 'Barcode',
                        labelStyle: heading4Regular,
                        contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                        //errorText: _validateName? 'This field cannot be blank' : null,
                      ),
                    ),
              
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),

//part 2 
            Container(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Inventory', 
                      style: bodyXSregular.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            Text('Track stock', style: bodySregular),
                            
                            Theme(
                              data: ThemeData(useMaterial3: false),
                              child: Switch(
                                value:_switchStates['Track stock']?? false, 
                                onChanged: (value){
                                  setState(() {
                                    _switchStates['Track stock'] = value;
                                    
                                  });
                                },
                                activeColor: primaryBlue.shade900,
                                inactiveTrackColor: Colors.grey,
                                activeTrackColor: primaryBlue.shade50,
                              ),
                            ),
                           
                          ],
                        ),
                          if( _switchStates['Track stock']?? true) 
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                controller: stockController,
                                decoration: InputDecoration(
                                  labelText: 'In stock',
                                  labelStyle: heading4Regular,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                                  
                                ),
                              ),
                            ),
                          ],
                        ),
                    
                  ],
                ),
              ),
            ),
//part 3
            const SizedBox(height: 15),
            Container(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Representation on POS', 
                      style: bodyXSregular.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                  
                   RadioListTile<design>(
                      value: design.Color_and_shape, 
                      title: Text('Color and shape', style: heading4Regular),
                      groupValue: _design, 
                      onChanged: (design? value){
                        setState(() {
                          _design = value;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),

                    RadioListTile<design>(
                      value: design.Image, 
                      title: Text('Image', style: heading4Regular),
                      groupValue: _design, 
                      onChanged: (design? value){
                        setState(() {
                          _design = value;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),

                    //need to save and display the design, havent done
                    if(_design == design.Color_and_shape) ...[
                      _buildColorAndShapeSelection(),
                      _buildShapeSelection(),
                    ]else if (_design == design.Image)...[
                      _buildImageSelection(),
                    ]

                  ],
                ),
              ),
            ),

//part 4 (button)
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
                          title: Text('Delete item', style: heading3Bold),
                          content: Text('Are you sure you want to delete the item?',style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),),
      
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
                                    builder: (context)=> SubItems(),
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
                      label: Text('DELETE ITEM', style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
        
      ),
    );
  }

  //Widget for choosing color and shape
  Widget _buildColorAndShapeSelection(){
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

 /*  void _showColorPicker(BuildContext context, Color initialColor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ColorPicker(
          color: initialColor,
          onColorChanged: (Color color) {
            // Handle color change
          },
         /*  heading: Text(
            'Select color',
            style: Theme.of(context).textTheme.headline6,
          ),
          subheading: Text(
            'Select color shade',
            style: Theme.of(context).textTheme.subtitle1,
          ), */
        ),
        /* actions: <Widget>[
          ElevatedButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ], */
      ),
    );
  } */

//Widget for shape
 Widget _buildShapeSelection(){
  List<String>shapes = ['square','circle','polygon','star'];

  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 100,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
          ), 
          itemCount: shapes.length,
          itemBuilder: ((context, index){
             String shape = shapes[index];
             return GestureDetector(
              onTap: (){
                 setState(() {
                  _selectedShape = shapes[index];
                }); 
              },
               child: ShapeOfView(
                shape: _getShape(shape),
                child: Container(
                  width: 70,
                  height: 70,
                  color: Theme.of(context).colorScheme.background, // Example color
                  alignment: Alignment.center,
                  //child: Text(shape.toUpperCase(), style: TextStyle(color: Colors.black)),
                  child: _selectedShape == shapes[index]?
                  Icon(Icons.check, color: Theme.of(context).colorScheme.secondary,size: 35):null,
                ),
              ), 
              
            ); 
          })
        ),
      ),
    
  );
}

Shape _getShape(String shapeName) {
    switch (shapeName) {
      case 'star':
        return StarShape(noOfPoints: 5);
      case 'circle':
        return CircleShape();
      case 'polygon':
        return PolygonShape(numberOfSides: 8);
      default:
        return RoundRectShape(borderRadius: BorderRadius.circular(0));
    }
  } 


  //Widget for choosing or taking photo
  Widget _buildImageSelection(){
    return Row(
      children: <Widget>[
        
        const SizedBox(width: 10),
        _image != null? Image.file(_image!, width: 150,height: 150, fit: BoxFit.cover): Image.asset('assets/image/defaultImage.jpg', scale: 5.0,),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: ()=> getImage(ImageSource.gallery), 
              icon: Icon(Icons.folder), 
              label: Text('CHOOSE PHOTO'),
            ),
            TextButton.icon(
              onPressed:  ()=> getImage(ImageSource.camera),  
              icon: Icon(Icons.camera_alt), 
              label: Text('TAKE PHOTO'),
            ),
          ],
        )
      ],
    );
  }
}