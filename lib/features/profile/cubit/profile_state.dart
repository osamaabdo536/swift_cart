abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final dynamic user;
  ProfileSuccess({required this.user});
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError({required this.message});
}
