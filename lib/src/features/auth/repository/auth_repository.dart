import 'package:flutter_wrap_architecture/src/core/network/result.dart';

abstract class IAuthRepository {
  /// Статус аутентификации
  bool get isAuthenticated;

  Future<bool> clearUser();

  Future<Result<List<Object>>> login({
    required String login,
    required String password,
  });
}
