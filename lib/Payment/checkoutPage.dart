import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_system/Payment/CardPayment.dart';
import 'package:pos_system/Payment/CashPayment.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';

class CheckoutPage extends StatefulWidget {
  final double totalPrice;
  
  CheckoutPage({super.key, required this.totalPrice});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter.currency(
    symbol: 'RM',
    decimalDigits: 2,
  );
  late TextEditingController cashReceivedController;

  @override
  void initState() {
    super.initState();
    cashReceivedController = TextEditingController(text: 'RM${widget.totalPrice.toStringAsFixed(2)}');
  }

  @override
  void dispose() {
    cashReceivedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.totalPrice;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryBlue.shade900,
        actions: <Widget>[
          TextButton(
            onPressed: () {}, 
            child: Text('SPLIT', style: bodySregular.copyWith(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Text('RM${totalPrice.toStringAsFixed(2)}', style: bodyLbold),
            Text('Total amount due', style: bodySregular),
            const SizedBox(height: 30),
            TextFormField(
              controller: cashReceivedController,
              inputFormatters: <TextInputFormatter>[
                _formatter,
                LengthLimitingTextInputFormatter(12),
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cash received',
                labelStyle: heading4Regular,
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: BlueIconButton(
                    onPressed: () {
                      double cashReceived = double.parse(
                        cashReceivedController.text.replaceAll(RegExp(r'[^0-9.]'), ''),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CashPayment(
                            cashReceived: cashReceived, totalPrice: totalPrice),
                        ),
                      );
                    },
                    text: 'CASH',
                    icon: Icons.money,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: BlueIconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CardPayment(totalPrice: totalPrice),
                        ),
                      );
                    },
                    text: 'CARD',
                    icon: Icons.credit_card,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
