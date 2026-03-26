import '../model/products_model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductSuccessState extends ProductState {
  final List<ProductModel> products;
  final List<ProductModel> filteredProducts;

  ProductSuccessState({required this.products, List<ProductModel>? filteredProducts})
      : filteredProducts = filteredProducts ?? products;
}

class ProductFailureState extends ProductState {
  final String errMsg;
  ProductFailureState({required this.errMsg});
}