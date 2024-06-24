import 'package:flutter/material.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/Homepage.dart';

class CardPayment extends StatefulWidget {
  final double totalPrice;
  const CardPayment({super.key, required this.totalPrice});

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
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