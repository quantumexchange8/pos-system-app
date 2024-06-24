import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/CreateCategory.dart';
import 'package:pos_system/widgets/dataModel/itemDataModel.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

enum soldBy {Each, Weight}
enum design {Color_and_shape, Image}

class CreateItem extends StatefulWidget {
  const CreateItem({super.key});

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
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
  Color _selectedColor = Color(0xffe0e0e0);
  int _selectedShape = 0;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  List<Shape>shapes = [
      RoundRectShape(borderRadius: BorderRadius.circular(0)),
      CircleShape(),
      PolygonShape(numberOfSides: 8),
      StarShape(noOfPoints: 5),
  ];

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
        title: Text('Create item', style: heading3Regular.copyWith(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: (){
              //need to handle save function, havent done
              
                setState(() {
                  _validateName = nameController.text.isEmpty;
                });
                
                if(!_validateName) {
                  Item newItem = Item(
                    name: nameController.text, 
                    category: _selectedCategory!,
                    soldBy: _by == soldBy.Each? 'Each':'Weight',
                    design: _design == design.Color_and_shape? 'Color and Shape':'Image',
                    price: priceController.text,
                    cost: costController.text,
                    sku: skuController.text,
                    barcode: barcodeController.text,
                    trackStock: _switchStates['Track stock'] ?? false,
                    stock: stockController.text,
                    color: _selectedColor.toString(),
                    shape: shapes[_selectedShape],
                    imagePath: _image?.path,
                  );

                  Navigator.pop(context, newItem);
                  /* Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=>SubItems(),),
                  ); */
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
              height: 15,
            ),
            Container(
              //color: Colors.grey.shade200,
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
                      style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),
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
            Container(
              color: Colors.grey.shade200,
              height: 15,
            ),

//part 2 
            Container(
             // color: Colors.grey.shade200,
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
                                keyboardType: TextInputType.number,
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
            Container(
              color: Colors.grey.shade200,
              height: 15,
            ),
            Container(
              //color: Colors.grey.shade200,
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
                      _buildColorSelection(),
                      _buildShapeSelection(),
                    ]else if (_design == design.Image)...[
                      _buildImageSelection(),
                    ]

                  ],
                ),
              ),
            ),

            

          ],
        ),
        
      ),
    );
  }

  //Widget for choosing color and shape
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
      padding: const EdgeInsets.only(top: 10),
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

 
//Widget for shape
 Widget _buildShapeSelection(){
 

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
             Shape shape = shapes[index];
             //bool isSelected = _selectedShape == shape;
             return GestureDetector(
              onTap: (){
                 setState(() {
                  _selectedShape = index;
                }); 
              },
               child: ShapeOfView(
                shape: shape,
                child: Container(
                  width: 70,
                  height: 70,
                  color: Colors.white, // Example color
                  alignment: Alignment.center,
                  child: _selectedShape ==index?
                  Icon(Icons.check, color: Colors.black ,size: 35):null,
                ),
              ), 
              
            ); 
          })
        ),
      ),
    
  );
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
  
