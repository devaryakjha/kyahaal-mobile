import 'package:flutter/material.dart';
import 'package:kyahaal/src/configs/config.dart';

class KyaHaal extends StatelessWidget {
  const KyaHaal({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        routerConfig: AppConfig.router,
        title: 'KyaHaal',
        debugShowCheckedModeBanner: false,
        theme: AppConfig.theme.lightTheme,
        darkTheme: AppConfig.theme.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
