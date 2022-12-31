import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'models.dart';
import 'state.dart';
import 'user.dart';

class AuthenticationService {
  AuthenticationService._();
  static final AuthenticationService instance = AuthenticationService._();
  final Dio _dio = Dio();
  final String baseUrl = const String.fromEnvironment('BASE_URL');

  FutureOr<Map<String, dynamic>> getRemoteConfig() async {
    return Map.of((await _dio.get('$baseUrl/config/app')).data);
  }

  Future<Response<T>> submitForm<T>(
    AuthenticationFormData formData,
    FormValues formValues,
  ) async {
    final url = formData.formSubmissionMeta.url;
    final method = formData.formSubmissionMeta.method;
    switch (method) {
      case FormSubmitRequestType.post:
        return _dio.post<T>('$baseUrl$url', data: formValues);
      default:
        return _dio.patch<T>('$baseUrl$url', data: formValues);
    }
  }

  FutureOr<List<User>> fetchAllUsers() async {
    try {
      return ((await _dio.get('$baseUrl/auth/all')).data['users'] as List)
          .map<User>((e) => User.fromMap(e))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
