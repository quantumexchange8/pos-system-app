import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/textStyle.dart';

class LegalInfo extends StatefulWidget {
  const LegalInfo({super.key});

  @override
  State<LegalInfo> createState() => _LegalInfoState();
}

class _LegalInfoState extends State<LegalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Legal information', style: bodyMregular.copyWith(color: Colors.white),),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
    body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _ItemsListOnTap(
                Icons.text_snippet, 'Terms of use',(){
                  /* Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>(),
                  ),); */
                },
              ),
              _ItemsListOnTap(
                Icons.security, 'Privacy policy', () { 
                  /* Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>(),
                  ),); */
                },
              ),
             
            ],
            ),
          ),
        );
      }

    Widget _ItemsListOnTap(IconData icon, String title, VoidCallback onTap){
      return Column(
        children: [
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: onTap,
              leading: Icon(icon, size: 20),
              title: Text(title, style: bodySregular),
              contentPadding: const EdgeInsets.symmetric(horizontal: 1),
            ),
          ),
          /* GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Icon(icon, size: 20),
                const SizedBox(width: 20),
                Text(title, style: bodySregular),
              ],
            ),
          ), */
          
          Divider(
            //height: 30,
            color: Colors.grey.shade300, 
            thickness: 1, 
            indent: 40, 
            endIndent: 0,
          ),
        ],
      );
  }
}