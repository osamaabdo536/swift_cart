class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String? rePassword;
  final String? phone;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    this.rePassword,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'rePassword': rePassword ?? password,
      if (phone != null) 'phone': phone,
    };
  }
}
