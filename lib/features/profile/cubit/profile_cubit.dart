import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_cart/features/auth/domain/repositories/auth_repository.dart'; // تأكدي من المسار
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository repository;

  ProfileCubit({required this.repository}) : super(ProfileInitial());

  Future<void> getUserProfile() async {
    emit(ProfileLoading());
    try {
      final user = await repository.getCurrentUser();
      if (user != null) {
        emit(ProfileSuccess(user: user));
      } else {
        emit(ProfileError(message: "User not found"));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
