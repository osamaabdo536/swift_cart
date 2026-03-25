import 'package:swift_cart/features/cart/model/cart_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final List<CartItemModel> cartItems;
  CartSuccessState({required this.cartItems});
}

class CartFailureState extends CartState {
  final String errMsg;
  CartFailureState({required this.errMsg});
}

class CartOutOfStockState extends CartState {
  final String productName;
  CartOutOfStockState({required this.productName});
}