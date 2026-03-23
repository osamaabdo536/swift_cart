import 'package:swift_cart/features/auth/domain/entities/user_entity.dart';
import 'package:swift_cart/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('Name, email and password are required');
    }

    if (!_isValidEmail(email)) {
      throw Exception('Invalid email format');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    return await repository.register(name, email, password, phone);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
