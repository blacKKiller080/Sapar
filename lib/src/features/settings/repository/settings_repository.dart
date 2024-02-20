import 'package:sapar/src/features/settings/database/settings_dao.dart';
import 'package:sapar/src/features/settings/enum/app_theme.dart';
import 'package:sapar/src/features/settings/model/settings_data.dart';

import 'package:pure/pure.dart';

import '../../app/enum/app_language.dart';

abstract class ISettingsRepository {
  SettingsData currentData();

  Future<void> setTheme(AppTheme value);

  Future<void> setLocale(AppLanguage locale);
}

class SettingsRepository implements ISettingsRepository {
  final ISettingsDao _settingsDao;

  SettingsRepository({
    required ISettingsDao settingsDao,
  }) : _settingsDao = settingsDao;

  AppTheme? get _theme =>
      AppTheme.values.byName.nullable(_settingsDao.themeMode.value);

  @override
  SettingsData currentData() => SettingsData(
        theme: _theme ?? AppTheme.system,
        locale: _getLocale(),
      );

  AppLanguage _getLocale() {
    final String? str = _settingsDao.locale.value;

    return str != null ? AppLanguage.fromString(str) : AppLanguage.ru;
  }

  @override
  Future<void> setTheme(AppTheme value) async =>
      _settingsDao.themeMode.setValue(value.name);

  @override
  Future<void> setLocale(AppLanguage locale) async =>
      _settingsDao.locale.setValue(locale.name);
}
