import 'dart:async';

import 'package:dio/dio.dart';

class AuthenticationService {
  AuthenticationService._();
  static final AuthenticationService instance = AuthenticationService._();
  final Dio _dio = Dio();

  FutureOr<Map<String, dynamic>> getRemoteConfig() async {
    return Map.of((await _dio.get('http://localhost:3000/config/app')).data);
  }
}
