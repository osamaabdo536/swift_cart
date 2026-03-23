import 'package:swift_cart/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(
    String name,
    String email,
    String password,
    String? phone,
  );
  Future<void> logout();
  Future<String?> getToken();
  Future<UserEntity?> getCurrentUser();
  Future<bool> isLoggedIn();
}
