part of 'config.dart';

final _router = GoRouter(
  initialLocation: AppRoutes.instance.home,
  routes: [
    GoRoute(
      path: AppRoutes.instance.home,
      builder: (context, state) => const Home(),
      redirect: (context, state) {
        final token = AppConfig.storage
            .getString(AppConfig.strings.accessTokenKey, defaultValue: null);
        final authBloc = context.read<AuthenticationBloc>();
        final isAuthenticated = authBloc.state.isAuthenticated || token != null;
        if (isAuthenticated) return null;
        authBloc.add(GetRemoteConfig());
        return '/auth/login';
      },
    ),
    GoRoute(
      path: AppRoutes.instance.auth,
      builder: (context, state) => Authentication(
        formType: AuthenticationFormType.values.lastWhere(
          (element) => describeEnum(element) == state.params['form'],
        ),
      ),
    ),
  ],
);

class AppRoutes {
  AppRoutes._();
  static AppRoutes get instance => AppRoutes._();
  final String auth = '/auth/:form';
  final String home = '/home';
}
