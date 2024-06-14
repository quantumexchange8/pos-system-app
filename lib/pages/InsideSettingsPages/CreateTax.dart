import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideSettingsPages/ApplyTaxToItem.dart';

class CreateTax extends StatefulWidget {
  const CreateTax({super.key});

  @override
  State<CreateTax> createState() => _CreateTaxState();
}

class _CreateTaxState extends State<CreateTax> {
  TextEditingController taxNameController = TextEditingController();
  TextEditingController taxValueController = TextEditingController();
  String dropdownValue = "Included in the price";
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('Create tax', style: heading3Regular.copyWith(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: (){
              //need to handle save function, havent done
            
            }, 
            child: Text('SAVE', style: bodySregular.copyWith(color: Colors.white)),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: taxNameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: heading4Regular,
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                    //errorText: _validateName? 'This field cannot be blank' : null,
                  ),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: taxValueController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3)
                  ],
                  decoration: InputDecoration(
                    labelText: 'Tax rate, %',
                    labelStyle: heading4Regular,
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                    //errorText: _validateTax? 'This field cannot be blank' : null,
                  ),
                  onChanged: (value){
                    if(int.tryParse(value)!=null && int.parse(value)>100){
                      taxValueController.text = '100';
                      taxValueController.selection = TextSelection.fromPosition(
                        TextPosition(offset: taxValueController.text.length),
                      );
                    }
                  },
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                          value: dropdownValue,
                          style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),
                          items: <String>["Included in the price", "Added to the price"]
                          .map<DropdownMenuItem<String>>((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              );
                          }).toList(), 
                          decoration: InputDecoration(
                            labelText: 'Type',
                            labelStyle: heading4Regular,
                            contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          onChanged: (String? newValue){
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(thickness: 1, color: Colors.grey.shade300),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: BlueOutlineButton(
                    onPressed: (){
                      Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context)=>ApplyTaxToItem()),
                      );
                    }, 
                    text: 'APPLY TO ITEMS',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}