import 'package:swift_cart/core/network/api_service.dart';
import 'package:swift_cart/core/utils/secure_storage_helper.dart';
import 'package:swift_cart/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:swift_cart/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:swift_cart/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:swift_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:swift_cart/features/auth/domain/usecases/login_usecase.dart';
import 'package:swift_cart/features/auth/domain/usecases/logout_usecase.dart';
import 'package:swift_cart/features/auth/domain/usecases/register_usecase.dart';
import 'package:swift_cart/features/auth/presentation/cubit/auth_cubit.dart';

class AuthInjection {
  // Data sources
  static AuthLocalDataSource get localDataSource =>
      AuthLocalDataSourceImpl(storageHelper: SecureStorageHelper.instance);

  static AuthRemoteDataSource get remoteDataSource =>
      AuthRemoteDataSourceImpl(apiService: ApiService.instance);

  // Repository
  static AuthRepository get repository => AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );

  // Use cases
  static LoginUseCase get loginUseCase => LoginUseCase(repository: repository);
  static RegisterUseCase get registerUseCase =>
      RegisterUseCase(repository: repository);
  static LogoutUseCase get logoutUseCase =>
      LogoutUseCase(repository: repository);

  // Cubit
  static AuthCubit get authCubit => AuthCubit(
    loginUseCase: loginUseCase,
    registerUseCase: registerUseCase,
    logoutUseCase: logoutUseCase,
  );
}
