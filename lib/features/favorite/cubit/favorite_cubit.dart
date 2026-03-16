import 'package:bloc/bloc.dart';
import '../../product/model/products_model.dart';
import '../../../core/network/api_service.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitialState());

  List<ProductModel> favorites = [];

  // **list of favorite product ids**
  List<String> get favoriteIds => favorites.map((e) => e.id).toList();

  Future<void> getFavorites() async {
    emit(FavoriteLoadingState());
    try {
      favorites = await ApiService.instance.getWishlist();
      emit(FavoriteSuccessState(favorites: favorites));
    } catch (e) {
      emit(FavoriteFailureState(errMsg: e.toString()));
    }
  }

  Future<void> addToFavorite(String productId) async {
    try {
      await ApiService.instance.addToWishlist(productId);
      await getFavorites();
      emit(FavoriteUpdatedState(favorites: favorites));
    } catch (e) {
      emit(FavoriteFailureState(errMsg: e.toString()));
    }
  }

  Future<void> removeFromFavorite(String productId) async {
    try {
      await ApiService.instance.removeFromWishlist(productId);
      favorites.removeWhere((element) => element.id == productId);
      emit(FavoriteUpdatedState(favorites: favorites));
    } catch (e) {
      emit(FavoriteFailureState(errMsg: e.toString()));
    }
  }
}