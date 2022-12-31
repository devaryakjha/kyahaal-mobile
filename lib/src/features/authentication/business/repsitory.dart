import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kyahaal/src/features/authentication/business/enums.dart';
import 'package:kyahaal/src/features/authentication/business/login_response/login_response.dart';
import 'package:kyahaal/src/features/authentication/business/models.dart';
import 'package:kyahaal/src/features/authentication/business/service.dart';

import 'state.dart';
import 'user.dart';

class AuthenticationRepository {
  final AuthenticationService _service = AuthenticationService.instance;

  Future<RemoteAuthFormConfig> getRemoteConfig() async {
    final response = await _service.getRemoteConfig();
    final mappedResponse = ((response['form'] as Map).entries.map((e) {
      final key = AuthenticationFormType.values
          .lastWhere((element) => describeEnum(element) == e.key);
      return MapEntry(key, AuthenticationFormData.fromMap(e.value));
    }));

    return Map.fromEntries(mappedResponse);
  }

  FutureOr<LoginResponse> submitForm(
    AuthenticationFormData formData,
    FormValues formValues,
  ) async {
    final response = await _service.submitForm(formData, formValues);
    return LoginResponse.fromMap(response.data);
  }

  FutureOr<List<User>> fetchAllUsers() {
    try {
      return _service.fetchAllUsers();
    } catch (e) {
      return [];
    }
  }
}
