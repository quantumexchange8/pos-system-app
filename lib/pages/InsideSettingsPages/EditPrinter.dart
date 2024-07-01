/* import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/controller/printerProvider.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideSettingsPages/printers.dart';
import 'package:pos_system/widgets/dataModel/printerDataModel.dart';
import 'package:provider/provider.dart';

class EditPrinter extends StatefulWidget {
  final DataPrinter dataPrinter;
  const EditPrinter({super.key, required this.dataPrinter});

  @override
  State<EditPrinter> createState() => _EditPrinterState();
}

class _EditPrinterState extends State<EditPrinter> {
  late TextEditingController printerNameController;
  BluetoothDevice? dropdownValue;
  List<BluetoothDevice> _devices = [];

  String _deviceMsg = "";
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  //late String dropdownValue;

  final Map<String, bool> _switchStates = {
    'Print receipt and bills':false,
    'Print orders': false,
    'Automatically print receipt': false,
    'Print single item per order ticket' : false,
  };

  @override
  void initState(){
    super.initState();
    printerNameController = TextEditingController(text: widget.dataPrinter.name);
    dropdownValue = widget.dataPrinter.device;
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await requestPermissions();
      initPrinter();
    });
  }

  Future<void> requestPermissions() async {
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.location.request();
  }

  Future<void> initPrinter() async {
    try {
      bool isOn = await bluetoothPrint.isOn;
      if (!isOn) {
        setState(() {
          _deviceMsg = "Bluetooth is off.";
        });
        return;
      }

      bluetoothPrint.startScan(timeout: Duration(seconds: 2));
    } catch (e) {
      print('Error starting scan: $e');
      setState(() {
        _deviceMsg = "Error starting scan: $e";
      });
      return;
    }

    if (!mounted) return;
    bluetoothPrint.scanResults.listen((val) {
      if (!mounted) return;
      setState(() => _devices = val);
      if (_devices.isEmpty) {
        setState(() {
          _deviceMsg = "No Device";
        });
      }else{
        if(dropdownValue !=null && !_devices.contains(dropdownValue)){
          dropdownValue = _devices.first;
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text('Edit printer', style: heading3Regular.copyWith(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: (){
              //need to handle save function
              DataPrinter updatedPrinter = DataPrinter(
                name: printerNameController.text,
                device: dropdownValue, //pass the updated BluetoothDevice
              );
              /* final printerProvider = Provider.of<PrinterProvider>(context, listen: false);
              printerProvider.updatePrinter(widget.dataPrinter, updatedPrinter); */
              Navigator.pop(context, updatedPrinter);
            
            }, 
            child: Text('SAVE', style: bodySregular.copyWith(color: Colors.white)),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: printerNameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: heading4Regular,
                      contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                      //errorText: _validateName? 'This field cannot be blank' : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<BluetoothDevice?>(
                          value: dropdownValue,
                          style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),
                          items: _devices.map((BluetoothDevice device) {
                                    return DropdownMenuItem<BluetoothDevice?>(
                                      value: device,
                                      child: Text(device.name ?? "Unknown device"),
                                    );
                                  }).toList(),
                          onChanged: (BluetoothDevice? newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                        });
                                      },
                          decoration: InputDecoration(
                            labelText: 'Printer model',
                            labelStyle: heading4Regular,
                            contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          /* onChanged: (BluetoothDevice? newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          }, */
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
            Divider(thickness: 1, color: Colors.grey.shade300),
        
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Print receipts and bills', style: bodySregular),  
                      Theme(
                        data: ThemeData(useMaterial3: false),
                        child: Switch(
                          value:_switchStates['Print receipts and bills']?? false, 
                          onChanged: (value){
                            setState(() {
                              _switchStates['Print receipts and bills'] = value;
                              
                            });
                          },
                          activeColor: primaryBlue.shade900,
                          inactiveTrackColor: Colors.grey,
                          activeTrackColor: primaryBlue.shade50,
                        ),
                      ),
                    ],
                  ),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Print orders', style: bodySregular),  
                      Theme(
                        data: ThemeData(useMaterial3: false),
                        child: Switch(
                          value:_switchStates['Print orders']?? false, 
                          onChanged: (value){
                            setState(() {
                              _switchStates['Print orders'] = value;
                              
                            });
                          },
                          activeColor: primaryBlue.shade900,
                          inactiveTrackColor: Colors.grey,
                          activeTrackColor: primaryBlue.shade50,
                        ),
                      ),
                    ],
                  ),
        
                ],
              ),
            ),
        
            Divider(thickness: 1, color: Colors.grey.shade300),
        
              if( _switchStates['Print receipts and bills']?? true) 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Text('Automatically print receipt', style: bodySregular),
                      
                      Theme(
                        data: ThemeData(useMaterial3: false),
                        child: Switch(
                          value:_switchStates['Automatically print receipt']?? false, 
                          onChanged: (value){
                            setState(() {
                              _switchStates['Automatically print receipt'] = value;
                              
                            });
                          },
                          activeColor: primaryBlue.shade900,
                          inactiveTrackColor: Colors.grey,
                          activeTrackColor: primaryBlue.shade50,
                        ),
                      ),
                    ],
                  ),
                ),
        
                if( _switchStates['Print orders']?? true) 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Text('Print single item per order ticket', style: bodySregular),
                      
                      Theme(
                        data: ThemeData(useMaterial3: false),
                        child: Switch(
                          value:_switchStates['Print single item per order ticket']?? false, 
                          onChanged: (value){
                            setState(() {
                              _switchStates['Print single item per order ticket'] = value;
                              
                            });
                          },
                          activeColor: primaryBlue.shade900,
                          inactiveTrackColor: Colors.grey,
                          activeTrackColor: primaryBlue.shade50,
                        ),
                      ),
                    ],
                  ),
                ),
        
              if( _switchStates['Print receipts and bills']?? true) 
              Divider(thickness: 1, color: Colors.grey.shade300),
              
              if( _switchStates['Print orders']?? true)
              Divider(thickness: 1, color: Colors.grey.shade300),
        
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: BlueIconButton(
                        onPressed: (){}, 
                        text: 'PRINT TEST', icon: Icons.print),
                    ),
                  ],
                ),
              ),
              
            const SizedBox(height: 15),
            if( _switchStates['Print orders']?? true) 
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Printer groups', 
                style: bodyXSregular.copyWith(color: Theme.of(context).colorScheme.primary),
                textAlign: TextAlign.start,
              ),
            ),
            if( _switchStates['Print orders']?? true) 
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  
                  children: [
                    
                    Container(
                    height: 80, width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                    child: Icon(Icons.print, size: 50),
                  ),
                  const SizedBox(height: 25),
                  Text('You have no printers groups yet', style: bodySregular),
                  const SizedBox(height: 15),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: bodySregular,
                      children: [
                        TextSpan(
                          text: 'Set the kitchen printers in the ',
                          style: bodyXSregular.copyWith(color: Theme.of(context).colorScheme.secondary),
                        ),
                        TextSpan(
                          text: 'Back office',
                          style: bodyXSregular.copyWith(
                            decoration: TextDecoration.underline,
                            color: primaryBlue.shade800,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle on tap
                            },
                        ),
                      ],
                    ),
                  ),
                
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
            height: 45,
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Expanded(
                  child: FilledButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                      iconColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.secondary),
                      
                    ),
                    onPressed: (){
                      showDialog(
                      context: context, 
                      builder: (context)=> AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.background,
                        title: Text('Delete printer', style: heading3Bold),
                        content: Text('Are you sure you want to delete the printer?',style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),),
    
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                              
                            child: Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: (){
                              final printerProvider = Provider.of<PrinterProvider>(context, listen: false);
                              printerProvider.removePrinter(widget.dataPrinter);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, 
                            child: const Text('DELETE'),
                          ),
                        ],
                      )
                    );
                    }, 
                    icon: Icon(Icons.delete), 
                    label: Text('DELETE PRINTER', style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
} */