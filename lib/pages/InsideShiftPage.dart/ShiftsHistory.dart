import 'package:flutter/material.dart';

class ShiftsHistory extends StatefulWidget {
  const ShiftsHistory({super.key});

  @override
  State<ShiftsHistory> createState() => _ShiftsHistoryState();
}

class _ShiftsHistoryState extends State<ShiftsHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shifts'),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.close)
        ),
      ),
    );
  }
}