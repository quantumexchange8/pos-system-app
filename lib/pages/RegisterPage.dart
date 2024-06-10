import 'package:country_picker_pro/country_picker_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/splashScreenPages/splashScreen.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController countryController = TextEditingController(text: 'Malaysia'); 
  bool _isVisible = false;
  bool isChecked = false;
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateBName = false;

   void _showCountryPicker() {
      CountrySelector(
        context: context,
        countryPreferred: <String>['Malaysia'],
        showPhoneCode: false,
        appBarTitle: "Select your country",
        appBarBackgroundColour: Colors.white,
        appBarTextColour: Colors.black,
        searchBarTextColor: Colors.grey,
        backIconColour: Colors.black,
        searchBarBorderWidth: 1.0,
        searchBarBackgroundColor: Colors.transparent,
        //countryFontStyle: ,
        countryTitleSize: 15,
        onSelect: (country) {
          setState(() {
          countryController.text = country.name;
          });
          
        },
        // Add customization options here
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Registration', style: heading3Regular.copyWith(color: Colors.white)),
        backgroundColor: primaryBlue.shade900,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back arrow icon
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: heading4Regular,
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                errorText: _validateEmail? 'This field cannot be blank' : null,
              ),
            ),
            const SizedBox(height: 30),

            TextField(
              controller: passwordController,
              obscureText: !_isVisible,
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
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                errorText: _validatePassword? 'This field cannot be blank' : null,
              ),
            ),
            const SizedBox(height: 30),

            TextField(
              controller: businessController,
              decoration: InputDecoration(
                labelText: 'Business name',
                labelStyle: heading4Regular,
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                errorText: _validateBName? 'This field cannot be blank' : null,
              ),
            ),
            const SizedBox(height: 30),

            GestureDetector(
              onTap: _showCountryPicker,
              child: AbsorbPointer(
                child: TextField(
                  controller: countryController,
                  decoration: InputDecoration(
                    labelText: 'Country',
                    labelStyle: heading4Regular,
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                  ),
                ),
              ),
              
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: isChecked , 
                  onChanged: (bool? value){
                    setState(() {
                      isChecked = value?? false;
                    });
                  },
                  side: MaterialStateBorderSide.resolveWith((states) => 
                  BorderSide(
                    color: isChecked? primaryBlue.shade300: primaryBlue.shade900
                  ),),
                  checkColor: Colors.white,
                  activeColor: primaryBlue.shade900,
                ),

                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'I agree to Loyverse ', style: bodyXSregular
                        ),                        
                        TextSpan(
                          text: 'Terms of Use ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 10,
                            color: primaryBlue.shade900,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle tap for terms & conditions
                            },
                        ),
                  
                        TextSpan(text: 'and have read and acknowledged ', style: bodyXSregular),
                  
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 10,
                            color: primaryBlue.shade900,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle tap for terms & conditions
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                
              ],
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: BlueButton(
                    onPressed: (){
                      showDialog(
                        context: context, 
                        builder: (context)=> AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.background,
                          title: Text('Thank you for registering!', style: heading3Bold),
                          content: RichText(
                            text: TextSpan(
                              style: bodySregular,
                              children: [
                                TextSpan(
                                  text: 'Please confirm the correctness of your email address. A confirmation letter has been sent to ', 
                                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                                ),
                                TextSpan(
                                  text: '${emailController.text}.',
                                  style: bodySregular.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                                ),
                                TextSpan(
                                  text: '.'),
                              ],
                            ),
                          ),

                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context)=> SplashScreen(),
                                  ),
                                );
                              }, 
                              child: const Text('OK'),
                            ),
                          ],
                        )
                      );
                    }, 
                    text: 'SIGN UP'
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