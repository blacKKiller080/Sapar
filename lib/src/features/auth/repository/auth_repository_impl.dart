// ignore_for_file: unused_field

import 'dart:convert';

import 'package:sapar/src/core/network/layers/network_executer.dart';
import 'package:sapar/src/core/network/result.dart';
import 'package:sapar/src/features/auth/database/auth_dao.dart';
import 'package:sapar/src/features/auth/datasource/auth_remote_ds.dart';
import 'package:sapar/src/features/auth/model/favorite_dto.dart';
import 'package:sapar/src/features/auth/model/feedback_dto.dart';
import 'package:sapar/src/features/auth/model/place_dto.dart';
import 'package:sapar/src/features/auth/model/plan_dto.dart';
import 'package:sapar/src/features/auth/model/record_dto.dart';
import 'package:sapar/src/features/auth/model/user_dto.dart';
import 'package:sapar/src/features/auth/repository/auth_repository.dart';

class AuthRepositoryImpl extends IAuthRepository {
  final IAuthRemoteDS _remoteDS;
  final IAuthDao _authDao;
  final NetworkExecuter _client;

  @override
  bool get isAuthenticated => _authDao.user.value != null;

  @override
  UserDTO? get user {
    final userString = _authDao.user.value;

    if (userString != null) {
      final result = jsonDecode(userString) as Map<String, dynamic>;
      final user = UserDTO.fromJson(result);
      return user;
    }

    return null;
  }

  AuthRepositoryImpl({
    required IAuthRemoteDS remoteDS,
    required NetworkExecuter client,
    required AuthDao authDao,
  })  : _remoteDS = remoteDS,
        _authDao = authDao,
        _client = client;

  @override
  Future<Result<String>> login({
    required String login,
    required String password,
  }) async {
    final Result<String> result = await _remoteDS.login(
      login: login,
      password: password,
    );

    result.whenOrNull(
      success: (response) async {
        _authDao.accessToken.setValue(response);
      },
    );

    return result;
  }

  @override
  Future<Result<String>> registration({
    required String phone,
    required String password,
    required String name,
    required String surname,
    required String birthDate,
    required String sex,
    required int region,
  }) async {
    final Result<String> result = await _remoteDS.registration(
      phone: phone,
      password: password,
      name: name,
      surname: surname,
      birthDate: birthDate,
      sex: sex,
      region: region,
    );

    result.whenOrNull(
      success: (response) async {
        _authDao.accessToken.setValue(response);
      },
    );

    return result;
  }

  @override
  Future<Result<UserDTO>> getUser() async {
    final Result<UserDTO> result = await _remoteDS.getUser();

    result.whenOrNull(
      success: (user) {
        _authDao.user.setValue(jsonEncode(user.toJson()));
      },
    );

    return result;
  }

  @override
  Future<Result<List<RecordDTO>>> getRegion() async =>
      await _remoteDS.getRegion();

  @override
  Future<Result<List<PlaceDTO>>> getAllPlaces() async =>
      await _remoteDS.getAllPlaces();

  @override
  Future<Result<PlaceDTO>> getPlaceById({required String id}) async =>
      await _remoteDS.getPlaceById(id: id);

  @override
  Future<Result<FeedbackDTO>> createFeedback({
    required String comment,
    required int placeId,
  }) async =>
      await _remoteDS.createFeedback(comment: comment, placeId: placeId);

  @override
  Future<Result<FeedbackDTO>> likeFeedback({
    required String id,
  }) async =>
      await _remoteDS.likeFeedback(id: id);

  @override
  Future<Result<List<Favorite>?>> likeProduct({
    required String id,
  }) async =>
      await _remoteDS.likeProduct(id: id);

  @override
  Future<Result<List<PlanDTO>>> getPlans() async => await _remoteDS.getPlans();

  @override
  Future<Result<int>> deletePlan({
    required String id,
  }) async =>
      await _remoteDS.deletePlan(id: id);

  @override
  Future<Result<int>> createPlan({
    required int amount,
    required int placeId,
    required String date,
    required String status,
  }) async =>
      await _remoteDS.createPlan(
        amount: amount,
        placeId: placeId,
        date: date,
        status: status,
      );

  @override
  Future<void> setOnboarding({required bool onboarding}) async =>
      _authDao.onboarding.setValue(onboarding);

  @override
  bool getOnboarding() => _authDao.onboarding.value ?? false;

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
