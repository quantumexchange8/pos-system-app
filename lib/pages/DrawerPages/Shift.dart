import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/DrawerPages/Items.dart';
import 'package:pos_system/pages/DrawerPages/Receipts.dart';
import 'package:pos_system/pages/DrawerPages/Settings.dart';
import 'package:pos_system/pages/Homepage.dart';
import 'package:pos_system/pages/InsideShiftPage.dart/CashManagement.dart';
import 'package:pos_system/pages/InsideShiftPage.dart/ShiftsHistory.dart';
import 'package:pos_system/widgets/appDrawer.dart';
import 'package:intl/intl.dart';

class Shift extends StatefulWidget {
  const Shift({super.key});

  @override
  State<Shift> createState() => _ShiftState();
}

class _ShiftState extends State<Shift> {
  int _selectedIndex = 2;

  int _currentStep = 0;
  String _formattedDateTime = '';

  TextEditingController _amountController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _formattedDateTime = DateFormat('dd/MM/yyyy hh:mma').format(now);
    _amountController.text = CurrencyTextInputFormatter.currency(
      symbol: 'RM',
      decimalDigits: 2,
    ).formatDouble(0.00);
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Receipts(),
            ),
          );
          break;
        case 2:
          
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
              builder: (context) => const Settings(),
            ),
          );
          break;
        // Add more cases if needed
      }
    }
  }

  void _nextStep(){
    setState(() {
      _currentStep++;
    });
  }

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter.currency(
      symbol: 'RM',
      decimalDigits: 2,
    );

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue.shade900,
        title: Text('Shifts', style: bodyMregular.copyWith(color: Colors.white)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: Icon(Icons.history, color: Colors.white), 
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context)=>ShiftsHistory(),
                ),
              );
            },
          ),
        ),
      ],
      ),
      drawer: AppDrawer(selectedIndex: _selectedIndex, onTap: _onItemTapped),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _buildStepContent(),
        ),
      ),
    );
  }


  Widget _buildStepContent(){
    switch (_currentStep){
      case 0:
      return Column(
          children: [
            Text('Specify the cash amount in your drawer at the start of the shift',style: bodySregular),
            const SizedBox(height: 5),
            TextFormField(
              controller: _amountController,
              //initialValue: _formatter.formatDouble(0.00),
              inputFormatters: <TextInputFormatter>[
                _formatter,
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: bodyXSregular,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: BlueOutlineButton(
                    onPressed: (){
                      _nextStep();
                    }, 
                    text: 'OPEN SHIFT',
                  ),
                ),
              ],
            ),
          ],
        );

      case 1:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: BlueOutlineButton(
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context)=>CashManagement(),
                      ),
                    );
                  }, 
                  text: 'CASH MANAGEMENT',
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: BlueOutlineButton(
                  onPressed: (){
                    
                  }, 
                  text: 'CLOSE SHIFT',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text('Shift number: ', style: bodySregular),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shift opened: Owner', style: bodySregular),
              Text(_formattedDateTime, style: bodySregular),
            ],
          ),
          const SizedBox(height: 10),
          Divider(thickness: 1, color: Colors.grey.shade300),
          const SizedBox(height: 10),
          Text('Cash drawer', 
          style: bodyXSregular.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 25),
          Text('Starting cash ${_amountController.text}', style: bodySregular, textAlign: TextAlign.justify),
          const SizedBox(height: 20),
          Text('Cash payments', style: bodySregular),
          const SizedBox(height: 20),
          Text('Cash refunds', style: bodySregular),
          const SizedBox(height: 20),
          Text('Paid in', style: bodySregular),
          const SizedBox(height: 20),
          Text('Paid out', style: bodySregular),
          const SizedBox(height: 20),
          Text('Expected cash amount ${_amountController.text}', style: bodySregular.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Divider(thickness: 1, color: Colors.grey.shade300),
          const SizedBox(height: 10),
          Text('Sales summary', 
          style: bodyXSregular.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 25),
          Text('Gross sales', style: bodySregular.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text('Refunds', style: bodySregular),
          const SizedBox(height: 20),
          Text('Discounts', style: bodySregular),
          const SizedBox(height: 10),
          Divider(thickness: 1, color: Colors.grey.shade300),
          const SizedBox(height: 10),
          Text('Net sales', style: bodySregular.copyWith(fontWeight: FontWeight.bold)),

        ],
      );
  default:
    return Container();

    }
  }
}