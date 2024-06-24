import 'package:flutter/material.dart';
import 'package:pos_system/widgets/dataModel/discountDataModel.dart';

class DiscountProvider with ChangeNotifier{
  List<DiscountData> _discounts = [];
  List<DiscountData> get discounts => _discounts;

  void addDiscount(DiscountData discount) {
    _discounts.add(discount);
    notifyListeners();
  }

  void removeDiscount(DiscountData discount) {
    _discounts.remove(discount);
    notifyListeners();
  }

  void updateDiscount(DiscountData oldDiscount, DiscountData newDiscount){
    final index = _discounts.indexOf(oldDiscount);
    if(index != -1){
      _discounts[index] = newDiscount;
      notifyListeners();
    }
  }
}