import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/widget/bloc_scope.dart';
import 'package:sapar/src/features/app/bloc/app_bloc.dart';
import 'package:sapar/src/features/app/enum/app_language.dart';
import 'package:sapar/src/features/settings/bloc/settings_bloc.dart';
import 'package:sapar/src/features/settings/enum/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:pure/pure.dart';

AppTheme _theme(SettingsState state) => state.data.theme;

ThemeMode _themeToThemeMode(AppTheme theme) => theme.when(
      light: () => ThemeMode.light,
      dark: () => ThemeMode.dark,
      system: () => ThemeMode.system,
    );

AppLanguage _locale(SettingsState state) => state.data.locale;

Locale _localeToLocale(AppLanguage locale) => locale.when(
      kk: () => const Locale('kk'),
      ru: () => const Locale('ru'),
      en: () => const Locale('en'),
    );

class SettingsScope extends StatelessWidget {
  final Widget child;

  const SettingsScope({
    required this.child,
    super.key,
  });

  static const BlocScope<SettingsEvent, SettingsState, SettingsBLoC> _scope =
      BlocScope();

  // // --- Data --- //

  static ScopeData<ThemeMode> get themeModeOf =>
      _themeToThemeMode.dot(_theme).pipe(_scope.select);

  static ScopeData<AppTheme> get appThemeOf => _scope.select(_theme);

  static ScopeData<Locale> get localeOf =>
      _localeToLocale.dot(_locale).pipe(_scope.select);

  static ScopeData<AppLanguage> get appLanguageOf => _scope.select(_locale);

  // // --- Methods --- //

  static UnaryScopeMethod<AppTheme> get setTheme => _scope.unary(
        (context, theme) => SettingsEvent.setTheme(theme: theme),
      );

  static UnaryScopeMethod<AppLanguage> get setLocale => _scope.unary(
        (context, locale) => SettingsEvent.setLocale(locale: locale),
      );

  // --- Build --- //

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider<SettingsBLoC>(
            create: (context) => SettingsBLoC(
              settingsRepository: context.repository.settings,
            ),
          ),
          BlocProvider<AppBLoC>(
            create: (context) => AppBLoC(
              context.repository.authRepository,
            ),
          ),
        ],
        child: child,
      );
}
