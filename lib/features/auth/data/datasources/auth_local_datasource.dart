import 'package:swift_cart/core/utils/secure_storage_helper.dart';
import 'package:swift_cart/features/auth/data/models/user_model.dart';
import 'dart:convert';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearAuth();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageHelper storageHelper;

  AuthLocalDataSourceImpl({required this.storageHelper});

  @override
  Future<void> saveToken(String token) async {
    await storageHelper.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return await storageHelper.getToken();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await storageHelper.saveUserData(userJson);
  }

  @override
  Future<UserModel?> getUser() async {
    final userJson = await storageHelper.getUserData();
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  @override
  Future<void> clearAuth() async {
    await storageHelper.clearAuthData();
  }
}
