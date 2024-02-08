// ignore_for_file: avoid-dynamic
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_wrap_architecture/src/core/network/interfaces/base_client_generator.dart';

part 'auth_api.freezed.dart';

@freezed
class AuthApi extends BaseClientGenerator with _$AuthApi {
  const AuthApi._() : super();

  /// Запрос для авторизации
  const factory AuthApi.login({
    required String login,
    required String password,
  }) = _Login;

//
//
//
//
//
//
//
//
//
//
//
//
//

  /// Здесь описываются body для всех запросов
  /// По умолчанию null
  @override
  dynamic get body => whenOrNull(
        login: (login, password) => <String, dynamic>{
          'login': login,
          'password': password,
        },
      );

  /// Используемые методы запросов, по умолчанию 'GET'
  @override
  String get method => maybeWhen(
        orElse: () => 'GET',
        login: (_, __) => 'POST',
      );

  /// Пути всех запросов (после [kBaseUrl])
  @override
  String get path => when(
        login: (_, __) => '/auth/sign-in',
      );

  /// Параметры запросов
  @override
  Map<String, dynamic>? get queryParameters => whenOrNull(
        login: (login, password) => {
          'login': login,
          'password': password,
        },
      );
}
