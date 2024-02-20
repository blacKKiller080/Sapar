// ignore_for_file: unused_field

import 'package:sapar/src/core/network/layers/network_executer.dart';
import 'package:sapar/src/core/network/result.dart';
import 'package:sapar/src/features/auth/database/auth_dao.dart';
import 'package:sapar/src/features/auth/datasource/auth_remote_ds.dart';
import 'package:sapar/src/features/auth/repository/auth_repository.dart';

class AuthRepositoryImpl extends IAuthRepository {
  final IAuthRemoteDS _remoteDS;
  final IAuthDao _authDao;
  final NetworkExecuter _client;

  @override
  bool get isAuthenticated => _authDao.user.value != null;

  AuthRepositoryImpl({
    required IAuthRemoteDS remoteDS,
    required NetworkExecuter client,
    required AuthDao authDao,
  })  : _remoteDS = remoteDS,
        _authDao = authDao,
        _client = client;

  @override
  Future<Result<List<Object>>> login({
    required String login,
    required String password,
  }) async {
    final Result<List<Object>> result = await _remoteDS.login(
      login: login,
      password: password,
    );

    result.whenOrNull(
      success: (response) async {
        _authDao.accessToken.setValue(response.first as String);
        _authDao.refreshToken.setValue(response[1] as String);
      },
    );

    return result;
  }

  @override
  Future<bool> clearUser() async {
    final bool userFlag = await _authDao.user.remove();
    // final bool tokenFlag = await _authDao.accessToken.remove();
    // final bool refreshTokenFlag = await _authDao.refreshToken.remove();

    // final bool legalUserFlag = await _authDao.localUser.remove();
    return userFlag;

    // return userFlag && tokenFlag && refreshTokenFlag; //FIX ME
  }
}
