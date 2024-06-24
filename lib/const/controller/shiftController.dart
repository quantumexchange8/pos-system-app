import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShiftState extends ChangeNotifier{
  bool _isShiftOpen = false;

  bool get isShiftOpen => _isShiftOpen;

  void openShift(){
    _isShiftOpen = true;
    notifyListeners();
  }

  void closeShift(){
    _isShiftOpen = false;
    notifyListeners();
  }

}