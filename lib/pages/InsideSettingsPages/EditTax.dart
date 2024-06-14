import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideSettingsPages/ApplyTaxToItem.dart';
import 'package:pos_system/pages/InsideSettingsPages/taxes.dart';

class EditTax extends StatefulWidget {
  const EditTax({super.key});

  @override
  State<EditTax> createState() => _EditTaxState();
}

class _EditTaxState extends State<EditTax> {
   TextEditingController taxNameController = TextEditingController();
  TextEditingController taxValueController = TextEditingController();
  String dropdownValue = "Included in the price";
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('Edit tax', style: heading3Regular.copyWith(color: Colors.white)),
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

          Divider(thickness: 1, color: Colors.grey.shade300),

          Container(
            height: 45,
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
                        title: Text('Delete tax', style: heading3Bold),
                        content: Text('Are you sure you want to delete this tax?',style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),),
    
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
                                  builder: (context)=> TaxesPage(),
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
                    label: Text('DELETE TAX', style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}