import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/textStyle.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Help', style: bodyMregular.copyWith(color: Colors.white),),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
    body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _ItemsListOnTap(
                Icons.comment, 'Live chat',(){
                  /* Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>(),
                  ),); */
                },
              ),
              _ItemsListOnTap(
                Icons.help_rounded, 'Help center', () { 
                  /* Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>(),
                  ),); */
                },
              ),
              _ItemsListOnTap(
              Icons.question_answer_outlined, 'Community', () { 
                /* Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>()),
                ); */
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