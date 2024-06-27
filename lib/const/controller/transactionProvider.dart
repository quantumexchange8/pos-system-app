import 'package:flutter/material.dart';
import 'package:pos_system/widgets/dataModel/transactionModel.dart';

class TransactionProvider with ChangeNotifier{
  List<Transaction> _transactions = [];
  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction transaction){
    _transactions.add(transaction);
    notifyListeners();
  }

  void removeTransaction(Transaction transaction){
    _transactions.remove(transaction);
    notifyListeners();
  }

  

}