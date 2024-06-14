import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class Item{
  final String name;
  final String category;
  final String soldBy;
  final String design;
  final String price;
  final String cost;
  final String sku;
  final String barcode;
  final bool trackStock;
  final String stock;
  final String color;
  final Shape shape;
  final String? imagePath;

  Item({
    required this.name,
    required this.category,
    required this.soldBy,
    required this.design,
    required this.price,
    required this.cost,
    required this.sku,
    required this.barcode,
    required this.trackStock,
    required this.stock,
    required this.color,
    required this.shape,
    this.imagePath,
  });
}