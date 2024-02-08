// ignore_for_file: avoid_classes_with_only_static_members, avoid_redundant_argument_values
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_wrap_architecture/src/core/enum/environment.dart';
import 'package:flutter_wrap_architecture/src/features/app/logic/not_auth_logic.dart';
import 'package:flutter_wrap_architecture/src/features/auth/database/auth_dao.dart';
import 'package:flutter_wrap_architecture/src/features/settings/database/settings_dao.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Creates new `Dio` instance
@sealed
class DioModule {
  DioModule._();

  /// Конфигурация Dio
  static Dio configureDio({
    required AuthDao authDao,
    required PackageInfo packageInfo,
    required ISettingsDao settings,
  }
      // IUserRepository userRepository,
      ) {
    final dio = Dio();

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    }; //FIX ME USED FOR DEBUG ONLY

    final String? localeValue = settings.locale.value;
    dio
      ..options.baseUrl = kBaseUrl
      ..options.headers.addAll({
        // 'contentType': 'multipart/form-data',
        // 'content-type': 'multipart/form-data',
        'accept': 'application/json',
        'version': packageInfo.version,
        if (localeValue != null) 'Content-language': localeValue,
      })
      ..interceptors.addAll([
        // LogOutInterceptor(userRepository),
        _AuthDioInterceptor(authDao),
        if (kDebugMode)
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: false,
            responseHeader: true,
            compact: false,
          ),
      ]);
    // dio.httpClientAdapter = HttpClientAdapter();
    // // dio.transformer = DefaultTransformer();
    // dio.transformer = BackgroundTransformer();
    return dio;
  }
}

class _AuthDioInterceptor extends Interceptor {
  final AuthDao _authDao;
  _AuthDioInterceptor(this._authDao);

  // Dio dio = Dio(BaseOptions(baseUrl: SERVER_));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final String? userStr = _authDao.user.value;
    // if (userStr != null) {
    //   final UserDTO user =
    //       UserDTO.fromJson(jsonDecode(userStr) as Map<String, dynamic>);
    //   if (user.accessToken != null) {
    //     options.headers['Authorization'] = 'Bearer ${user.accessToken}';
    //   }
    // }

    if (_authDao.accessToken.value != null) {
      final accessToken = _authDao.accessToken.value?.replaceAll('"', '');
      // final refreshToken = _authDao.refreshToken.value?.replaceAll('"', '');

      // final hasExpired = JwtDecoder.isExpired(accessToken!);

      // if (hasExpired) {
      //   options.headers['Authorization'] = 'Bearer $refreshToken';
      // } else {
      options.headers['Authorization'] = 'Bearer $accessToken';
      // }
    }

    options.headers['Accept'] = "application/json";

    // options.headers['Content-Language'] = locale.replaceAll('kk', 'kz');
    super.onRequest(options, handler);
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    // sl<NotAuthLogic>().statusSubject.add(err.response?.statusCode ?? 0);
    if ((err.response?.statusCode ?? 0) == HttpStatus.unauthorized) {
      NotAuthLogic().statusSubject.add(401);
    } else if ((err.response?.statusCode ?? 0) ==
        HttpStatus.unprocessableEntity) {
    } else if ((err.response?.statusCode ?? 0) == HttpStatus.notFound) {}
    return super.onError(err, handler);
  }
}
