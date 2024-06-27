import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/pages/DrawerPages/Items.dart';
import 'package:pos_system/pages/DrawerPages/Settings.dart';
import 'package:pos_system/pages/DrawerPages/Shift.dart';
import 'package:pos_system/pages/DrawerPages/apps.dart';
import 'package:pos_system/pages/DrawerPages/backOffice.dart';
import 'package:pos_system/pages/DrawerPages/support.dart';
import 'package:pos_system/pages/Homepage.dart';
import 'package:provider/provider.dart';
import 'package:pos_system/Payment/completeReceipt.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/controller/transactionProvider.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/widgets/appDrawer.dart';

class Receipts extends StatefulWidget {
  const Receipts({super.key});

  @override
  State<Receipts> createState() => _ReceiptsState();
}

class _ReceiptsState extends State<Receipts> {
  int _selectedIndex = 1;
  bool isSearching = false;
  TextEditingController _searchController = TextEditingController();
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

   void _onItemTapped(int index) {
    Navigator.pop(context);
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      // Navigate to the appropriate page
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
          break;
        case 1:
          
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Shift(),
            ),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Items(),
            ),
          );
          break;
        case 4:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Settings(),
            ),
          );
          break;
       case 5:
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BackOffice(),
            ),
          );
          break;
        case 6:
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Apps(),
            ),
          );
          break;
        case 7:
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Support(),
            ),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;

    String getCurrentDateTime(){
      final now = DateTime.now();
      final formatter= DateFormat('HH:mm');
      return formatter.format(now);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      onDrawerChanged: (isOpened) {
        FocusScope.of(context).unfocus();
      },
      appBar: AppBar(
        backgroundColor: primaryBlue.shade900,
        title: Text('Receipts', style: bodyMregular.copyWith(color: Colors.white)),
      ),
      drawer: AppDrawer(selectedIndex: _selectedIndex, onTap: _onItemTapped),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Search function
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).colorScheme.background,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                  ),
                  child: const Icon(Icons.search),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).colorScheme.background,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                    onTap: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    onChanged: (value) {
                      // Implement search logic if needed
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).colorScheme.background,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                  ),
                  child: IconButton(
                    icon: isSearching ? const Icon(Icons.close) : const SizedBox(),
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        _searchController.clear();
                        FocusScope.of(context).unfocus();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          // Display receipts or no receipts view
          Expanded(
            child: transactions.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.receipt, size: 100),
                      Text('You have no receipts yet', style: bodySregular),
                    ],
                  )
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final receipt = transactions.reversed.toList()[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text('RM${receipt.totalPrice.toStringAsFixed(2)}', style: heading4Regular),
                            subtitle: Text(getCurrentDateTime(), style: bodySregular),                        
                            trailing:  Text('Receipt no', style: bodySregular),                 
                            //Text('Change: RM${receipt['change'].toStringAsFixed(2)}', style: heading4Regular),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompleteReceipt(transactionDetails: receipt,
                                     //transaction: receipt,
                                  ),
                                ),
                              );
                            },      
                          ),
                          Divider(thickness: 1, color: Colors.grey.shade300),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
