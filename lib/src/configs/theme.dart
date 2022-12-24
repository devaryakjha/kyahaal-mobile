part of 'config.dart';

class AppTheme {
  AppTheme._();
  static AppTheme get instance => AppTheme._();
  final ThemeData lightTheme = _lightTheme;
  final ThemeData darkTheme = _darkTheme;
}

final _lightTheme = FlexThemeData.light(
  colors: const FlexSchemeColor(
    primary: Color(0xff3841F2),
    primaryContainer: Color(0xffffffff),
    secondary: Color(0xff343BBF),
    secondaryContainer: Color(0xffffffff),
    tertiary: Color(0xffF2F2F2),
    tertiaryContainer: Color(0xffffffff),
    appBarColor: Color(0xffffffff),
    error: Color(0xffD91414),
  ),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    displayColor: const Color(0xff0D0D0D),
    bodyColor: const Color(0xff0D0D0D),
  ),
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  appBarOpacity: 0.95,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: false,
    inputDecoratorIsFilled: false,
    inputDecoratorUnfocusedBorderIsColored: false,
    defaultRadius: 4,
    elevatedButtonSchemeColor: SchemeColor.background,
    elevatedButtonSecondarySchemeColor: SchemeColor.primary,
    elevatedButtonElevation: 0,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
);

final _darkTheme = FlexThemeData.dark(
  colors: const FlexSchemeColor(
    primary: Color(0xff3841F2),
    primaryContainer: Color(0xffffffff),
    secondary: Color(0xff343BBF),
    secondaryContainer: Color(0xffffffff),
    tertiary: Color(0xffF2F2F2),
    tertiaryContainer: Color(0xffffffff),
    appBarColor: Color(0xffffffff),
    error: Color(0xffD91414),
  ),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    displayColor: const Color(0xff0D0D0D),
    bodyColor: const Color(0xff0D0D0D),
  ),
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 15,
  appBarStyle: FlexAppBarStyle.background,
  appBarOpacity: 0.90,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    inputDecoratorIsFilled: false,
    inputDecoratorUnfocusedBorderIsColored: false,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
);
