import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/SignInPage.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  bool isValid = false;
  

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot password', style: heading3Regular.copyWith(color: Colors.white)),
        backgroundColor: primaryBlue.shade900,
         iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back arrow icon
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text('Enter your email address to receive instructions to reset password.', style: bodySregular),
            const SizedBox(height: 20),
            TextField(
                  controller: emailController,
                  onChanged: (value) {
                    setState(() {
                      isValid = value.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: heading4Regular,
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: BlueButton(
                      onPressed: isValid? (){
                        if(isValid){
                          showDialog(
                            context: context, 
                            builder: ((context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.background,
                              title: Text('Email sent', style: heading3Bold),
                              content: Text('Check your inbox for further instructions', style: bodySregular),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: (){
                                    Navigator.pushReplacement(context, 
                                    MaterialPageRoute(builder: (context)=> const SignIn()),
                                    );
                                  },
                                  child: Text('OK')
                                ),
                              ],
                            ))
                          );
                         }else(
                          setState(() {
                            isValid = emailController.text.isEmpty;
                          })
                         );
                        }:(){},
                      text: 'SEND',
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}