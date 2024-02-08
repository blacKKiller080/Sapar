import 'package:flutter_wrap_architecture/src/core/database/drift/app_database.dart';
import 'package:flutter_wrap_architecture/src/core/network/layers/network_executer.dart';
import 'package:flutter_wrap_architecture/src/features/auth/database/auth_dao.dart';
import 'package:flutter_wrap_architecture/src/features/auth/datasource/auth_remote_ds.dart';
import 'package:flutter_wrap_architecture/src/features/auth/repository/auth_repository.dart';
import 'package:flutter_wrap_architecture/src/features/auth/repository/auth_repository_impl.dart';

import 'package:flutter_wrap_architecture/src/features/settings/database/settings_dao.dart';
import 'package:flutter_wrap_architecture/src/features/settings/repository/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IRepositoryStorage {
  ISettingsRepository get settings;

  IAuthRepository get authRepository;

  // Data sources
  IAuthRemoteDS get authRemoteDS;
}

class RepositoryStorage implements IRepositoryStorage {
  // ignore: unused_field
  final AppDatabase _appDatabase;
  final SharedPreferences _sharedPreferences;
  final NetworkExecuter _networkExecuter;

  RepositoryStorage({
    required AppDatabase appDatabase,
    required SharedPreferences sharedPreferences,
    required NetworkExecuter networkExecuter,
  })  : _appDatabase = appDatabase,
        _sharedPreferences = sharedPreferences,
        _networkExecuter = networkExecuter;

  ///
  /// Repositories
  ///

  @override
  ISettingsRepository get settings => SettingsRepository(
        settingsDao: SettingsDao(sharedPreferences: _sharedPreferences),
      );

  @override
  IAuthRepository get authRepository => AuthRepositoryImpl(
        remoteDS: authRemoteDS,
        authDao: AuthDao(sharedPreferences: _sharedPreferences),
        client: _networkExecuter,
      );

  ///
  /// Remote datasources
  ///

  @override
  IAuthRemoteDS get authRemoteDS => AuthRemoteDSImpl(client: _networkExecuter);

  // @override
  // AuthLocalDs get authLocalDs => AuthLocalDsImpl(sharedPreferences: _sharedPreferences);
}
