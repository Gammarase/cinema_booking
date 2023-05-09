import 'package:cinema_booking/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.id, required super.createdAt, required super.updatedAt, super.name, super.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phoneNumber'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
