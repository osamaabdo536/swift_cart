import '../../product/model/products_model.dart';

abstract class FavoriteState {}

class FavoriteInitialState extends FavoriteState {}
class FavoriteLoadingState extends FavoriteState {}
class FavoriteSuccessState extends FavoriteState {
  final List<ProductModel> favorites;
  FavoriteSuccessState({required this.favorites});
}
class FavoriteUpdatedState extends FavoriteState {
  final List<ProductModel> favorites;
  FavoriteUpdatedState({required this.favorites});
}
class FavoriteFailureState extends FavoriteState {
  final String errMsg;
  FavoriteFailureState({required this.errMsg});
}