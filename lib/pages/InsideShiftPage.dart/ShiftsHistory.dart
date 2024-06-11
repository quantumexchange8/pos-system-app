import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideShiftPage.dart/ShiftReport.dart';

class ShiftsHistory extends StatefulWidget {
  const ShiftsHistory({super.key});

  @override
  State<ShiftsHistory> createState() => _ShiftsHistoryState();
}

class _ShiftsHistoryState extends State<ShiftsHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 18.0),
        child: Column(
          children: [
            AppBar(
              title: Text('Shifts', style: heading3Regular),
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                icon: Icon(Icons.close, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Divider(color: Colors.grey.shade400),
          ],
        ),
      ),

      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [  //example data
              _shiftHistory('Jun 10 - Jun 11', '10:57 am - 09:51 am'),
              _shiftHistory('Jun 06', '03:39 pm - 03:41 pm'),
            ],
          )
        ),
      ),
    );
  }

  Widget _shiftHistory(String date, String time){
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=> ShiftReport(),
          ),
        );
      },
      child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 35, width: 35,
                    child: Icon(Icons.schedule),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(date, style: bodySregular),
                      const SizedBox(height: 3),
                      Text(time, style: bodySregular.copyWith(color: Colors.grey.shade600)),
                      const SizedBox(height: 5),
                    ],
                  ),  
                ],
              ),
              Divider(
                color: Colors.grey.shade400, 
                thickness: 1, 
                indent: 50, 
                endIndent: 0,
              ),
            ],
          ),
    );     
  }
}



