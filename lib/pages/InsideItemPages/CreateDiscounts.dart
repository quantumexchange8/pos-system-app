import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/widgets/discountDataModel.dart';

enum Discounts{percentage, sigma}

List<(Discounts, String)> discountOptions = <(Discounts, String)>[
  (Discounts.percentage, '%'),
  (Discounts.sigma,'Σ'),
];

class CreateDiscounts extends StatefulWidget {
  const CreateDiscounts({super.key});

  @override
  State<CreateDiscounts> createState() => _CreateDiscountsState();
}

class _CreateDiscountsState extends State<CreateDiscounts> {
  TextEditingController discountNameController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  bool _validateName = false;
  List<bool>isSelected = [false,false];
  Discounts? selectedDiscount;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('Create discounts', style: heading3Regular.copyWith(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: (){
              //need to handle save function, havent done
              setState(() {
                _validateName = discountNameController.text.isEmpty;
              });

              if(!_validateName){
                DiscountData newDiscount = DiscountData(
                  discount: selectedDiscount == Discounts.percentage
                      ? '${valueController.text}%'
                      : valueController.text,
                  name: discountNameController.text,
                );
                Navigator.pop(context, newDiscount);
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
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: discountNameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: heading4Regular,
                      contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                      errorText: _validateName? 'This field cannot be blank' : null,
                    ),
                  ),

                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: valueController,
                          inputFormatters: [
                            if(selectedDiscount == Discounts.percentage)
                             CurrencyTextInputFormatter.currency(
                                symbol: '',
                                decimalDigits: 2,
                              ),
                               
                            if(selectedDiscount == Discounts.sigma)
                              CurrencyTextInputFormatter.currency(
                                symbol: 'RM',
                                decimalDigits: 2,
                              ),
                               LengthLimitingTextInputFormatter(
                                selectedDiscount == Discounts.percentage? 6:12),
                                
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Value',
                            labelStyle: heading4Regular,
                            contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                            //suffixText: selectedDiscount == Discounts.percentage ? '%' : '',
                            helperText: 'Leave the field blank to indicate the value upon sale',
                            helperStyle: bodyXSregular.copyWith(color: Colors.grey.shade700, fontSize: 8.5),
                            //errorText: _validateName? 'This field cannot be blank' : null,
                          ),
                          onChanged: (value){
                            if(selectedDiscount == Discounts.percentage){
                              if(double.tryParse(value)!=null && double.parse(value)>100.00){
                                valueController.text = '100.00';
                                valueController.selection = TextSelection.fromPosition(
                                  TextPosition(offset: valueController.text.length),
                                );
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                    //when discount % max to 100.00, sigma RM max 12 length
                    ToggleButtons(
                        children: discountOptions.map((option){
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(option.$2),
                          );
                        }).toList(), 
                        borderRadius: BorderRadius.circular(5),
                        isSelected: isSelected,
                        onPressed: (int index){
                          setState(() {
                            for (int buttonIndex = 0; buttonIndex<isSelected.length; buttonIndex++){
                              isSelected[buttonIndex] = buttonIndex == index;
                            } 
                            selectedDiscount = discountOptions[index].$1;
                            valueController.text = '';
                           
                          });
                        },
                        
                        
                      ), 
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}