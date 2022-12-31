import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyahaal/src/configs/config.dart';
import 'package:kyahaal/src/features/authentication/business/repsitory.dart';
import 'package:kyahaal/src/features/authentication/business/state.dart';
import 'package:kyahaal/src/features/authentication/presentation/bloc/auth_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.repository) : super(const AuthenticationState()) {
    on<Initialse>(_init);
    on<GetRemoteConfig>(_getRemoteConfig);
    on<UpdateFormValues>(_updateFormValues);
    on<SubmitForm>(_submitForm);
    on<Logout>(_logout);
  }

  final AuthenticationRepository repository;

  void _init(Initialse event, Emitter<AuthenticationState> emit) {
    final token = AppConfig.storage
        .getString(AppConfig.strings.accessTokenKey, defaultValue: null);
    if (token != null) {
      emit(state.copyWith(isAuthenticated: true, token: token));
    }
  }

  void _getRemoteConfig(
    GetRemoteConfig event,
    Emitter<AuthenticationState> emit,
  ) async {
    final response = await repository.getRemoteConfig();
    final users = await repository.fetchAllUsers();
    emit(state.copyWith(remoteAuthFormConfig: response, users: users));
  }

  void _updateFormValues(
    UpdateFormValues event,
    Emitter<AuthenticationState> emit,
  ) async {
    var currData = Map.of(state.formValues);
    currData[event.entry.key] = event.entry.value;
    emit(state.copyWith(formValues: currData));
  }

  void _submitForm(
    SubmitForm event,
    Emitter<AuthenticationState> emit,
  ) async {
    final response =
        await repository.submitForm(event.formData, state.formValues);
    if (response.accessToken != null) {
      emit(state.copyWith(isAuthenticated: true, token: response.accessToken));
      AppConfig.router.pushReplacement(AppRoutes.instance.home);
      AppConfig.storage
          .addString(AppConfig.strings.accessTokenKey, response.accessToken!);
    }
  }

  void _logout(
    Logout event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(isAuthenticated: false, token: null));
    await AppConfig.storage.delete(AppConfig.strings.accessTokenKey);
    AppConfig.router.pushReplacement(AppRoutes.instance.login);
    add(GetRemoteConfig());
  }
}
