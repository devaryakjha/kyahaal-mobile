// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'models.dart';
import 'user.dart';

typedef FormValues = Map<String, dynamic>;

class AuthenticationState extends Equatable {
  final bool isAuthenticated;
  final RemoteAuthFormConfig remoteAuthFormConfig;
  final FormValues formValues;
  final bool isAuthenticating;
  final String? token;
  final List<User> users;

  const AuthenticationState({
    this.isAuthenticated = false,
    this.remoteAuthFormConfig = const {},
    this.formValues = const {},
    this.isAuthenticating = false,
    this.token,
    this.users = const [],
  });

  AuthenticationState copyWith({
    bool? isAuthenticated,
    RemoteAuthFormConfig? remoteAuthFormConfig,
    FormValues? formValues,
    bool? isAuthenticating,
    String? token,
    List<User>? users,
  }) =>
      AuthenticationState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        remoteAuthFormConfig: remoteAuthFormConfig ?? this.remoteAuthFormConfig,
        formValues: formValues ?? this.formValues,
        isAuthenticating: isAuthenticating ?? this.isAuthenticating,
        token: token ?? this.token,
        users: users ?? this.users,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        isAuthenticated,
        remoteAuthFormConfig,
        formValues,
        token,
      ];
}
