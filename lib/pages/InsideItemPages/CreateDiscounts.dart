import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_system/const/textStyle.dart';

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
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter.currency(
      symbol: '',
      decimalDigits: 2,
  );
  List<bool>isSelected = [false,false];
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
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: discountNameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: heading4Regular,
                      contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                      //errorText: _validateName? 'This field cannot be blank' : null,
                    ),
                  ),

                  SizedBox(height: 15),
                  Row(
                    children: [
                      TextFormField(
                        controller: valueController,
                        inputFormatters: <TextInputFormatter>[
                          _formatter,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          labelStyle: heading4Regular,
                          contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                          helperText: 'Leave the field blank to indicate the value upon sale',
                          helperStyle: bodyXSregular.copyWith(color: Colors.grey.shade700),
                          //errorText: _validateName? 'This field cannot be blank' : null,
                        ),
                      ),

                    //when discount % max to 100.00, sigma RM max 12 length
                      ToggleButtons(
                        children: [
                         
                        ], 
                        isSelected: isSelected,
                        onPressed: (int index){

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