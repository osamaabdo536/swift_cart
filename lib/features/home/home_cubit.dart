import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/dio_config.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  List<dynamic> categories = [];
  List<dynamic> allProducts = [];
  List<dynamic> filteredProducts = [];
  List<dynamic> brands = [];

  void getHomeData() async {
    emit(HomeLoadingState());

    try {
      var productResponse = await DioConfig.getDio().get("Products");
      var response = await DioConfig.getDio().get("categories");
      var brandResponse = await DioConfig.getDio().get("brands");

      allProducts = productResponse.data['data'];
      categories = response.data['data'];

      filteredProducts = allProducts;
      brands = brandResponse.data['data'];

      emit(HomeSuccessState(filteredProducts, categories, brands));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = allProducts;
    } else {
      filteredProducts = allProducts.where((product) {
        final title = product['title'].toLowerCase();
        final searchLower = query.toLowerCase();
        return title.contains(searchLower);
      }).toList();
    }
    emit(HomeSuccessState(filteredProducts, categories, brands));
  }
}
