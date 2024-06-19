
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/const/buttonStyle.dart';
import 'package:pos_system/const/constant.dart';
import 'package:pos_system/const/textStyle.dart';

class CashManagement extends StatefulWidget {
  final Function(double, double) onRecordsUpdated;
  const CashManagement({Key?key, required this.onRecordsUpdated}): super(key: key);

 
  @override
  State<CashManagement> createState() => _CashManagementState();
}

class _CashManagementState extends State<CashManagement> {
  bool isFilled = false;
  TextEditingController _amountController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter.currency(
      symbol: 'RM',
      decimalDigits: 2,
    );
  
  // List to hold records
  List<CashInOutRecord> records = [];

  @override
  void dispose() {
    _amountController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _addRecord(String type){
    setState(() {
      double amount = double.parse(_amountController.text.replaceAll('RM','').replaceAll(',', ''));
      records.add(CashInOutRecord(
        time: TimeOfDay.now().format(context),
        owner: 'Owner',
        comment: _commentController.text,
        amount: amount,
        type: type,
      ));
      _amountController.clear();
      _commentController.clear();
      isFilled = false;
    });
    // Pass updated records to Shift page
    double totalPayIn = records
        .where((record) => record.type == 'PAY IN')
        .map((record) => record.amount)
        .fold(0, (sum, amount) => sum + amount);
    double totalPayOut = records
        .where((record) => record.type == 'PAY OUT')
        .map((record) => record.amount)
        .fold(0, (sum, amount) => sum + amount);
    widget.onRecordsUpdated(totalPayIn, totalPayOut);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Cash management', style: bodyMregular.copyWith(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _amountController,
                onChanged: (value) {
                  setState(() {
                    isFilled = value.isNotEmpty;
                  });
                },
                //initialValue: _formatter.formatDouble(0.00),
                inputFormatters: <TextInputFormatter>[
                  _formatter,
                  LengthLimitingTextInputFormatter(12),
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: heading4Regular,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _commentController,
                maxLines: 1,
                maxLength: 25,
                decoration: InputDecoration(
                  labelText: 'Comment',
                  counterText: '',
                  labelStyle: heading4Regular,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: isFilled? BlueOutlineButton(
                      onPressed: () => _addRecord('PAY IN'),
                      text: 'PAY IN'
                    ): CustomOutlineButton(
                      onPressed: (){}, 
                      text: 'PAY IN', 
                      borderColor: Colors.grey, 
                      textColor: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlineButton(
                      onPressed: isFilled? ()=> _addRecord('PAY OUT'): (){}, 
                      text: 'PAY OUT', 
                      borderColor: isFilled? Colors.red: Colors.grey, 
                      textColor: isFilled? Colors.red: Colors.grey,
                    ),
                  ),
                ],
              ),
        
              Divider(thickness: 1, color: Colors.grey.shade300),
              const SizedBox(height:10),
              Text('Pay in/Pay out', style: bodyXSregular.copyWith(color: primaryBlue.shade900),),
              const SizedBox(height: 15),
              ...records.reversed.map((record){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(record.time, style: bodySregular),
                          const SizedBox(width: 10),
                          Text('Owner ${record.comment.isNotEmpty? '- ${record.comment}': ''}', style: bodySregular),
                        ],
                      ),
                      Text('${record.type == 'PAY OUT'? '-' : ''}RM${record.amount.toStringAsFixed(2)}',
                        style:bodySregular, textAlign: TextAlign.end),
                    ],
                  ),
                  );
              }),
        
            ],
          ),
        ),
      ),
    );
  }
}

class CashInOutRecord{
  final String time;
  final String owner;
  final String comment;
  final double amount;
  final String type;

  CashInOutRecord({
    required this.time,
    required this.owner,
    required this.comment,
    required this.amount,
    required this.type,
  });
}