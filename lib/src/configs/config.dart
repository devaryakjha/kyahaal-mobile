import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyahaal/src/features/authentication/business/enums.dart';
import 'package:kyahaal/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:kyahaal/src/features/authentication/presentation/bloc/auth_event.dart';
import 'package:kyahaal/src/features/authentication/presentation/views/pages/authentication.dart';
import 'package:kyahaal/src/features/home/presentation/views/pages/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'router.dart';
part 'theme.dart';
part 'storage.dart';
part 'strings.dart';

class AppConfig {
  static AppStrings strings = AppStrings.instance;
  static AppStorage storage = AppStorage.instance;
  static GoRouter router = _router;
  static AppRoutes routes = AppRoutes.instance;
  static AppTheme theme = AppTheme.instance;
  static GlobalKey<NavigatorState> get navigatorKey =>
      router.routerDelegate.navigatorKey;
}
