import 'package:freezed_annotation/freezed_annotation.dart';
import '../../app/enum/app_language.dart';
import '../enum/app_theme.dart';

part 'settings_data.freezed.dart';

@freezed
class SettingsData with _$SettingsData {
  factory SettingsData({
    required AppTheme theme,
    required AppLanguage locale,
  }) = _SettingsData;
}
