import '../../product/model/products_model.dart';

abstract class CategoryProductsState {}

class CategoryProductsInitial extends CategoryProductsState {}

class CategoryProductsLoading extends CategoryProductsState {}

class CategoryProductsSuccess extends CategoryProductsState {
  final List<ProductModel> products;
  CategoryProductsSuccess(this.products);
}

class CategoryProductsError extends CategoryProductsState {
  final String message;
  CategoryProductsError(this.message);
}
