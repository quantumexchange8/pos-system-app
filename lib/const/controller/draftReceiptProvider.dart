import 'package:flutter/cupertino.dart';
import 'package:pos_system/widgets/dataModel/draftReceiptDataModel.dart';
import 'package:pos_system/widgets/dataModel/itemDataModel.dart';

class DraftTicketProvider with ChangeNotifier{
  List<DraftReceipt> _items = [];
  List<DraftReceipt> get items => _items;

  void addItem(Item item){
    var existingItem = _items.firstWhere(
      (draftItem) => draftItem.name == item.name,
      orElse: ()=> DraftReceipt(
        name: item.name, 
        price: item.price),
    );

    if(_items.contains(existingItem)){
      existingItem.quantity +=1;
    }else{
      _items.add(existingItem);
    }
    notifyListeners();
  }

  void removeItem(DraftReceipt draftReceipt){
    _items.remove(draftReceipt);
    notifyListeners();
  }
}