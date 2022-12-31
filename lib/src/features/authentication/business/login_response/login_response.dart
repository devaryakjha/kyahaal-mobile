import 'package:equatable/equatable.dart';

import '../user.dart';

class LoginResponse extends Equatable {
  final User? user;
  final String? accessToken;
  final int? status;

  const LoginResponse({this.user, this.accessToken, this.status});

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        user: json['user'] == null
            ? null
            : User.fromMap(json['user'] as Map<String, dynamic>),
        accessToken: json['accessToken'] as String?,
        status: json['status'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'user': user?.toMap(),
        'accessToken': accessToken,
        'status': status,
      };

  LoginResponse copyWith({
    User? user,
    String? accessToken,
    int? status,
  }) {
    return LoginResponse(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      status: status ?? this.status,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [user, accessToken, status];
}
