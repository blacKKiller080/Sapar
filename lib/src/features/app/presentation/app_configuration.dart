import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sapar/src/core/gen/l10n/app_localizations.g.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/presentation/app_router_builder.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/settings/widget/scope/settings_scope.dart';

class AppConfiguration extends StatelessWidget {
  const AppConfiguration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    // final themeMode = SettingsScope.themeModeOf(context, listen: true);
    final locale = SettingsScope.localeOf(context, listen: true);
    final appRouter = AppRouter();

    return AppRouterBuilder(
      createRouter: (context) => appRouter,
      builder: (context, parser, delegate) =>
          // Platform.isAndroid
          //     ?
          MaterialApp.router(
        // routerConfig:
        //     appRouter.config(), // Router config nessecary for deep linking

        routeInformationParser: parser, //conflict with config
        routerDelegate: delegate, //conflict with config

        // onGenerateTitle: (context) => context.localized.appTitle,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.light(),
        theme: AppTheme.light,
        locale: locale,
        // darkTheme: ThemeData.dark(),
        // themeMode: themeMode,
      ),

      //
      //

      // : CupertinoApp.router(
      //     // routerConfig: _appRouter.config(),

      //     routeInformationParser: parser,
      //     routerDelegate: delegate,

      //     // onGenerateTitle: (context) => context.localized.appTitle,
      //     localizationsDelegates: const [
      //       AppLocalizations.delegate,
      //       GlobalMaterialLocalizations.delegate,
      //       GlobalWidgetsLocalizations.delegate,
      //       GlobalCupertinoLocalizations.delegate,
      //     ],
      //     supportedLocales: AppLocalizations.supportedLocales,
      //     debugShowCheckedModeBanner: false,
      //     // theme: ThemeData.light(),
      //     theme: AppTheme.cupertinoLight,

      //     locale: locale,
      //     // darkTheme: ThemeData.dark(),
      //     // themeMode: themeMode,)
      //   ), //FIX ME NEED TO SET CUPERTINO THEME
    );
  }
}
