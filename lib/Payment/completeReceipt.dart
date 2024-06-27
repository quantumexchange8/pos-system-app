import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/Payment/PrintReceipt.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/widgets/dataModel/transactionModel.dart';

class CompleteReceipt extends StatefulWidget {
  final Transaction transactionDetails;
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
          
        ],
      ),
    );
  }

  /* BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _deviceMsg = ""; */

  /* @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {initPrinter()});
  }

  Future<void>initPrinter() async{
    bluetoothPrint.startScan(timeout: Duration(seconds: 2));

    if(!mounted)return;
    bluetoothPrint.scanResults.listen(
      (val) { 
      if(!mounted)return;
      setState(() => {_devices = val});
      if(_devices.isEmpty) 
        setState(() {
         _deviceMsg = "No Device";
        });
    },);
  } */
  
  @override
  Widget build(BuildContext context) {
    //final items = widget.transactionDetails['items'] as List<Map<String, dynamic>>?;
    //final List<Map<String, dynamic>> items = widget.transactionDetails['items'];
    //final transaction = widget.transactionDetails;
    //final items = transaction.items;
     
    String getCurrentDateTime(){
      final now = DateTime.now();
      final formatter= DateFormat('dd/MM/yyyy HH:mm');
      return formatter.format(now);
    }

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
              if(value == 'Option 1'){
                /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> ),
                ); */
              }else if(value == 'Option 2'){
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>PrintReceipt(transactionDetails: widget.transactionDetails),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                _popUpItem('Option 1', Icons.email, 'Email receipt'),
                _popUpItem('Option 2', Icons.print, 'Print receipt'),
                
              ];
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text('RM${widget.transactionDetails.totalPrice.toStringAsFixed(2)}', style: heading2Bold),
                    Text('Total', style: bodySregular),
                  ],
                ),
              ),
              Divider(thickness: 1, color: Colors.grey.shade300),
              Text('Employee: XXXX', style: heading4Regular),
              Text('POS: XXX',style: heading4Regular),
        
              Divider(thickness: 1, color: Colors.grey.shade300),
        
             ListView.builder(
                shrinkWrap: true,
                itemCount: widget.transactionDetails.list.length,
                itemBuilder: (context, index) {
                  final item = widget.transactionDetails.list[index];
                  return ListTile(
                    title: Text(item.name, style: heading4Regular),
                    subtitle: Text('${item.quantity} x ${item.price}', style: bodySregular),
                    trailing: Text('RM${(item.quantity * double.parse(item.price.replaceFirst('RM', ''))).toStringAsFixed(2)}', style: heading4Regular),
                  );
                },
              ), 
        
              Divider(thickness: 1, color: Colors.grey.shade300),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: heading3Bold),
                  Text('RM${widget.transactionDetails.totalPrice.toStringAsFixed(2)}',style: heading3Bold),
                ],
              ),
          
              //for cash payment
              if(widget.transactionDetails.isCashPayment!=null && widget.transactionDetails.isCashPayment!)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cash', style: bodySregular),
                  Text('RM${widget.transactionDetails.cashReceived.toStringAsFixed(2)}', style: bodySregular),
                ],
              ),
          
              if(widget.transactionDetails.isCashPayment!=null && widget.transactionDetails.isCashPayment!)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Change', style: bodySregular),
                  Text('RM${widget.transactionDetails.change.toStringAsFixed(2)}',style: bodySregular),
                ],
              ),

              //only for card payment
              if(widget.transactionDetails.isCashPayment!=null && !widget.transactionDetails.isCashPayment!)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Card', style: bodySregular),
                  Text('RM${widget.transactionDetails.totalPrice.toStringAsFixed(2)}',style: bodySregular),
                ],
              ),
          
              Divider(thickness: 1, color: Colors.grey.shade300),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getCurrentDateTime(), style: bodySregular),
                  Text('receipt no', style: bodySregular),
                ],
              ),
          
              
            ],
          ),
        ),
      ),
    );
  }
}