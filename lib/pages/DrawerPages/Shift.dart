import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/controller/shiftController.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/DrawerPages/Items.dart';
import 'package:pos_system/pages/DrawerPages/Receipts.dart';
import 'package:pos_system/pages/DrawerPages/Settings.dart';
import 'package:pos_system/pages/DrawerPages/apps.dart';
import 'package:pos_system/pages/DrawerPages/backOffice.dart';
import 'package:pos_system/pages/DrawerPages/support.dart';
import 'package:pos_system/pages/Homepage.dart';
import 'package:pos_system/pages/InsideShiftPages/CashManagement.dart';
import 'package:pos_system/pages/InsideShiftPages/CloseShift.dart';
import 'package:pos_system/pages/InsideShiftPages/ShiftsHistory.dart';
import 'package:pos_system/widgets/appDrawer.dart';
import 'package:provider/provider.dart';

class Shift extends StatefulWidget {
  
  const Shift({super.key});

  @override
  State<Shift> createState() => _ShiftState();
}

class _ShiftState extends State<Shift> {
  double totalPayIn = 0.00;
  double totalPayOut = 0.00;
  double expectedCashAmount = 0.00;
  double startingCash = 0.00;

  // Method to update total pay in and pay out amounts
  void _updateTotals(double payIn, double payOut) {
    setState(() {
      totalPayIn = payIn;
      totalPayOut = payOut;
      _expectedCashFormula();
    });
  }

  void _expectedCashFormula() {
    // expected cash amount = starting cash + paid in - paid out
    setState(() {
      expectedCashAmount = startingCash + totalPayIn - totalPayOut;
    });
  }

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
    _expectedCashFormula();
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Receipts(),
            ),
          );
          break;
        case 2:
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Items(),
            ),
          );
          break;
        case 4:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Settings(),
            ),
          );
          break;
        case 5:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BackOffice(),
            ),
          );
          break;
        case 6:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Apps(),
            ),
          );
          break;
        case 7:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Support(),
            ),
          );
          break;
      }
    }
  }

 
  /* void _closeShift() {
    setState(() {
      _currentStep = 0; // Reset to the initial step when shift is closed
      widget.onShiftChanged(false); //Notify parent of shift close
    });
  } */

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter.currency(
    symbol: 'RM',
    decimalDigits: 2,
  );

  @override
  Widget build(BuildContext context) {
    final shiftState = Provider.of<ShiftState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue.shade900,
        title: Text('Shifts', style: bodyMregular.copyWith(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.history, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShiftsHistory()),
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
          child: _buildStepContent(shiftState),
        ),
      ),
    );
  }

  Widget _buildStepContent(ShiftState shiftState) {
    switch (shiftState.isShiftOpen) {
      case true:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: BlueOutlineButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CashManagement(
                            onRecordsUpdated: _updateTotals,
                          ),
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
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CloseShift(
                            expectedCashAmount: expectedCashAmount,
                          ),
                        ),
                      ); // Reset state after closing shift
                    },
                    text: 'CLOSE SHIFT',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('Shift number: 1', style: bodySregular),
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
            Text('Cash drawer', style: bodyXSregular.copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Starting cash', style: bodySregular),
                Text(_amountController.text, style: bodySregular),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cash payments', style: bodySregular),
                Text('RM0.00', style: bodySregular),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cash refunds', style: bodySregular),
                Text('RM0.00', style: bodySregular),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total pay in', style: bodySregular),
                Text('RM${totalPayIn.toStringAsFixed(2)}', style: bodySregular),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total pay out', style: bodySregular),
                Text('RM${totalPayOut.toStringAsFixed(2)}', style: bodySregular),
              ],
            ),
            Divider(color: Colors.grey.shade700, thickness: 1, indent: 300, endIndent: 0),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Expected cash amount', style: bodySregular),
                Text('RM${expectedCashAmount.toStringAsFixed(2)}', style: bodySregular),
              ],
            ),
          ],
        );
      default:
        return Column(
          children: [
            Text('Specify the cash amount in your drawer at the start of the shift', style: bodySregular),
            const SizedBox(height: 5),
            TextFormField(
              controller: _amountController,
              inputFormatters: <TextInputFormatter>[
                _formatter,
                LengthLimitingTextInputFormatter(12),
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: bodyXSregular,
              ),
              onChanged: (value) {
                setState(() {
                  startingCash = (_formatter.getUnformattedValue()).toDouble() ?? 0.00;
                  _expectedCashFormula();
                });
              },
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: BlueOutlineButton(
                    onPressed: () {
                        setState(() {
                          _currentStep++;
                          shiftState.openShift();
                          //widget.onShiftChanged(true); //Notify parent of shift open
                        });
                    },
                    text: 'OPEN SHIFT',
                  ),
                ),
              ],
            ),
          ],
        );
     
    }
  }
}
