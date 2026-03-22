import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/api_exception.dart';
import 'category_products_state.dart';

class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  CategoryProductsCubit() : super(CategoryProductsInitial());

  Future<void> getProductsByCategory(String categoryId) async {
    emit(CategoryProductsLoading());
    try {
      final products = await ApiService.instance.getProductsByCategory(
        categoryId,
      );
      emit(CategoryProductsSuccess(products));
    } on ApiException catch (e) {
      emit(CategoryProductsError(e.errorMessage));
    }
  }
}
