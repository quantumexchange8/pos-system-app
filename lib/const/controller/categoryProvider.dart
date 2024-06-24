import 'package:flutter/material.dart';
import 'package:pos_system/widgets/dataModel/categoryDataModel.dart';

class CategoryProvider with ChangeNotifier{
  List <DataCategory> _categories = [];
  List <DataCategory> get categories => _categories;

  void addCategory(DataCategory category){
    _categories.add(category);
    notifyListeners();
  }

  void removeCategory(DataCategory category){
    _categories.remove(category);
    notifyListeners();
  }

  void updateCategory(DataCategory oldCategory, DataCategory newCategory){
    final index = _categories.indexOf(oldCategory);
    if(index != -1){
      _categories[index]= newCategory;
      notifyListeners();
    }
  }
}