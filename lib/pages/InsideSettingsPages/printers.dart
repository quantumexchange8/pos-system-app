/* import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/controller/printerProvider.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideSettingsPages/AddPrinter.dart';
import 'package:pos_system/pages/InsideSettingsPages/EditPrinter.dart';
import 'package:pos_system/widgets/dataModel/printerDataModel.dart';
import 'package:provider/provider.dart';

class PrintersPage extends StatefulWidget {
  const PrintersPage({super.key});

  @override
  State<PrintersPage> createState() => _PrintersPageState();
}

class _PrintersPageState extends State<PrintersPage> {

  
  @override
  Widget build(BuildContext context) {
    final printerProvider = Provider.of<PrinterProvider>(context);
    List<DataPrinter> dataPrinter = printerProvider.printers; 


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
          onPressed: () async {
            final newPrinter = await 
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=> AddPrinter(),
              ),
            );
            if(newPrinter !=null){
              setState(() {
                dataPrinter.add(newPrinter);
              });
            }
          },  
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: dataPrinter.isEmpty? _buildDefaultView():_buildPrinterList(printerProvider.printers, printerProvider),
    );
  }

  Widget _buildDefaultView(){
    return  Padding(
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
    );
  }

  Widget _buildPrinterList(List<DataPrinter>dataPrinter, PrinterProvider printerProvider){
    return ListView.builder(
      itemCount: dataPrinter.length,
      itemBuilder: (context, index){
        final dPrinter = dataPrinter[index];

        return Dismissible(
          key: Key(dPrinter.name), 
          direction: DismissDirection.endToStart,
          background: Container(
            padding: const EdgeInsets.only(right: 15),
            color: Colors.red.shade500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.delete, color: Colors.white),
              ],
            ), 
          ), 
          child: ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: Icon(Icons.print, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Text(dPrinter.name, style: bodySregular),
                  ],
                ),
                Divider(
                  height: 5,
                  color: Colors.grey.shade300, 
                  thickness: 1, 
                  indent: 40, 
                  endIndent: 0,
                ),
              ],
            ),
            onTap: () async {
              final updatedPrinter = await
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=>EditPrinter(dataPrinter: dPrinter)),
              );
              if(updatedPrinter!=null){
                Provider.of<PrinterProvider>(context, listen: false).updatePrinter(dPrinter,updatedPrinter);
              }
            },
          ),
          
        );
      }
    );
  }
} */