import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/splashScreenPages/DoneSetting.dart';

class FeatureSettings extends StatefulWidget {
  const FeatureSettings({super.key});

  @override
  State<FeatureSettings> createState() => _FeatureSettingsState();
}

class _FeatureSettingsState extends State<FeatureSettings> {
  //bool isSwitched = false;
  final Map<String, bool> _switchStates = {
    'Shifts':false,
    'Open tickets': false,
    'Kitchen printers': false,
    'Customer displays': false,
    'Dining options': false,
    'Low stock notifications': false,
    'Negative stock alerts': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Theme.of(context).colorScheme.secondary), 
          onPressed: () { 
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context)=>const DoneSetting(),
                ),
              );
            }, 
            child: Text('SAVE', style: bodySregular),
          ),
        ],
        
      ),
//Divider(thickness: 1, color: Colors.grey.shade200),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Text('Feature settings', style: heading3Regular),
            const SizedBox(height: 5),
            Text('Choose the features you want to use. You can change these settings later in the Back office.', 
            textAlign: TextAlign.center, style: bodySregular),
            const SizedBox(height: 15),

            _listSettings(
              Icons.access_time_outlined, 
              'Shifts', 
              'Track cash that goes in and out of your drawer',
            ),

            _listSettings(
              Icons.receipt_outlined, 
              'Open tickets', 
              'Allow to save and edit orders before completing a payment',
            ),

            _listSettings(
              Icons.print_rounded, 
              'Kitchen printers', 
              'Send orders to kitchen printer or display',
            ),

            _listSettings(
              Icons.stay_primary_landscape, 
              'Customer displays', 
              'Display order information to customers at the time of purchase',
            ),

            _listSettings(
              Icons.restaurant, 
              'Dining options', 
              'Mark orders as dine in, takeout, or for delivery',
            ),

            _listSettings(
              Icons.mail, 
              'Low stock notifications', 
              'Get daily email on items that are low or out of stock',
            ),

            _listSettings(
              Icons.shopping_basket_rounded, 
              'Negative stock alerts', 
              'Warn cashiers attempting to sell more inventory than available in stock',
            ),
           
          ],
        ),
      ),
    );
  }

  Widget _listSettings (IconData icon, String title, String content){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(icon),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: bodySregular),
              Text(content, style: bodyXSregular, 
              overflow: TextOverflow.ellipsis, maxLines: 2),
            ],
          ),
        ),
        const SizedBox(width: 15),
        Theme(
          data: ThemeData(useMaterial3: false),
          child: Switch(
            value: _switchStates[title]?? false, 
            onChanged: (value){
              setState(() {
                _switchStates[title] = value;
              });
            },
            activeColor: primaryBlue.shade900,
            inactiveTrackColor: Colors.grey,
            activeTrackColor: primaryBlue.shade50,
          ),
        ),
        const SizedBox(height: 60),
      
      ],
    );
  }

  
}