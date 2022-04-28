import 'dart:convert';

class SignUpBody {
  String email;
  String password;
  String name;
  String phone;
  SignUpBody({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'f_name': name,
      'phone': phone,
    };
  }

}