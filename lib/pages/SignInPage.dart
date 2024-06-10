import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/ForgotPassword.dart';
import 'package:pos_system/splashScreenPages/DoneSetting.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isVisible = false;
  bool _validateEmail = false;
  bool _validatePassword = false;

   @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool get _isFormValid{
    return emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  void _updateButtonState() {
    setState(() {});
  }

  void _signIn() {
    setState(() {
      _validateEmail = emailController.text.isEmpty;
      _validatePassword = passwordController.text.isEmpty;
    });
    if (_isFormValid) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DoneSetting(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in', style: heading3Regular.copyWith(color: Colors.white)),
        backgroundColor: primaryBlue.shade900,
         iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back arrow icon
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
                controller: emailController,
                onChanged: (value) {
                  _updateButtonState();
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: heading4Regular,
                  errorText: _validateEmail? 'This field cannot be blank' : null,
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                ),
              ),
              const SizedBox(height: 30),
        
              TextField(
                controller: passwordController,
                obscureText: !_isVisible,
                onChanged: (value) {
                  _updateButtonState();
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: _isVisible? const Icon(Icons.visibility_outlined):const Icon(Icons.visibility_off_outlined),
                          ),
                  labelText: 'Password',
                  labelStyle: heading4Regular,
                  errorText: _validatePassword? 'This field cannot be blank' : null,
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                ),
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: BlueButton(
                      onPressed: _isFormValid? _signIn:(){
                        setState(() {
                        _validateEmail = emailController.text.isEmpty;
                        _validatePassword = passwordController.text.isEmpty;
                      });
                      }, 
                      text: 'SIGN IN',
                    ),
                  ),
                ],
              ),

              TextButton(
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=>const ForgotPassword(),
                    ),
                  );
                }, 
                child: Text('Forgot password?', style: bodySregular),
              ),
          ],
        ),
      ),
    );
  }
}