import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/widgets/dataModel/transactionModel.dart';

class PrintReceipt extends StatefulWidget {
  final Transaction transactionDetails;
  const PrintReceipt({super.key, required this.transactionDetails});

  @override
  State<PrintReceipt> createState() => _PrintReceiptState();
}

class _PrintReceiptState extends State<PrintReceipt> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _deviceMsg = ""; 

  Future<void>requestPermission() async {
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.location.request();
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async //=> 
    {
      //initPrinter()
      await requestPermission();
      initPrinter();
    });
  }

  Future<void> initPrinter() async{
    try{
      bool isOn = await bluetoothPrint.isOn;
      if(!isOn){
        setState(() {
          _deviceMsg = 'Bluetooth is off. Please enable Bluetooth function.';
        });
        return;
      } 
      bluetoothPrint.startScan(timeout: Duration(seconds: 2));
    }catch(e){
      print('Error starting scan: $e');
      setState(() {
        _deviceMsg = 'Error starting scan: $e';
      });
      return;
    }

    //if(!mounted)return;
    
    //Listen to scan results
    bluetoothPrint.scanResults.listen((val) {
      if(!mounted) return;
      setState(() {
        _devices = val;
        if(_devices.isEmpty){
          _deviceMsg = 'No Device';
        }
      });
    });
    /* bluetoothPrint.scanResults.listen(
      (val) { 
      if (!mounted) return;
      setState(() => {_devices = val});
      if(_devices.isEmpty) 
       
         setState(() {
         _deviceMsg = "No Device";
        }); 
    },);
 */
  }

   String getCurrentDateTime(){
      final now = DateTime.now();
      final formatter= DateFormat('dd/MM/yyyy HH:mm');
      return formatter.format(now);
    }

  @override
  Widget build(BuildContext context) {
   


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('Select Printer', style: heading3Regular.copyWith(color: Colors.white)),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.close, color: Colors.white),
        ),
      ),
      body: _devices.isEmpty
        ? Center(
        child: Text(_deviceMsg?? '', textAlign: TextAlign.center),)
        : ListView.builder(
          itemCount: _devices.length,
          itemBuilder: (BuildContext context, int index) { 
            return Column(
              children: [
                ListTile(
                  leading: Icon(Icons.print),
                  title: Text(_devices[index].name ?? 'Unknown device'),
                  subtitle: Text(_devices[index].address ?? 'Unknown address'),
                  onTap: (){
                    _startPrint(_devices[index]);
                  },
                ),
                Divider(
                  height: 5,
                  color: Colors.grey.shade300, 
                  thickness: 1, 
                ),
              ],
            );
           },

        )

    );
  }

  Future<void> _startPrint(BluetoothDevice device) async {
    if(device != null && device.address !=null){
      try{
        await bluetoothPrint.connect(device);

          Map<String, dynamic>config = {};
          List<LineText> list = [];


          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: 'RM${widget.transactionDetails.totalPrice.toStringAsFixed(2)}',
              weight: 2,
              align: LineText.ALIGN_CENTER,
              linefeed: 1,
            )
          );

          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: 'Total',
              align: LineText.ALIGN_CENTER,
            )
          );

          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: '------------------------------',
              linefeed: 1,
            )
          );

          // Employee and POS
          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: 'Employee: XXXX',
              linefeed: 1,
            )
          );

          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: 'POS: XXX',
              linefeed: 1,
            )
          );

          list.add(
            LineText(
              type: LineText.TYPE_TEXT,
              content: '------------------------------',
              linefeed: 1,
            )
          );

          //Item details

          for(var item in widget.transactionDetails.list){
            list.add(
              LineText(
                type: LineText.TYPE_TEXT,
                content: item.name,
                linefeed: 1,
              )
            );

              list.add(LineText(
                type: LineText.TYPE_TEXT,
                content: '${item.quantity} x ${item.price}',
                linefeed: 1,
              ));

              list.add(LineText(
                type: LineText.TYPE_TEXT,
                content:
                    'RM${(item.quantity * double.parse(item.price.replaceFirst('RM', ''))).toStringAsFixed(2)}',
                align: LineText.ALIGN_RIGHT,
                linefeed: 1,
              ));

              list.add(LineText(
                type: LineText.TYPE_TEXT,
                content: '------------------------------',
                linefeed: 1,
              ));

          }

                // Total
              list.add(LineText(
                type: LineText.TYPE_TEXT,
                content: 'Total',
                weight: 2,
                linefeed: 1,
              ));
              list.add(LineText(
                type: LineText.TYPE_TEXT,
                content: 'RM${widget.transactionDetails.totalPrice.toStringAsFixed(2)}',
                weight: 2,
                linefeed: 1,
              ));

              // Cash or Card Payment
              if (widget.transactionDetails.isCashPayment != null &&
                  widget.transactionDetails.isCashPayment!) {
                list.add(LineText(
                  type: LineText.TYPE_TEXT,
                  content: 'Cash',
                  linefeed: 1,
                ));
                list.add(LineText(
                  type: LineText.TYPE_TEXT,
                  content:
                      'RM${widget.transactionDetails.cashReceived.toStringAsFixed(2)}',
                  linefeed: 1,
                ));
                list.add(LineText(
                  type: LineText.TYPE_TEXT,
                  content: 'Change',
                  linefeed: 1,
                ));
                list.add(LineText(
                  type: LineText.TYPE_TEXT,
                  content: 'RM${widget.transactionDetails.change.toStringAsFixed(2)}',
                  linefeed: 1,
                ));
              } else if (widget.transactionDetails.isCashPayment != null &&
                  !widget.transactionDetails.isCashPayment!) {
                list.add(LineText(
                  type: LineText.TYPE_TEXT,
                  content: 'Card',
                  linefeed: 1,
                ));
                list.add(LineText(
                  type: LineText.TYPE_TEXT,
                  content: 'RM${widget.transactionDetails.totalPrice.toStringAsFixed(2)}',
                  linefeed: 1,
                ));
              }

              // Footer
              list.add(LineText(
                type: LineText.TYPE_TEXT,
                content: '------------------------------',
                linefeed: 1,
              ));
              list.add(LineText(
                type: LineText.TYPE_TEXT,
                content: getCurrentDateTime(),
                linefeed: 1,
              ));
              list.add(LineText(
                type: LineText.TYPE_TEXT,
                content: 'receipt no',
                linefeed: 1,
              ));

              await bluetoothPrint.printReceipt(config, list);

      }catch(e){

        print('Error connecting or printing: $e');
        setState(() {
          _deviceMsg = 'Error connecting or printing:$e';
        });

      }

      
    }
  }
}