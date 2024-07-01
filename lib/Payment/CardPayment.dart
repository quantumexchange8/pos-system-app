import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/controller/draftReceiptProvider.dart';
import 'package:pos_system/const/controller/transactionProvider.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/Homepage.dart';
import 'package:pos_system/widgets/dataModel/transactionModel.dart';
import 'package:provider/provider.dart';

class CardPayment extends StatefulWidget {
  final double totalPrice;
 
  CardPayment({super.key, required this.totalPrice});

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  TextEditingController emailController = TextEditingController();
  DateTime transactionTime = DateTime.now();

    String getCurrentDateTime(){
      //final now = DateTime.now();
      final formatter= DateFormat('HH:mm');
      return formatter.format(transactionTime);
    }

  @override
  Widget build(BuildContext context) {
    double cashReceived = 0;
    double change = cashReceived - widget.totalPrice;
    final draftReceiptProvider = Provider.of<DraftTicketProvider>(context);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('RM${widget.totalPrice.toStringAsFixed(2)}', style: bodyLbold),
            
            Text('Total paid', style: bodySregular),
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
                      final transactionDetails = Transaction(
                        dateTime: transactionTime, 
                        cashReceived: cashReceived, 
                        totalPrice: widget.totalPrice, 
                        change: change, 
                        list: List.from(draftReceiptProvider.items),
                        isCashPayment: false,
                      ); 

                      Provider.of<TransactionProvider>(context, listen: false).addTransaction(transactionDetails);

                      draftReceiptProvider.clearItem();

                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context)=>HomePage(),),
                      );
                    }, 
                    text: 'NEW SALE')
                  ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}