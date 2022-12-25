import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyahaal/src/app.dart';
import 'package:kyahaal/src/configs/config.dart';
import 'package:kyahaal/src/features/authentication/business/repsitory.dart';
import 'package:kyahaal/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:kyahaal/src/features/authentication/presentation/bloc/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.storage.init();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => AuthenticationRepository()),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(context.read<AuthenticationRepository>())
                ..add(Initialse()),
        )
      ],
      child: const KyaHaal(),
    ),
  ));
}
