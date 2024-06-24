import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/controller/transactionProvider.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/Homepage.dart';
import 'package:provider/provider.dart';

class CashPayment extends StatefulWidget {
  final double cashReceived;
  final double totalPrice;
  CashPayment({super.key, required this.cashReceived, required this.totalPrice});

  @override
  State<CashPayment> createState() => _CashPaymentState();
}

class _CashPaymentState extends State<CashPayment> {
  TextEditingController emailController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    double change = widget.cashReceived - widget.totalPrice;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryBlue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('RM${widget.cashReceived.toStringAsFixed(2)}', style: bodyLbold),
                      Text('Total paid', style: bodySregular),
                    ],
                  ),
                  VerticalDivider(thickness: 1, color: Colors.grey.shade400),
                  Column(
                    children: [
                      Text('RM${change.toStringAsFixed(2)}', style: bodyLbold),
                      Text('Change', style: bodySregular),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter email',
                hintStyle: heading4Regular,
                prefixIcon: Icon(Icons.email),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send), 
                  onPressed: (){
                    showDialog(
                      context: context, 
                      builder: (context)=>AlertDialog(
                        title: Text('Email sent', style: heading3Bold),
                        content: Text('Receipt is sent to email.', style: heading4Regular),
                        
                      )
                    );
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(vertical:10.0),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: BlueButton(
                    onPressed: (){
                      //save details
                      final transactionDetails = {
                        'cashReceived': widget.cashReceived,
                        'totalPrice':widget.totalPrice,
                        'change':change,
                      };

                      Provider.of<TransactionProvider>(context, listen: false).addTransaction(transactionDetails);


                      Navigator.push(context, 
                        MaterialPageRoute(builder: (context)=>HomePage(),),
                      );
                    }, 
                    text: 'NEW SALE',
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