import 'package:bluetooth_print/bluetooth_print_model.dart';

class DataPrinter{
  final String name;
  final BluetoothDevice? device;
  
  DataPrinter({
    required this.name,
    this.device,
  });
}