import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideSettingsPages/AddPrinter.dart';

class PrintersPage extends StatefulWidget {
  const PrintersPage({super.key});

  @override
  State<PrintersPage> createState() => _PrintersPageState();
}

class _PrintersPageState extends State<PrintersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Printers', style: bodyMregular.copyWith(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=> AddPrinter(),
              ),
            );
          },  
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150, width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                child: Icon(Icons.print, size: 100),
              ),
              const SizedBox(height: 25),
              Text('You have no printers yet', style: heading4Regular),
              const SizedBox(height: 15),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: bodySregular,
                  children: [
                    TextSpan(
                      text: 'Here you can connect your receipt and kitchen printers. ',
                      style: bodySregular.copyWith(color: Theme.of(context).colorScheme.secondary),
                    ),
                    TextSpan(
                      text: 'Learn more',
                      style: bodySregular.copyWith(
                        decoration: TextDecoration.underline,
                        color: primaryBlue.shade800,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle on tap
                        },
                    ),
                  ],
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}