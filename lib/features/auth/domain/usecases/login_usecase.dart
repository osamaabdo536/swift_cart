import 'package:swift_cart/features/auth/domain/entities/user_entity.dart';
import 'package:swift_cart/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<UserEntity> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    if (!_isValidEmail(email)) {
      throw Exception('Invalid email format');
    }

    return await repository.login(email, password);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
