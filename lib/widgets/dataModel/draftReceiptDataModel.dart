
class DraftReceipt{
   final String name;
   final String price;
   int quantity;
  

  DraftReceipt({
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}