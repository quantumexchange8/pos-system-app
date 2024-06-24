import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/const/textStyle.dart';

class SaveReceipt extends StatefulWidget {
  const SaveReceipt({super.key});

  @override
  State<SaveReceipt> createState() => _SaveReceiptState();
}

class _SaveReceiptState extends State<SaveReceipt> {
  TextEditingController nameController = TextEditingController(text: 'Ticket - ${DateFormat.Hm().format(DateTime.now())}');
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 18.0),
        child: Column(
          children: [
            AppBar(
              title: Text('Save ticket', style: heading4Regular),
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                icon: Icon(Icons.close, color: Theme.of(context).colorScheme.secondary),
              ),
              actions: [
                TextButton(
                  onPressed: (){
                    //need to handle save function, havent done
                  }, 
                  child: Text('SAVE', style: bodySregular.copyWith(color: Theme.of(context).colorScheme.primary),),
                ),
              ],
            ),
            Divider(color: Colors.grey.shade400),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: heading4Regular,
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: 'Comment',
                labelStyle: heading4Regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}