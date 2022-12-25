// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:kyahaal/src/common/widgets/input_field.dart';
import 'package:kyahaal/src/features/authentication/business/enums.dart';

typedef RemoteAuthFormConfig
    = Map<AuthenticationFormType, AuthenticationFormData>;

class AuthenticationFormData extends Equatable {
  final String title;
  final String? subtitle;
  final String? subtitleCTAText;
  final String? subtitleCTATLink;
  final String primaryCTAText;
  final String? secondaryCTAText;
  final FormSubmissionMeta formSubmissionMeta;

  final List<AuthenticationField> fields;

  const AuthenticationFormData({
    required this.title,
    required this.formSubmissionMeta,
    this.subtitle,
    this.subtitleCTAText,
    this.subtitleCTATLink,
    this.fields = const [],
    this.primaryCTAText = 'Proceed',
    this.secondaryCTAText,
  });

  AuthenticationFormData copyWith({
    String? title,
    String? subtitle,
    String? subtitleCTAText,
    String? subtitleCTATLink,
    String? primaryCTAText,
    String? secondaryCTAText,
    FormSubmissionMeta? formSubmissionMeta,
    List<AuthenticationField>? fields,
  }) {
    return AuthenticationFormData(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      subtitleCTAText: subtitleCTAText ?? this.subtitleCTAText,
      subtitleCTATLink: subtitleCTATLink ?? this.subtitleCTATLink,
      primaryCTAText: primaryCTAText ?? this.primaryCTAText,
      secondaryCTAText: secondaryCTAText ?? this.secondaryCTAText,
      formSubmissionMeta: formSubmissionMeta ?? this.formSubmissionMeta,
      fields: fields ?? this.fields,
    );
  }

  @override
  List<Object?> get props => [
        fields,
        title,
        subtitle,
        subtitleCTAText,
        subtitleCTATLink,
        formSubmissionMeta,
      ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'subtitle': subtitle,
      'subtitleCTAText': subtitleCTAText,
      'subtitleCTATLink': subtitleCTATLink,
      'primaryCTAText': primaryCTAText,
      'secondaryCTAText': secondaryCTAText,
      'fields': fields.map((x) => x.toMap()).toList(),
      'formSubmissionMeta': formSubmissionMeta.toMap(),
    };
  }

  factory AuthenticationFormData.fromMap(Map<String, dynamic> map) {
    return AuthenticationFormData(
      title: map['title'] as String,
      subtitle: map['subtitle'] != null ? map['subtitle'] as String : null,
      subtitleCTAText: map['subtitleCTAText'] != null
          ? map['subtitleCTAText'] as String
          : null,
      subtitleCTATLink: map['subtitleCTATLink'] != null
          ? map['subtitleCTATLink'] as String
          : null,
      primaryCTAText: map['primaryCTAText'] as String,
      secondaryCTAText: map['secondaryCTAText'] != null
          ? map['secondaryCTAText'] as String
          : null,
      fields: List<AuthenticationField>.from(
        map['fields'].map<AuthenticationField>(
          (x) => AuthenticationField.fromMap(x as Map<String, dynamic>),
        ),
      ),
      formSubmissionMeta: FormSubmissionMeta.fromMap(
        map['formSubmissionMeta'] as Map<String, dynamic>,
      ),
    );
  }
}

class AuthenticationField extends Equatable {
  final InputType inputType;
  final String? label;
  final bool? autofocus;
  final bool bottomGutter;
  final FormValidator validator;
  final String identifier;

  const AuthenticationField({
    this.inputType = InputType.none,
    this.label,
    this.autofocus,
    this.bottomGutter = false,
    required this.validator,
    required this.identifier,
  });

  AuthenticationField copyWith({
    InputType? inputType,
    String? label,
    bool? autofocus,
    bool? bottomGutter,
    FormValidator? validator,
    String? identifier,
  }) {
    return AuthenticationField(
      inputType: inputType ?? this.inputType,
      label: label ?? this.label,
      autofocus: autofocus ?? this.autofocus,
      bottomGutter: bottomGutter ?? this.bottomGutter,
      validator: validator ?? this.validator,
      identifier: identifier ?? this.identifier,
    );
  }

  @override
  List<Object?> get props =>
      [inputType, label, autofocus, bottomGutter, validator];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'inputType': describeEnum(inputType),
      'label': label,
      'autofocus': autofocus,
      'bottomGutter': bottomGutter,
      'validator': validator.toMap(),
    };
  }

  factory AuthenticationField.fromMap(Map<String, dynamic> map) {
    return AuthenticationField(
      inputType: InputType.values
          .lastWhere((element) => describeEnum(element) == map['inputType']),
      label: map['label'] != null ? map['label'] as String : null,
      autofocus: map['autofocus'] != null ? map['autofocus'] as bool : null,
      bottomGutter:
          map['bottomGutter'] != null ? map['bottomGutter'] as bool : false,
      validator: FormValidator.fromMap(map['validator']),
      identifier: map['identifier'],
    );
  }
}

class FormValidator extends Equatable {
  final FormValidatorType validatorType;
  final List<FormRegexValidator>? regExp;

  const FormValidator({
    required this.validatorType,
    required this.regExp,
  });

  FormValidator copyWith({
    FormValidatorType? validatorType,
    List<FormRegexValidator>? regExp,
    String? error,
  }) {
    return FormValidator(
      validatorType: validatorType ?? this.validatorType,
      regExp: regExp ?? this.regExp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'validatorType': describeEnum(validatorType),
      'regExp': regExp.toString(),
    };
  }

  factory FormValidator.fromMap(Map<String, dynamic> map) {
    return FormValidator(
      validatorType: FormValidatorType.values.lastWhere((element) =>
          describeEnum(element) ==
          map['validatorType'].toString().toLowerCase()),
      regExp: map['regExp'] != null
          ? List<FormRegexValidator>.from(
              map['regExp'].map((e) => FormRegexValidator.fromMap(e)))
          : null,
    );
  }

  String? validate(dynamic input) {
    switch (validatorType) {
      case FormValidatorType.regex:
        if (regExp!.isEmpty) return null;
        final errors = regExp!
            .map((exp) => exp.regExp.hasMatch(input)
                ? null
                : exp.error ?? 'Please check your input')
            .where((e) => e != null)
            .toList();
        if (errors.isEmpty) return null;
        return errors.first;
      default:
        return null;
    }
  }

  @override
  List<Object?> get props => [validatorType, regExp];

  @override
  bool get stringify => true;
}

enum FormValidatorType { regex, none }

class FormRegexValidator extends Equatable {
  final RegExp regExp;
  final String? error;

  const FormRegexValidator({
    required this.regExp,
    this.error,
  });

  @override
  List<Object?> get props => [regExp, error];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'regExp': regExp.toString(),
      'error': error,
    };
  }

  factory FormRegexValidator.fromMap(Map<String, dynamic> map) {
    return FormRegexValidator(
      regExp: RegExp(map['regExp']!),
      error: map['error'] != null ? map['error'] as String : null,
    );
  }
}

class FormSubmissionMeta extends Equatable {
  final FormSubmitRequestType method;
  final String url;
  final String? key;

  const FormSubmissionMeta({
    required this.method,
    required this.url,
    this.key,
  });

  FormSubmissionMeta copyWith({
    FormSubmitRequestType? method,
    String? url,
    String? key,
  }) {
    return FormSubmissionMeta(
      method: method ?? this.method,
      url: url ?? this.url,
      key: key ?? this.key,
    );
  }

  @override
  List<Object?> get props => [method, url, key];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'method': describeEnum(method),
      'url': url,
      'key': key,
    };
  }

  factory FormSubmissionMeta.fromMap(Map<String, dynamic> map) {
    return FormSubmissionMeta(
      method: FormSubmitRequestType.values.lastWhere((element) =>
          describeEnum(element) == map['method'].toString().toLowerCase()),
      url: map['url'] as String,
      key: map['key'] != null ? map['key'] as String : null,
    );
  }
}

enum FormSubmitRequestType { post, patch }
