import 'package:flutter/cupertino.dart';
import 'package:pos_system/widgets/dataModel/itemDataModel.dart';
import 'package:flutter/material.dart';

class ItemProvider with ChangeNotifier{
  List<Item> _items = [];
  List<Item> get items =>_items;


  void addItem(Item item){
    _items.add(item);
    notifyListeners();
  }

  void removeItem(Item item){
    _items.remove(item);
    notifyListeners();
  }

  void updateItem(Item oldItem, Item newItem) {
    final index = _items.indexOf(oldItem);
    if (index != -1) {
      _items[index] = newItem;
      notifyListeners();
    }
  }

 
}