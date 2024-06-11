import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/textStyle.dart';

class ShiftReport extends StatefulWidget {
  const ShiftReport({super.key});

  @override
  State<ShiftReport> createState() => _ShiftReportState();
}

class _ShiftReportState extends State<ShiftReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 18.0),
        child: Column(
          children: [
            AppBar(
              title: Text('Shift report', style: heading3Regular),
              backgroundColor: Theme.of(context).colorScheme.background,
              iconTheme:IconThemeData(color: Theme.of(context).colorScheme.secondary),
            ),
            Divider(color: Colors.grey.shade400),
          ],
        ),
      ),

      //example of layout
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shift number: 1 ', style: bodySregular),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shift opened: Owner', style: bodySregular),
                  Text('10/06/2024 10:57 am', style: bodySregular),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shift closed: Owner', style: bodySregular),
                  Text('11/06/2024 09:51 am', style: bodySregular),
                ],
              ),
              const SizedBox(height: 20),
              Divider(thickness: 1, color: Colors.grey.shade300),
              const SizedBox(height: 10),
              Text('Cash drawer', 
              style: bodyXSregular.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Starting cash', style: bodySregular),
                  Text('RM0.00', style: bodySregular),
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
                  Text('Paid in', style: bodySregular),
                  Text('RM0.00', style: bodySregular),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Paid out', style: bodySregular),
                  Text('RM0.00', style: bodySregular),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Expected cash amount', style: bodySregular),
                  Text('RM0.00', style: bodySregular),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Actual cash amount', style: bodySregular),
                  Text('RM0.00', style: bodySregular),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Difference', style: bodySregular.copyWith(fontWeight: FontWeight.bold)),
                  Text('RM0.00', style: bodySregular.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              Divider(thickness: 1, color: Colors.grey.shade300),
              const SizedBox(height: 10),
              Text('Sales summary', style: bodyXSregular.copyWith(color: Theme.of(context).colorScheme.primary),),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Gross sales', style: bodySregular.copyWith(fontWeight: FontWeight.bold)),
                  Text('RM0.00', style: bodySregular.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Refunds', style: bodySregular),
                  Text('RM0.00', style: bodySregular),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discounts', style: bodySregular),
                  Text('RM0.00', style: bodySregular),
                ],
              ),
              const SizedBox(height: 10),
              Divider(thickness: 1, color: Colors.grey.shade300),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Net sales', style: bodySregular.copyWith(fontWeight: FontWeight.bold)),
                  Text('RM0.00', style: bodySregular.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}