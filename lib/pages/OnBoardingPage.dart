import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/RegisterPage.dart';
import 'package:pos_system/pages/SignInPage.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: primaryBlue.shade900,
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo/pos_logo.png', height: 150, width: 150, color: Colors.white),
                    const SizedBox(height: 10),
                    
                    Text('LOYVERSE', style: heading1Bold.copyWith(color: Colors.white)),
                    Text('POINT OF SALE', style: bodyMregular.copyWith(color: Colors.white), textAlign: TextAlign.justify),
                
                  ],
                ),
              ),
            ),
          ),
          
          Expanded(
            flex: 2, 
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: BlueButton(
                          onPressed: (){
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context)=> const RegisterPage(),
                              ),
                            );
                          }, 
                          text: 'REGISTRATION'
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: BlueOutlineButton(
                          onPressed: (){
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context)=> const SignIn(),
                              ),
                            );
                          }, 
                          text: 'SIGN IN',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ),
        ],
      ),
    );
  }
}