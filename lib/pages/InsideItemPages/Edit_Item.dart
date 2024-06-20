import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/itemProvider.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/CreateCategory.dart';
import 'package:pos_system/pages/InsideItemPages/SubItemPage.dart';
import 'package:pos_system/widgets/itemDataModel.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';


enum soldBy {Each, Weight}
enum design {Color_and_shape, Image}

class EditItem extends StatefulWidget {

  final Item item;
  EditItem({Key? key, required this.item}):super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  //initialize the text controllers with the item data passed from 'SubItem'
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController costController;
  late TextEditingController skuController;
  late TextEditingController barcodeController;
  late TextEditingController stockController;
  bool _validateName = false;
  late String? _selectedCategory = 'No category';
  soldBy? _by = soldBy.Each;
  design? _design = design.Color_and_shape;
  late Color _selectedColor;
  late int _selectedShape;
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
  void initState(){
    nameController = TextEditingController(text: widget.item.name);
    priceController = TextEditingController(text: widget.item.price);
    costController = TextEditingController(text: widget.item.cost);
    skuController = TextEditingController(text: widget.item.sku);
    barcodeController = TextEditingController(text: widget.item.barcode);
    stockController = TextEditingController(text: widget.item.stock);
    //_selectedColor = Color(int.parse(widget.item.color.replaceFirst('Color(0xff', '').replaceFirst(')', ''), radix: 16));
    _selectedColor = _convertColor(widget.item.color);
    _selectedShape = shapes.indexWhere((shape) => shape.runtimeType == widget.item.shape.runtimeType);

    //_selectedShape = 0;//shapes.indexOf(widget.item.shape);
    _selectedCategory = widget.item.category;
    _by = widget.item.soldBy == 'Each' ? soldBy.Each : soldBy.Weight;
    _design = widget.item.design == 'Color and shape' ? design.Color_and_shape : design.Image;
    _switchStates['Track stock'] = widget.item.trackStock;
    
      if(widget.item.imagePath!=null){
      _image = File(widget.item.imagePath!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('Edit item', style: heading3Regular.copyWith(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: (){
              //need to handle save function
                setState(() {
                  _validateName = nameController.text.isEmpty;
                });
                
                if(!_validateName) { 
                Item updatedItem = Item(
                  name: nameController.text, 
                  category:  _selectedCategory!, 
                  soldBy: _by == soldBy.Each?'Each':'Weight', 
                  design: _design == design.Color_and_shape? 'Color and shape':'Image', 
                  price: priceController.text, 
                  cost: costController.text, 
                  sku: skuController.text, 
                  barcode: barcodeController.text, 
                  trackStock: _switchStates['Track stock']?? false, 
                  stock: stockController.text, 
                  color: '#${_selectedColor.value.toRadixString(16).padLeft(8,'0')}', 
                  shape: shapes[_selectedShape],
                  imagePath: _image?.path,
                  );

                 /*  widget.item.name = nameController.text;
                  widget.item.price = priceController.text;
                  widget.item.cost = costController.text;
                  widget.item.sku = skuController.text;
                  widget.item.barcode = barcodeController.text;
                  widget.item.stock = stockController.text;
                  widget.item.color = _selectedColor.value.toString();
                  widget.item.category = _selectedCategory!;
                  widget.item.soldBy = _by == soldBy.Each?'Each':'Weight';
                  widget.item.design = _design == design.Color_and_shape? 'Color and shape':'Image';
                  widget.item.trackStock = _switchStates['Track stock']?? false;
                  widget.item.shape = shapes[_selectedShape];
                  widget.item.imagePath = _image?.path;
 */
                  //update at provider
                  final itemProvider = Provider.of<ItemProvider>(context,listen:false);
                  itemProvider.updateItem(widget.item, updatedItem);
                  Navigator.pop(context);
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
              //color: Colors.grey.shade200,
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

//part 4 (button)
            Container(
              color: Colors.grey.shade200,
              height: 15,
            ),
            Container(
              height: 40,
              //color: Colors.grey.shade200,
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
 Widget _buildShapeSelection() {
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
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedShape = index; // Ensure index is within valid range
              });
            },
            child: ShapeOfView(
              shape: shapes[index],
              child: Container(
                width: 70,
                height: 70,
                color: Colors.white,
                alignment: Alignment.center,
                child: _selectedShape == index
                    ? Icon(Icons.check, color: Colors.black, size: 35)
                    : null,
              ),
            ),
          );
        },
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