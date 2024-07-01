import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/controller/draftReceiptProvider.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/Payment/checkoutPage.dart';
import 'package:pos_system/Payment/saveReceipt.dart';
import 'package:pos_system/widgets/dataModel/transactionModel.dart';
import 'package:provider/provider.dart';

bool isShiftOpen = true;

class DraftTicket extends StatefulWidget {
  const DraftTicket({super.key});

  @override
  State<DraftTicket> createState() => _DraftTicketState();
}

class _DraftTicketState extends State<DraftTicket> {

  PopupMenuEntry<String> _popUpItem(String value, IconData icon, String title) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 15),
          Text(title),
          // need to action
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final draftReceiptProvider = Provider.of<DraftTicketProvider>(context);
    double totalPrice = 0;
    for (var item in draftReceiptProvider.items){
      final itemPrice = double.parse(item.price.replaceFirst('RM', ''));
      totalPrice += itemPrice * item.quantity;
    }
    List<bool>isSelected = [true, false];

    String getCurrentDateTime(){
      final now = DateTime.now();
      final formatter= DateFormat('HH:mm');
      return formatter.format(now);
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue.shade900,
        title: Row(
          children: [
            Text('Ticket', style: bodyMregular.copyWith(color: Colors.white)),
            const SizedBox(width: 10),
            const Icon(Icons.receipt, color: Colors.white),
          ],
        ),
        leading: IconButton(
          onPressed: () {  
            Navigator.pop(context,totalPrice);
          }, 
          icon: Icon(Icons.arrow_back), 
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.person_add, color: Colors.white),
          ),
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white, // Set the color of the popup menu icon
            ),
            onSelected: (String value) {
              // action
            },
            itemBuilder: (BuildContext context) {
              return [
                _popUpItem('Option 1', Icons.delete, 'Clear ticket'),
                _popUpItem('Option 2', Icons.edit, 'Edit ticket'),
                _popUpItem('Option 3', Icons.contact_mail, 'Assign ticket'),
                _popUpItem('Option 4', Icons.call_merge, 'Merge ticket'),
                _popUpItem('Option 5', Icons.call_split, 'Split ticket'),
                _popUpItem('Option 6', Icons.sync, 'Sync'),
              ];
            },
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: draftReceiptProvider.items.length,
              itemBuilder: (context, index){
                //final draftreceipt = draftReceiptProvider.items[index];
                final item = draftReceiptProvider.items[index];
                final itemPrice = double.parse(item.price.replaceFirst('RM', ''));
                final itemTotalPrice = (itemPrice * item.quantity).toStringAsFixed(2);
            
            
                return Dismissible(
                  key: Key(item.name),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    draftReceiptProvider.removeItem(item);
                  },
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
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(item.name, style: heading4Regular),
                        subtitle: Text('x ${item.quantity}', style: bodySregular),
                        trailing: Text('RM$itemTotalPrice', style: heading4Regular),
                      ),
                      
                      if (index < draftReceiptProvider.items.length - 0)
                        Divider(thickness: 1, color: Colors.grey.shade200), 
                       
                    ],
                  ),
                );
              },
              
            ),
          ),
        ],
      ),

        bottomNavigationBar: BottomAppBar(
          height: 120,
          child: Column(
            children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: heading4Regular),
                  Text('RM${totalPrice.toStringAsFixed(2)}', style: heading3Bold),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleButtons(
                    isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          isShiftOpen = index == 0; // Toggle the shift state
                        });

                      final transactionDetails = Transaction(
                        dateTime: DateTime.now(), 
                        cashReceived: 0.00, 
                        totalPrice: totalPrice, 
                        change: 0.00, 
                        list: draftReceiptProvider.items, 
                        isCashPayment: null,
                      );

                        // Navigate to respective pages based on index
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SaveReceipt(),),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(totalPrice: totalPrice,),
                              settings: RouteSettings(
                                arguments: CheckoutPage(totalPrice: totalPrice),
                              ),
                            ),
                          );
                        }
                      },
                      color: Colors.white, // Default color
                      selectedColor: Colors.white, // Color when selected
                      fillColor: Colors.blue.shade600, // Background color when selected
                      borderRadius: BorderRadius.circular(5),
                      borderWidth: 2,
                    children: [
                      Container(
                        width: 165,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected[0] ?Colors.blue.shade800 : Colors.blue.shade900,
                          ),
                        child: Text('SAVE', style: bodySregular),
                        
                      ),
                      Container(
                        width: 165,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected[1] ?Colors.blue.shade800 : Colors.blue.shade900,
                          ),
                        child: Text('CHARGE \nRM${totalPrice.toStringAsFixed(2)}', style: bodySregular),
                      ),
                    ],
                  ),
                ],
              ),
            ],),
          ),
         
      
    );
  }
}