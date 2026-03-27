// features/orders/model/order_model.dart


import 'package:swift_cart/features/cart/model/cart_model.dart';

class OrderModel {
  final String id;
  final List<CartItemModel> items;
  final String phone;
  final String address;
  final String? notes;
  final DateTime dateTime;
  final double totalPrice;

  OrderModel({
    required this.id,
    required this.items,
    required this.phone,
    required this.address,
    this.notes,
    required this.dateTime,
    required this.totalPrice,
  });
}