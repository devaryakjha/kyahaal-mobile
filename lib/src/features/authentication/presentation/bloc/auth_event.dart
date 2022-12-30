import 'package:equatable/equatable.dart';
import 'package:kyahaal/src/features/authentication/business/models.dart';

class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initialse extends AuthenticationEvent {}

class GetRemoteConfig extends AuthenticationEvent {}

class UpdateFormValues extends AuthenticationEvent {
  final MapEntry<String, dynamic> entry;

  UpdateFormValues(this.entry);
}

class SubmitForm extends AuthenticationEvent {
  final AuthenticationFormData formData;

  SubmitForm(this.formData);
}

class Logout extends AuthenticationEvent {}
