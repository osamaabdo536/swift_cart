import 'package:bloc/bloc.dart';
import 'package:swift_cart/features/auth/domain/usecases/login_usecase.dart';
import 'package:swift_cart/features/auth/domain/usecases/logout_usecase.dart';
import 'package:swift_cart/features/auth/domain/usecases/register_usecase.dart';
import 'package:swift_cart/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(email, password);
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await logoutUseCase();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
