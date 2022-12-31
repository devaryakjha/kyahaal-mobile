import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kyahaal/src/common/widgets/input_field.dart';
import 'package:kyahaal/src/common/widgets/typography.dart';
import 'package:kyahaal/src/features/authentication/business/enums.dart';
import 'package:kyahaal/src/features/authentication/business/models.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyahaal/src/features/authentication/business/state.dart';
import 'package:kyahaal/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:kyahaal/src/features/authentication/presentation/bloc/auth_event.dart';

class Authentication extends StatelessWidget {
  Authentication({super.key, required this.formType});
  final AuthenticationFormType formType;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        AuthenticationFormData? formData = state.remoteAuthFormConfig[formType];
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                context.read<AuthenticationBloc>().add(GetRemoteConfig()),
            child: const Icon(Icons.refresh_outlined),
          ),
          body: Visibility(
            visible: formData != null,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: kToolbarHeight + 32,
              ),
              child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formData!.title,
                              style: textheme.headline4
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: formData.subtitle != null,
                          child: Text.rich(
                            TextSpan(
                              text: formData.subtitle,
                              children: [
                                TextSpan(
                                  text: formData.subtitleCTAText,
                                  recognizer: formData.subtitleCTATLink != null
                                      ? (TapGestureRecognizer()
                                        ..onTap = () {
                                          context
                                              .go(formData.subtitleCTATLink!);
                                        })
                                      : null,
                                  style: TextStyle(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            style: textheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(height: 36),
                        ...formData.fields.map((e) {
                          return [
                            if (e.label != null) ...[
                              AppTypography.label(e.label!),
                              const SizedBox(height: 4)
                            ],
                            InputFormField.small(
                              inputType: e.inputType,
                              autofocus: e.autofocus ?? false,
                              validator: e.validator.validate,
                              key: ValueKey(
                                  describeEnum(formType) + e.identifier),
                              onChanged: (value) => context
                                  .read<AuthenticationBloc>()
                                  .add(UpdateFormValues(
                                      MapEntry(e.identifier, value))),
                            ),
                            if (e.bottomGutter) const SizedBox(height: 24),
                          ];
                        }).reduce((value, element) => [...value, ...element]),
                        const SizedBox(height: 48),
                        Wrap(
                          spacing: 24,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  context
                                      .read<AuthenticationBloc>()
                                      .add(SubmitForm(formData));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize:
                                    Size(constraints.maxWidth * 0.468, 56),
                              ),
                              child:
                                  AppTypography.button(formData.primaryCTAText),
                            ),
                            if (formData.secondaryCTAText != null)
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  fixedSize:
                                      Size(constraints.maxWidth * 0.468, 56),
                                ),
                                child: AppTypography(
                                  formData.secondaryCTAText!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
