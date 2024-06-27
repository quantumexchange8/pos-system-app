import 'package:flutter/material.dart';
import 'package:pos_system/widgets/dataModel/printerDataModel.dart';

class PrinterProvider with ChangeNotifier{
  List<DataPrinter> _printers = [];
  List<DataPrinter> get printers => _printers;

  void addPrinter (DataPrinter printer){
    _printers.add(printer);
    notifyListeners();
  }

  void removePrinter (DataPrinter printer){
    _printers.remove(printer);
    notifyListeners();
  }

  void updatePrinter(DataPrinter oldPrinter, DataPrinter newPrinter){
    final index = _printers.indexOf(oldPrinter);
    if(index != -1){
      _printers[index]= newPrinter;
      notifyListeners();
    }
  }
}