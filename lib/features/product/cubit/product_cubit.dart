import 'package:bloc/bloc.dart';
import 'package:swift_cart/core/network/api_exception.dart';
import 'package:swift_cart/core/network/api_service.dart';
import 'package:swift_cart/features/product/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState());

  Future<void> getAllProducts() async {
    emit(ProductLoadingState());
    try {
      final products = await ApiService.instance.getAllProducts();
      emit(ProductSuccessState(products: products));
    } on ApiException catch (e) {
      emit(ProductFailureState(errMsg: e.message));
    }
  }

  void searchProducts(String query) {
    final currentState = state;
    if (currentState is ProductSuccessState) {
      if (query.isEmpty) {
        emit(ProductSuccessState(products: currentState.products));
      } else {
        final filtered = currentState.products
            .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
        emit(ProductSuccessState(
          products: currentState.products,
          filteredProducts: filtered,
        ));
      }
    }
  }
}
