import 'package:flutter/material.dart';

int _bluePrimaryValue = 0xff123a96;
MaterialColor primaryBlue = MaterialColor(
  _bluePrimaryValue, 
  <int, Color>{
    50: Color(0xffaed0f5),
    100:Color(0xff3c70e8),
    200:Color(0xff255bd9),
    300:Color(0xff0f44bf),
    800:Color(0xff0238b5),
    900: Color(_bluePrimaryValue),
  }
);