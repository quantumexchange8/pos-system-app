import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideSettingsPages/CreateTax.dart';
import 'package:pos_system/pages/InsideSettingsPages/EditTax.dart';

class TaxesPage extends StatefulWidget {
  const TaxesPage({super.key});

  @override
  State<TaxesPage> createState() => _TaxesPageState();
}

class _TaxesPageState extends State<TaxesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Taxes', style: bodyMregular.copyWith(color: Colors.white),),
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
              MaterialPageRoute(builder: (context)=> CreateTax(),
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
                child: Icon(Icons.percent, size: 100),
              ),
              const SizedBox(height: 25),
              Text('You have no taxes in this store yet', style: heading4Regular),
              const SizedBox(height: 25),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: bodySregular,
                  children: [
                    TextSpan(
                      text: 'Taxes can be applied to specific items and are calculated at the time of sale. ',
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

              /* Text('Taxes can be applied to specific items and are calculated at the time of sale.', style: bodySregular),
              TextButton(
                onPressed: (){}, 
                child: Text('Learn more', style: bodySregular.copyWith(decoration: TextDecoration.underline),),
              ), */
          
            ],
          ),
        ),
      ),
    );
  }
}