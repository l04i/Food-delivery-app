import 'dart:convert';

class UserModel {
  int id; 
  String name;
  String email;
  String phone;
  int orderCount;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.orderCount,
  });
  


  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ,
      name: map['f_name'] ,
      email: map['email'] ,
      phone: map['phone'] ,
      orderCount: map['order_count'],
    );
  }

}