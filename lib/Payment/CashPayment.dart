import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/controller/draftReceiptProvider.dart';
import 'package:pos_system/const/controller/transactionProvider.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/Homepage.dart';
import 'package:pos_system/widgets/dataModel/transactionModel.dart';
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
  
  
  String getCurrentDateTime(){
      final now = DateTime.now();
      final formatter= DateFormat('HH:mm');
      return formatter.format(now);
    }

  @override
  Widget build(BuildContext context) {
    double change = widget.cashReceived - widget.totalPrice;
    final draftReceiptProvider = Provider.of<DraftTicketProvider>(context);
    //final completeTicketProvider = Provider.of<CompleteTicketProvider>(context);
    double totalPrice = 0;
    for (var item in draftReceiptProvider.items){
      final itemPrice = double.parse(item.price.replaceFirst('RM', ''));
      totalPrice += itemPrice * item.quantity;
    } 

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
                       /* final transactionDetails = {
                        'cashReceived': widget.cashReceived,
                        'totalPrice':widget.totalPrice,
                        'change':change,
                        'dateTime':getCurrentDateTime(),
                      };  */

                       final transactionDetails = Transaction(
                        dateTime: DateTime.now(), 
                        cashReceived: widget.cashReceived, 
                        totalPrice: widget.totalPrice, 
                        change: change, 
                        list: List.from(draftReceiptProvider.items),//draftReceiptProvider.items,
                        isCashPayment: true,
                      ); 

                       Provider.of<TransactionProvider>(context, listen: false).addTransaction(transactionDetails);
                      /*for(var item in draftReceiptProvider.items){
                        completeTicketProvider.addItem(item);
                      } */
                      draftReceiptProvider.clearItem();

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