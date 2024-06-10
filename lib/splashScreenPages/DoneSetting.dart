import 'package:flutter/material.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/Homepage.dart';

class DoneSetting extends StatefulWidget {
  const DoneSetting({super.key});

  @override
  State<DoneSetting> createState() => _DoneSettingState();
}

class _DoneSettingState extends State<DoneSetting> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(milliseconds: 600),(){
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context)=> const HomePage(),),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryBlue.shade900,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 100, height: 100,
                    child: Image.asset('assets/logo/pos_logo.png', 
                    color: Colors.white, fit: BoxFit.contain,),
                  ),
                ),
                const SizedBox(height: 10),
                Text('LOYVERSE', style: heading3Bold.copyWith(color: Colors.white)),
                Text('POINT OF SALE', style: bodyXSregular.copyWith(color: Colors.white), textAlign: TextAlign.justify),
              ],
            ),
            
          ],
        ),
        
        
      ),
    );
  }
}