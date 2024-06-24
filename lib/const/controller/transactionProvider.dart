import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier{
  List<Map<String, dynamic>> _transactions = [];
  List<Map<String, dynamic>> get transactions => _transactions;

  void addTransaction(Map<String, dynamic> transaction){
    _transactions.add(transaction);
    notifyListeners();
  }

  void removeTransaction(Map<String, dynamic> transaction){
    _transactions.remove(transaction);
    notifyListeners();
  }

}