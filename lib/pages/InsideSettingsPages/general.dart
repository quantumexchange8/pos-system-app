import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideSettingsPages/screenLayout.dart';
import 'package:pos_system/themes/themes_provider.dart';
import 'package:provider/provider.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  final Map<String, bool> _switchStates = {
    'Use camera to scan barcodes':false,
    'Dark theme':false,
  };

  

  /* void _loadSwitchStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _switchStates['Dark theme'] = prefs.getBool('Dark theme') ?? false;
    });
  }

  void _saveSwitchState(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
 */

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        //mode option


        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('General', style: bodyMregular.copyWith(color: Colors.white),),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
        
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Text('Use camera to scan barcodes', style: bodySregular),
                    Theme(
                      data: ThemeData(useMaterial3: false),
                      child: Switch(
                        value:_switchStates['Use camera to scan barcodes']?? false, 
                        onChanged: (value){
                          setState(() {
                            _switchStates['Use camera to scan barcodes'] = value;
                           
                          });
                        },
                        activeColor: primaryBlue.shade900,
                        inactiveTrackColor: Colors.grey,
                        activeTrackColor: primaryBlue.shade50,
                      ),
                    ),
                  ],
                ),
                     
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dark theme', style: bodySregular),
                    Theme(
                      data: ThemeData(useMaterial3: false),
                      child: Switch(
                        value:_switchStates['Dark theme']?? false, 
                        onChanged: (value){
                          setState(() {
                            _switchStates['Dark theme'] = value;
                            themeProvider.toggleTheme(value);
                           
                          });
                        },
                        activeColor: primaryBlue.shade900,
                        inactiveTrackColor: Colors.grey,
                        activeTrackColor: primaryBlue.shade50,
                      ),
                    ),
                  ],
                ),
                 
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>ScreenLayout())
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Home screen item layout',style: bodySregular),
                      Text('List', style: bodyXSregular),//display the selection
                    ],
                  ),
                ), 
        
                
                ],
            ),
          ),
        );
      }
    );
  }
}