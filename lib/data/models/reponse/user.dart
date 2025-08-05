import 'package:taskify/util/extensions/string.dart';

class User {
  String? id;
  String? email;
  String? password;

  User({
    this.id,
    this.email,
    this.password,
  });

  factory  User.fromJson(Map<String, dynamic> json) {
    String? password = json['password'];
    return User(
      id: json['id'],
      email: json['email'],
      password: password?.decrypt(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password?.encrypt(),
  };
}