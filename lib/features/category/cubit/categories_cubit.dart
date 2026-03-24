import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_cart/core/network/api_service.dart';
import '../../../core/network/api_exception.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    try {
      final categories = await ApiService.instance.getAllCategories();
      emit(CategoriesSuccess(categories));
    } on ApiException catch (e) {
      emit(CategoriesError(e.message));
    }
  }
}
