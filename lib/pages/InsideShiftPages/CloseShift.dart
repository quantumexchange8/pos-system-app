import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/controller/shiftController.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:provider/provider.dart';

class CloseShift extends StatefulWidget {
  final double expectedCashAmount;

  CloseShift({Key? key, required this.expectedCashAmount}) : super(key: key);

  @override
  State<CloseShift> createState() => _CloseShiftState();
}

class _CloseShiftState extends State<CloseShift> {
  double difference = 0.00;
  double actualCash = 0.00; // For actual cash amount

  void _differenceFormula() {
    difference = widget.expectedCashAmount - actualCash;
  }

  @override
  Widget build(BuildContext context) {
    final shiftState = Provider.of<ShiftState>(context);

    _differenceFormula();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 18.0),
        child: Column(
          children: [
            AppBar(
              title: Text('Close shift', style: heading3Regular),
              leading: IconButton(
                icon: Icon(Icons.close, color: Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Divider(color: Colors.grey.shade400),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Display expected and actual cash amounts...
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Expected cash amount', style: bodySregular),
                Text('RM${widget.expectedCashAmount.toStringAsFixed(2)}', style: bodySregular),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Actual cash amount', style: bodySregular),
                Text('RM${actualCash.toStringAsFixed(2)}', style: bodySregular),
              ],
            ),
            Divider(
              color: Colors.grey.shade700,
              thickness: 1,
              indent: 300,
              endIndent: 0,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Difference', style: bodySregular.copyWith(fontWeight: FontWeight.bold)),
                Text('RM${difference.toStringAsFixed(2)}', style: bodySregular.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: BlueOutlineButton(
                    onPressed: () {
                      shiftState.closeShift();
                      Navigator.pop(context);

                      /* Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Shift(onShiftChanged: (bool ) {  },)),
                        (route) => false,
                      ); */
                    },
                    text: 'CLOSE SHIFT',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
