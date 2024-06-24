import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/textStyle.dart';

class CompleteReceipt extends StatefulWidget {
  final Map<String, dynamic> transactionDetails;
  const CompleteReceipt({super.key, required this.transactionDetails});

  @override
  State<CompleteReceipt> createState() => _CompleteReceiptState();
}

class _CompleteReceiptState extends State<CompleteReceipt> {

  PopupMenuEntry<String> _popUpItem(String value, IconData icon, String title) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 15),
          Text(title),
          // need to action
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('#receipt_no', style: heading3Regular.copyWith(color: Colors.white)),
        actions: [

          TextButton(
            onPressed: (){}, 
            child: Text('REFUND', style: bodySregular.copyWith(color: Colors.white),)
          ),

          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white, // Set the color of the popup menu icon
            ),
            onSelected: (String value) {
              // action
            },
            itemBuilder: (BuildContext context) {
              return [
                _popUpItem('Option 1', Icons.email, 'Email receipt'),
                
              ];
            },
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text('RM${widget.transactionDetails['totalPrice'].toStringAsFixed(2)}', style: heading2Bold),
                Text('Total', style: bodySregular),
              ],
            ),
          ),
          Divider(thickness: 1, color: Colors.grey.shade300),
          Text('Employee: XXXX', style: heading4Regular),
          Text('POS: XXX',style: heading4Regular),
          Divider(thickness: 1, color: Colors.grey.shade300),

          Text('Item name'),
          Text('Item quantity'),
          Text('', style: bodySregular),
          Divider(thickness: 1, color: Colors.grey.shade300),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: bodySregular),
              Text('RM${widget.transactionDetails['totalPrice'].toStringAsFixed(2)}',style: bodySregular),
            ],
          ),

          Divider(thickness: 1, color: Colors.grey.shade300),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cash', style: bodySregular),
              Text('RM${widget.transactionDetails['cashReceived'].toStringAsFixed(2)}'),
            ],
          ),

          Divider(thickness: 1, color: Colors.grey.shade300),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Change', style: bodySregular),
              Text('RM${widget.transactionDetails['change'].toStringAsFixed(2)}',style: bodySregular),
            ],
          ),

          Divider(thickness: 1, color: Colors.grey.shade300),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('date time'),
              Text('receipt no')
            ],
          ),

          
        ],
      ),
    );
  }
}