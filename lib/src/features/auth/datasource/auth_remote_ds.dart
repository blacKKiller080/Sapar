// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:sapar/src/core/error/network_exception.dart';
import 'package:sapar/src/core/network/layers/network_executer.dart';
import 'package:sapar/src/core/network/result.dart';
import 'package:sapar/src/features/auth/datasource/auth_api.dart';

import 'package:l/l.dart';

abstract class IAuthRemoteDS {
  Future<Result<List<Object>>> login({
    required String login,
    required String password,
  });
}

class AuthRemoteDSImpl implements IAuthRemoteDS {
  final NetworkExecuter client;

  AuthRemoteDSImpl({
    required this.client,
  });

  @override
  Future<Result<List<Object>>> login({
    required String login,
    required String password,
  }) async {
    try {
      final Result<Map> result = await client.produce(
        route: AuthApi.login(login: login, password: password),
      );
      return result.when(
        success: (response) {
          final accessToken = jsonEncode(response['accessToken']);
          final refreshToken = jsonEncode(response['refreshToken']);

          return Result.success([accessToken, refreshToken]);
        },
        failure: (NetworkException exception) =>
            Result<List<String>>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('login remote=> ${NetworkException.type(error: e.toString())}');
      }

      return Result<List<String>>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }
}
