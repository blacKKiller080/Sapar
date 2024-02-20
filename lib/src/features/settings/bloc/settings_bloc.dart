import 'package:sapar/src/features/settings/model/settings_data.dart';
import 'package:sapar/src/features/settings/repository/settings_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:stream_bloc/stream_bloc.dart';

import '../../app/enum/app_language.dart';
import '../enum/app_theme.dart';

part 'settings_bloc.freezed.dart';

// --- States --- //

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.idle({
    required SettingsData data,
  }) = SettingsStateIdle;

  const factory SettingsState.loading({
    required SettingsData data,
  }) = SettingsStateLoading;

  const factory SettingsState.updatedSuccessfully({
    required SettingsData data,
  }) = SettingsStateUpdatedSuccessfully;

  const factory SettingsState.error({
    required SettingsData data,
    required String description,
  }) = SettingsStateError;
}

// --- Events --- //

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.setTheme({
    required AppTheme theme,
  }) = _SettingsEventSetTheme;

  const factory SettingsEvent.setLocale({
    required AppLanguage locale,
  }) = _SettingsEventSetLocale;
}

// --- BLoC --- //

class SettingsBLoC extends StreamBloc<SettingsEvent, SettingsState> {
  final ISettingsRepository _settingsRepository;

  SettingsBLoC({
    required ISettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(
          SettingsState.idle(
            data: settingsRepository.currentData(),
          ),
        );

  SettingsData get _data => state.data;

  Stream<SettingsState> _performMutation(
    Future<void> Function() body,
  ) async* {
    yield SettingsState.loading(data: _data);
    try {
      await body();
      yield SettingsState.updatedSuccessfully(
        data: _settingsRepository.currentData(),
      );
    } on Object catch (e) {
      yield SettingsState.error(
        data: _data,
        description: e.toString(),
      );
      rethrow;
    } finally {
      yield SettingsState.idle(data: _data);
    }
  }

  Stream<SettingsState> _setTheme(AppTheme theme) => _performMutation(
        () => _settingsRepository.setTheme(theme),
      );

  Stream<SettingsState> _setLocale(AppLanguage locale) => _performMutation(
        () => _settingsRepository.setLocale(locale),
      );

  @override
  Stream<SettingsState> mapEventToStates(SettingsEvent event) => event.when(
        setTheme: _setTheme,
        setLocale: _setLocale,
      );
}
