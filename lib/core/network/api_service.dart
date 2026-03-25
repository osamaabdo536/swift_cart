import 'package:dio/dio.dart';
import 'package:swift_cart/core/network/dio_config.dart';
import 'package:swift_cart/features/cart/model/cart_model.dart';
import 'package:swift_cart/features/product/model/products_model.dart';
import '../../features/category/model/category_model.dart' as cat;
import '../../features/category/model/category_model.dart';
import 'api_constants.dart' show ApiConstants;
import 'api_exception.dart';

class ApiService {
  final Dio _dio = DioConfig.getDio();

  ApiService._();
  static final ApiService instance = ApiService._();

  // Generic methods
  Future<Response> get(String endpoint) async {
    try {
      return await _dio.get(endpoint);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response> post(String endpoint, {Object? data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // Product methods
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await _dio.get(ApiConstants.productsEndPoint);
      return ProductsResponse.fromJson(response.data).data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<ProductModel> getProductById(String productId) async {
    try {
      final response = await _dio.get(
        "${ApiConstants.productsEndPoint}/$productId",
      );
      return ProductModel.fromJson(response.data["data"]);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

 //WISHLIST
  Future<List<String>> addToWishlist(String productId) async {
    try {
      final response = await _dio.post(
        ApiConstants.wishlistEndPoint,
        data: {
          "productId": productId,
        },
      );

      return List<String>.from(response.data["data"]);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<List<String>> removeFromWishlist(String productId) async {
    try {
      final response = await _dio.delete(
        "${ApiConstants.wishlistEndPoint}/$productId",
      );

      return List<String>.from(response.data["data"]);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<List<ProductModel>> getWishlist() async {
    try {
      final response = await _dio.get(ApiConstants.wishlistEndPoint);

      return (response.data["data"] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  //////////Categories/////////

  Future<List<cat.CategoryModel>> getAllCategories() async {
    try {
      final response = await _dio.get(ApiConstants.categoriesEndPoint);
      return CategoriesResponse.fromJson(response.data).data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      final response = await _dio.get(
        ApiConstants.productsEndPoint,
        queryParameters: {'category': categoryId},
      );
      return ProductsResponse.fromJson(response.data).data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  ///Cart
  Future<List<CartItemModel>> getCart() async {
  try {
    final response = await _dio.get(ApiConstants.cartEndPoint);
    final products = response.data['data']['products'] as List;
    return products.map((e) => CartItemModel.fromJson(e)).toList();
  } on DioException catch (e) {
    throw ApiException.fromDioError(e);
  }
}

Future<void> addToCart(String productId) async {
  try {
    await _dio.post(ApiConstants.cartEndPoint, data: {"productId": productId});
  } on DioException catch (e) {
    throw ApiException.fromDioError(e);
  }
}

Future<void> updateQuantity(String productId, int count) async {
  try {
    await _dio.put('${ApiConstants.cartEndPoint}/$productId', data: {"count": count});
  } on DioException catch (e) {
    throw ApiException.fromDioError(e);
  }
}

Future<void> removeFromCart(String productId) async {
  try {
    await _dio.delete('${ApiConstants.cartEndPoint}/$productId');
  } on DioException catch (e) {
    throw ApiException.fromDioError(e);
  }
}

Future<void> clearCart() async {
  try {
    await _dio.delete(ApiConstants.cartEndPoint);
  } on DioException catch (e) {
    throw ApiException.fromDioError(e);
  }
}
}
