import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_hub/generated/codegen_loader.g.dart';

import 'package:g_hub/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        useFallbackTranslations: true,
        startLocale: Locale('en'), //
        assetLoader: CodegenLoader(),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: Routes.routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ));
  }
}
