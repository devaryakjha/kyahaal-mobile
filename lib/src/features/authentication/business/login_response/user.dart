import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? userId;
  final String? username;
  final String? email;

  const User({this.userId, this.username, this.email});

  factory User.fromMap(Map<String, dynamic> json) => User(
        userId: json['userId'] as int?,
        username: json['username'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'username': username,
        'email': email,
      };

  User copyWith({
    int? userId,
    String? username,
    String? email,
  }) {
    return User(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [userId, username, email];
}
