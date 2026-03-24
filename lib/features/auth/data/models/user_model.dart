class UserModel {
  final String? id;
  final String email;
  final String name;
  final String? role;
  final String? phone;
  final String? token;

  UserModel({
    this.id,
    required this.email,
    required this.name,
    this.role,
    this.phone,
    this.token,
  });

  // Parse API response: {"message": "success", "user": {...}, "token": "..."}
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Check if response has 'user' object (signin/signup response)
    if (json.containsKey('user') && json.containsKey('token')) {
      final user = json['user'] as Map<String, dynamic>;
      return UserModel(
        id: user['_id']?.toString() ?? user['id']?.toString(),
        email: user['email'] ?? '',
        name: user['name'] ?? '',
        role: user['role'],
        phone: user['phone'],
        token: json['token'],
      );
    }

    // Direct user object (from local storage)
    return UserModel(
      id: json['id']?.toString() ?? json['_id']?.toString(),
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: json['role'],
      phone: json['phone'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'phone': phone,
      'token': token,
    };
  }
}
