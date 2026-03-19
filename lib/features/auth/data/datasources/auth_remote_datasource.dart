import 'package:swift_cart/core/network/api_constants.dart';
import 'package:swift_cart/core/network/api_exception.dart';
import 'package:swift_cart/core/network/api_service.dart';
import 'package:swift_cart/features/auth/data/models/login_request.dart';
import 'package:swift_cart/features/auth/data/models/register_request.dart';
import 'package:swift_cart/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginRequest request);
  Future<UserModel> register(RegisterRequest request);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<UserModel> login(LoginRequest request) async {
    try {
      final response = await apiService.post(
        ApiConstants.login,
        data: request.toJson(),
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<UserModel> register(RegisterRequest request) async {
    try {
      final response = await apiService.post(
        ApiConstants.register,
        data: request.toJson(),
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    // No API endpoint for logout, just clear local storage
    // The repository will handle clearing local data
    return;
  }
}
