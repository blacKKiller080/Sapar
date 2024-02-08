import 'package:flutter_wrap_architecture/src/core/database/shared_preferences/typed_preferences_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthDao {
  PreferencesEntry<String> get user;

  PreferencesEntry<String> get accessToken;

  PreferencesEntry<String> get refreshToken;
}

class AuthDao extends TypedPreferencesDao implements IAuthDao {
  AuthDao({
    required SharedPreferences sharedPreferences,
  }) : super(sharedPreferences, name: 'auth');

  @override
  PreferencesEntry<String> get user => stringEntry('user');

  @override
  PreferencesEntry<String> get accessToken => stringEntry('accessToken');

  @override
  PreferencesEntry<String> get refreshToken => stringEntry('refreshToken');
}
