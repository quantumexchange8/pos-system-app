import 'package:flutter/cupertino.dart';
import 'package:pos_system/widgets/itemDataModel.dart';
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

  /* void updateItem(String sku, Item updatedItem) {
    // Find the index of the item to be updated
    int index = _items.indexWhere((item) => item.sku == sku);

    if (index != -1) {
      // Replace the item at the found index with the updated item
      _items[index] = updatedItem;
      notifyListeners();
    }
  } */
  /* void updateItem(Item item){
    int index = _items.indexWhere((i) => i.name == item.name);
    if(index !=-1){
      _items[index] = item;
      notifyListeners();
    }
  } */


}