class UserEntity {
  final String? id;
  final String email;
  final String name;
  final String? role;
  final String? phone;

  UserEntity({
    this.id,
    required this.email,
    required this.name,
    this.role,
    this.phone,
  });
}
