import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyahaal/src/features/authentication/business/repsitory.dart';
import 'package:kyahaal/src/features/authentication/business/state.dart';
import 'package:kyahaal/src/features/authentication/presentation/bloc/auth_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.repository) : super(const AuthenticationState()) {
    on<GetRemoteConfig>(_getRemoteConfig);
  }
  final AuthenticationRepository repository;

  void _getRemoteConfig(
      GetRemoteConfig event, Emitter<AuthenticationState> emit) async {
    final response = await repository.getRemoteConfig();
    emit(state.copyWith(remoteAuthFormConfig: response));
    log(response.toString());
  }
}
