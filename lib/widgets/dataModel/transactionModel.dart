

import 'package:pos_system/widgets/dataModel/draftReceiptDataModel.dart';

class Transaction {
  final DateTime dateTime;
  final double cashReceived;
  final double totalPrice;
  final double change;
  final List<DraftReceipt> list;
  final bool? isCashPayment;

Transaction({
  required this.dateTime,
  required this.cashReceived,
  required this.totalPrice,
  required this.change,
  required this.list,
  required this.isCashPayment,
});

}