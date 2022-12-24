// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'models.dart';

class AuthenticationState extends Equatable {
  final bool isAuthenticated;
  final RemoteAuthFormConfig remoteAuthFormConfig;

  const AuthenticationState({
    this.isAuthenticated = false,
    this.remoteAuthFormConfig = const {},
  });

  AuthenticationState copyWith({
    bool? isAuthenticated,
    RemoteAuthFormConfig? remoteAuthFormConfig,
  }) {
    return AuthenticationState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      remoteAuthFormConfig: remoteAuthFormConfig ?? this.remoteAuthFormConfig,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [isAuthenticated, remoteAuthFormConfig];
}
