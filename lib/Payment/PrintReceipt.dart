import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/DrawerPages/Receipts.dart';
import 'package:pos_system/widgets/dataModel/transactionModel.dart';

class PrintReceipt extends StatefulWidget {
  final Transaction transactionDetails;
  const PrintReceipt({super.key, required this.transactionDetails});

  @override
  State<PrintReceipt> createState() => _PrintReceiptState();
}

class _PrintReceiptState extends State<PrintReceipt> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  String _deviceMsg = '';
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _startScanDevices();

    // Listen for scan results
    printerManager.scanResults.listen((devices) {
      setState(() {
        _devices = devices;
      });

      if (_devices.isEmpty) {
        setState(() {
          _deviceMsg = 'No devices found';
        });
      }
    });
  }

  Future<void> _startScanDevices() async {
    // Request permissions
    if (await _requestPermissions()) {
      setState(() {
        _devices = [];
        _isScanning = true;
      });
      printerManager.startScan(const Duration(seconds: 2));
    }
  }

  void _stopScanDevices() {
    printerManager.stopScan();
    setState(() {
      _isScanning = false;
    });
  }

  Future<bool> _requestPermissions() async {
    final status = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    return status.values.every((permission) => permission.isGranted);
  }

  String getCurrentDateTime() {
    //final now = DateTime.now();
    final formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(widget.transactionDetails.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('Select Printer', style: heading3Regular.copyWith(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: Colors.white),
        ),
      ),
      body: _devices.isEmpty
          ? Center(child: Text(_deviceMsg))
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.print),
                  title: Text(_devices[index].name ?? ''),
                  subtitle: Text(_devices[index].address ?? ''),
                  onTap: () {
                    _startPrint(_devices[index]);
                  },
                );
              },
            ),
    );
  }

  void _startPrint(PrinterBluetooth printer) async {
    try {
      // Stop scanning before printing
      _stopScanDevices();

      // Connect to the printer
      printerManager.selectPrinter(printer);
      const PaperSize paper = PaperSize.mm80;
      final profile = await CapabilityProfile.load();

      // Print the ticket
      final PosPrintResult res = await printerManager.printTicket(await _ticket(paper, profile));
      showToast(res.msg);

      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Printing Success', style: bodyLbold),
          content: Text('Receipt printed successfully!', style: bodySregular),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context)=>Receipts()),
                ); // Close dialog
                
              },
            ),
          ],
        );
      },
    );

    } catch (e) {
      showToast("Error: $e");
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<List<int>> _ticket(PaperSize paper, CapabilityProfile profile) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];

    bytes += ticket.text('Store name',
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    bytes += ticket.hr();
    bytes += ticket.text('Employee: xxx',
        styles: PosStyles(
          align: PosAlign.left,
        ),
        linesAfter: 1);

    bytes += ticket.text('POS: xxx',
        styles: PosStyles(
          align: PosAlign.left,
        ),
        linesAfter: 1);

    bytes += ticket.hr();
    bytes += ticket.row([
      PosColumn(text: 'Item', width: 7),
      PosColumn(text: 'Qty', width: 1),
      PosColumn(text: 'Price', width: 2),
      PosColumn(text: 'Total', width: 2),
    ]);

    bytes += ticket.hr();
    for (var item in widget.transactionDetails.list) {
      bytes += ticket.row([
        PosColumn(text: item.name, width: 7),
        PosColumn(text: item.quantity.toString(), width: 1),
        PosColumn(text: item.price, width: 2),
        PosColumn(text: 'RM${(item.quantity * double.parse(item.price.replaceFirst('RM', ''))).toStringAsFixed(2)}', width: 2),
      ]);
    }
    bytes += ticket.hr();

    bytes += ticket.row([
      PosColumn(text: 'Total', width: 10, styles: PosStyles(bold: true)),
      PosColumn(text: 'RM${widget.transactionDetails.totalPrice.toStringAsFixed(2)}', width: 2, styles: PosStyles(bold: true)),
    ]);

    if (widget.transactionDetails.isCashPayment != null && widget.transactionDetails.isCashPayment!) {
      bytes += ticket.row([
        PosColumn(text: 'Cash', width: 10),
        PosColumn(text: 'RM${widget.transactionDetails.cashReceived.toStringAsFixed(2)}', width: 2),
      ]);

      bytes += ticket.row([
        PosColumn(text: 'Change', width: 10),
        PosColumn(text: 'RM${widget.transactionDetails.change.toStringAsFixed(2)}', width: 2),
      ]);
    } else if (widget.transactionDetails.isCashPayment != null && !widget.transactionDetails.isCashPayment!) {
      bytes += ticket.row([
        PosColumn(text: 'Card', width: 10),
        PosColumn(text: 'RM${widget.transactionDetails.totalPrice.toStringAsFixed(2)}', width: 2),
      ]);
    }

    bytes += ticket.hr();
    bytes += ticket.row([
      PosColumn(text: getCurrentDateTime(), width: 10),
      PosColumn(text: 'receipt no', width: 2),
    ]);
    bytes += ticket.hr();

    ticket.cut();
    return bytes;
  }
}
