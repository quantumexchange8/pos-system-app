import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_system/const/controller/discountProvider.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/SubDiscountsPage.dart';
import 'package:pos_system/widgets/dataModel/discountDataModel.dart';
import 'package:provider/provider.dart';

enum Discounts{percentage, sigma}

List<(Discounts, String)> discountOptions = <(Discounts, String)>[
  (Discounts.percentage, '%'),
  (Discounts.sigma,'Σ'),
];

class EditDiscounts extends StatefulWidget {
  final DiscountData discountData;
  const EditDiscounts({super.key, required this.discountData});

  @override
  State<EditDiscounts> createState() => _EditDiscountsState();
}

class _EditDiscountsState extends State<EditDiscounts> {
  late TextEditingController discountNameController;
  late TextEditingController valueController;
  bool _validateName = false;
  List<bool>isSelected = [false,false];
  Discounts? selectedDiscount;

  @override
  void initState(){
    discountNameController = TextEditingController(text: widget.discountData.name);
    valueController = TextEditingController(text: widget.discountData.discount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('Edit discount', style: heading3Regular.copyWith(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: (){
              //need to handle save function
              setState(() {
                _validateName = discountNameController.text.isEmpty;
              });
              if(!_validateName){
                DiscountData updatedDiscount = DiscountData(
                  discount: valueController.text,
                  name: discountNameController.text, 
                );
                final discountProvider = Provider.of<DiscountProvider>(context, listen: false);
                discountProvider.updateDiscount(widget.discountData, updatedDiscount);
                Navigator.pop(context, updatedDiscount);
              }
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
                                selectedDiscount == Discounts.percentage?6:12),
                                
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Value',
                            labelStyle: heading4Regular,
                            contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                            helperText: 'Leave the field blank to indicate the value upon sale',
                            helperStyle: bodyXSregular.copyWith(color: Colors.grey.shade700, fontSize: 8.5),
                            
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
                        title: Text('Delete discount', style: heading3Bold),
                        content: Text('Are you sure you want to delete the discount?',style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),),
    
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            
                            child: Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: (){
                              //delete function
                              final discountProvider = Provider.of<DiscountProvider>(context,listen: false);
                              discountProvider.removeDiscount(widget.discountData);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              
                            }, 
                            child: const Text('DELETE'),
                          ),
                        ],
                      )
                    );
                    }, 
                    icon: Icon(Icons.delete), 
                    label: Text('DELETE DISCOUNT', style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),),
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