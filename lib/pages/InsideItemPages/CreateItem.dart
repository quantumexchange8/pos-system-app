import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/CreateCategory.dart';

enum soldBy {Each, Weight}

class CreateItem extends StatefulWidget {
  const CreateItem({super.key});

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController costController = TextEditingController(text: 'RM0.00');
  TextEditingController SkuController = TextEditingController(text: '10000');
  TextEditingController barcodeController = TextEditingController();
  String? _selectedCategory = 'No category';
  soldBy? _by = soldBy.Each;
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
            onPressed: (){}, 
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
                          //errorText: _validateName? 'This field cannot be blank' : null,
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
                      controller: SkuController,
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

//adjust layout 
            Container(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text('Cash drawer', 
                      style: bodyXSregular.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 15),
                        Text('Track stock', style: bodySregular),
                        const SizedBox(width: 15),
                        Theme(
                          data: ThemeData(useMaterial3: false),
                          child: Switch(
                            value: _switchStates['Track stock']?? false, 
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
                        const SizedBox(height: 60),
                      
                      ],
                    ),
                  ],
                ),
              ),
            ),

            

          ],
        ),
        

      ),
    );
  }
}