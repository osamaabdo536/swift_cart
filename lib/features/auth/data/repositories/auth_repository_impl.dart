import 'package:swift_cart/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:swift_cart/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:swift_cart/features/auth/data/models/login_request.dart';
import 'package:swift_cart/features/auth/data/models/register_request.dart';
import 'package:swift_cart/features/auth/domain/entities/user_entity.dart';
import 'package:swift_cart/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserEntity> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final userModel = await remoteDataSource.login(request);

    if (userModel.token != null) {
      await localDataSource.saveToken(userModel.token!);
      await localDataSource.saveUser(userModel);
    }

    return UserEntity(
      id: userModel.id,
      email: userModel.email,
      name: userModel.name,
      role: userModel.role,
      phone: userModel.phone,
    );
  }

  @override
  Future<UserEntity> register(
    String name,
    String email,
    String password,
    String? phone,
  ) async {
    final request = RegisterRequest(
      name: name,
      email: email,
      password: password,
      rePassword: password, // API requires rePassword
      phone: phone,
    );
    final userModel = await remoteDataSource.register(request);

    if (userModel.token != null) {
      await localDataSource.saveToken(userModel.token!);
      await localDataSource.saveUser(userModel);
    }

    return UserEntity(
      id: userModel.id,
      email: userModel.email,
      name: userModel.name,
      role: userModel.role,
      phone: userModel.phone,
    );
  }

  @override
  Future<void> logout() async {
    // Clear local storage (API may not have logout endpoint)
    await localDataSource.clearAuth();
  }

  @override
  Future<String?> getToken() async {
    return await localDataSource.getToken();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userModel = await localDataSource.getUser();
    if (userModel != null) {
      return UserEntity(
        id: userModel.id,
        email: userModel.email,
        name: userModel.name,
        role: userModel.role,
        phone: userModel.phone,
      );
    }
    return null;
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
