import '../model/products_model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductSuccessState extends ProductState {
  final List<ProductModel> products;
  ProductSuccessState({required this.products});
}

class ProductFailureState extends ProductState {
  final String errMsg;
  ProductFailureState({required this.errMsg});
}
