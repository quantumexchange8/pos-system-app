
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';

class CashManagement extends StatefulWidget {
  const CashManagement({super.key});

  @override
  State<CashManagement> createState() => _CashManagementState();
}

class _CashManagementState extends State<CashManagement> {
  bool isFilled = false;
  TextEditingController _amountController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter.currency(
      symbol: 'RM',
      decimalDigits: 2,
    );
  @override
  void dispose() {
    _amountController.text = CurrencyTextInputFormatter.currency(
      symbol: 'RM',
      decimalDigits: 2,
    ).formatDouble(0.00);
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cash management', style: bodyMregular.copyWith(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _amountController,
              onChanged: (value) {
                setState(() {
                  isFilled = value.isNotEmpty;
                });
              },
              //initialValue: _formatter.formatDouble(0.00),
              inputFormatters: <TextInputFormatter>[
                _formatter,
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: heading4Regular,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Comment',
                labelStyle: heading4Regular,
                contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: isFilled? BlueOutlineButton(
                    onPressed: (){}, 
                    text: 'PAY IN'
                  ): CustomOutlineButton(
                    onPressed: (){}, 
                    text: 'PAY IN', 
                    borderColor: Colors.grey, 
                    textColor: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomOutlineButton(
                    onPressed: isFilled? (){}: (){}, 
                    text: 'PAY OUT', 
                    borderColor: isFilled? Colors.red: Colors.grey, 
                    textColor: isFilled? Colors.red: Colors.grey,
                  ),
                ),
              ],
            ),

            Divider(thickness: 1, color: Colors.grey.shade300),
            const SizedBox(height:10),
            Text('Pay in/Pay out', style: bodyXSregular.copyWith(color: primaryBlue.shade900),),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${TimeOfDay.now().format(context)}', style: bodySregular),
                //const SizedBox(width: 10),
                Text('Owner - ${_commentController.text}', style: bodySregular),
                const SizedBox(width: 50),
                Text('${_amountController.text}', style: bodySregular, textAlign: TextAlign.end,),
              ],
            )

          ],
        ),
      ),
    );
  }
}