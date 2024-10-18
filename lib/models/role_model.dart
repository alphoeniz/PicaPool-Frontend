import 'package:picapool/models/auth_model.dart';

class Role {
  final int id;
  final String role;
  final List<Auth>? auth;

  Role({
    required this.id,
    required this.role,
    this.auth,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      role: json['role'],
      auth: json['auth'] != null
          ? (json['auth'] as List).map((a) => Auth.fromJson(a)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'auth': auth?.map((a) => a.toJson()).toList(),
    };
  }
}
