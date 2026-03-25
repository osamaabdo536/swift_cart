import 'package:bloc/bloc.dart';
import 'package:swift_cart/core/network/api_service.dart';
// import 'package:swift_cart/features/product/model/products_model.dart';
import '../model/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  List<CartItemModel> cartItems = [];

  Future<void> getCart() async {
    emit(CartLoadingState());
    try {
      cartItems = await ApiService.instance.getCart();
      emit(CartSuccessState(cartItems: cartItems));
    } catch (e) {
      emit(CartFailureState(errMsg: e.toString()));
    }
  }

  bool isInCart(String productId) {
    return cartItems.any((item) => item.id == productId);
  }

  Future<bool> addToCart(String productId, {int quantity = 1}) async {
    try {
      await ApiService.instance.addToCart(productId);
      await getCart();
      return true;
    } catch (e) {
      emit(CartFailureState(errMsg: e.toString()));
      return false;
    }
  }

  Future<void> updateQuantity(String productId, int newCount) async {
  final oldItems = List<CartItemModel>.from(cartItems);
  final index = cartItems.indexWhere((item) => item.id == productId);
  if (index == -1) return;

  if (newCount <= 0) {
    cartItems.removeAt(index);
  } else {
    cartItems[index].quantity = newCount;
  }
  emit(CartSuccessState(cartItems: List.from(cartItems)));

  try {
    if (newCount <= 0) {
      await ApiService.instance.removeFromCart(productId);
    } else {
      await ApiService.instance.updateQuantity(productId, newCount);
    }
  } catch (e) {
    cartItems = oldItems;
    emit(CartSuccessState(cartItems: List.from(cartItems)));
    emit(CartFailureState(errMsg: "Failed to update quantity"));
  }
}

Future<void> removeFromCart(String productId) async {
  final oldItems = List<CartItemModel>.from(cartItems);

  cartItems.removeWhere((item) => item.id == productId);
  emit(CartSuccessState(cartItems: List.from(cartItems)));

  try {
    await ApiService.instance.removeFromCart(productId);
  } catch (e) {
    cartItems = oldItems;
    emit(CartSuccessState(cartItems: List.from(cartItems)));
    emit(CartFailureState(errMsg: "Failed to remove item"));
  }
}

  Future<void> clearCart() async {
    emit(CartLoadingState());
    try {
      await ApiService.instance.clearCart();
      cartItems.clear();
      emit(CartSuccessState(cartItems:cartItems));
    } catch (e) {
      emit(CartFailureState(errMsg: e.toString()));
    }
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
}