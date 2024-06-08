// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:l/l.dart';
import 'package:sapar/src/core/error/network_exception.dart';
import 'package:sapar/src/core/network/layers/network_executer.dart';
import 'package:sapar/src/core/network/result.dart';
import 'package:sapar/src/features/auth/datasource/auth_api.dart';
import 'package:sapar/src/features/auth/model/favorite_dto.dart';
import 'package:sapar/src/features/auth/model/feedback_dto.dart';
import 'package:sapar/src/features/auth/model/place_dto.dart';
import 'package:sapar/src/features/auth/model/plan_dto.dart';
import 'package:sapar/src/features/auth/model/record_dto.dart';
import 'package:sapar/src/features/auth/model/user_dto.dart';

abstract class IAuthRemoteDS {
  Future<Result<String>> login({
    required String login,
    required String password,
  });

  Future<Result<String>> registration({
    required String phone,
    required String password,
    required String name,
    required String surname,
    required String birthDate,
    required String sex,
    required int region,
  });

  Future<Result<UserDTO>> getUser();

  Future<Result<List<RecordDTO>>> getRegion();

  Future<Result<List<PlaceDTO>>> getAllPlaces();

  Future<Result<PlaceDTO>> getPlaceById({required String id});

  Future<Result<FeedbackDTO>> createFeedback({
    required String comment,
    required int placeId,
  });

  Future<Result<FeedbackDTO>> likeFeedback({
    required String id,
  });

  Future<Result<List<Favorite>?>> likeProduct({
    required String id,
  });

  Future<Result<List<PlanDTO>>> getPlans();

  Future<Result<int>> createPlan({
    required int amount,
    required int placeId,
    required String date,
    required String status,
  });
}

class AuthRemoteDSImpl implements IAuthRemoteDS {
  final NetworkExecuter client;

  AuthRemoteDSImpl({
    required this.client,
  });

  @override
  Future<Result<String>> login({
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

          return Result.success(accessToken);
        },
        failure: (NetworkException exception) =>
            Result<String>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('login remote=> ${NetworkException.type(error: e.toString())}');
      }

      return Result<String>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
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
    try {
      final Result<Map> result = await client.produce(
        route: AuthApi.registration(
          phone: phone,
          password: password,
          name: name,
          surname: surname,
          birthDate: birthDate,
          sex: sex,
          region: region,
        ),
      );
      return result.when(
        success: (response) {
          final accessToken = jsonEncode(response['accessToken']);

          return Result.success(accessToken);
        },
        failure: (NetworkException exception) =>
            Result<String>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('registration remote=> ${NetworkException.type(error: e.toString())}');
      }

      return Result<String>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }

  @override
  Future<Result<UserDTO>> getUser() async {
    try {
      final Result<Map?> result = await client.produce(
        route: const AuthApi.getUser(),
      );

      return result.when(
        success: (Map? response) {
          if (response == null) {
            return const Result.failure(
              NetworkException.type(error: 'Incorrect data parsing!'),
            );
          }

          final UserDTO user =
              UserDTO.fromJson(response as Map<String, dynamic>);

          return Result<UserDTO>.success(user);
        },
        failure: (NetworkException exception) =>
            Result<UserDTO>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('getUser => ${NetworkException.type(error: e.toString())}');
      }
      return Result<UserDTO>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }

  @override
  Future<Result<List<RecordDTO>>> getRegion() async {
    try {
      final Result<Map?> result = await client.produce(
        route: const AuthApi.getRegion(),
      );

      return result.when(
        success: (Map? response) {
          if (response == null) {
            return const Result.failure(
              NetworkException.type(error: 'Incorrect data parsing!'),
            );
          }

          try {
            final List<RecordDTO> regions = (response['records'] as List)
                .map((item) => RecordDTO.fromJson(item as Map<String, dynamic>))
                .toList();

            return Result<List<RecordDTO>>.success(regions);
          } catch (e) {
            return Result.failure(
              NetworkException.type(error: 'Data parsing error: $e'),
            );
          }
        },
        failure: (NetworkException exception) =>
            Result<List<RecordDTO>>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('getRegion => ${NetworkException.type(error: e.toString())}');
      }
      return Result<List<RecordDTO>>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }

  @override
  Future<Result<List<PlaceDTO>>> getAllPlaces() async {
    try {
      final Result<Map?> result = await client.produce(
        route: const AuthApi.getAllPlaces(),
      );

      return result.when(
        success: (Map? response) {
          if (response == null) {
            return const Result.failure(
              NetworkException.type(error: 'Incorrect data parsing!'),
            );
          }
          try {
            final List<PlaceDTO> places = (response['records'] as List)
                .map((item) => PlaceDTO.fromJson(item as Map<String, dynamic>))
                .toList();

            return Result<List<PlaceDTO>>.success(places);
          } catch (e) {
            return Result.failure(
              NetworkException.type(error: 'Data parsing error: $e'),
            );
          }
        },
        failure: (NetworkException exception) =>
            Result<List<PlaceDTO>>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('getAllPlaces => ${NetworkException.type(error: e.toString())}');
      }
      return Result<List<PlaceDTO>>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }

  @override
  Future<Result<PlaceDTO>> getPlaceById({required String id}) async {
    try {
      final Result<Map?> result = await client.produce(
        route: AuthApi.getPlaceById(id: id),
      );

      return result.when(
        success: (Map? response) {
          if (response == null) {
            return const Result.failure(
              NetworkException.type(error: 'Incorrect data parsing!'),
            );
          }
          try {
            final PlaceDTO places =
                PlaceDTO.fromJson(response as Map<String, dynamic>);

            return Result<PlaceDTO>.success(places);
          } catch (e) {
            return Result.failure(
              NetworkException.type(error: 'Data parsing error: $e'),
            );
          }
        },
        failure: (NetworkException exception) =>
            Result<PlaceDTO>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('getPlaceById => ${NetworkException.type(error: e.toString())}');
      }
      return Result<PlaceDTO>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }

  @override
  Future<Result<FeedbackDTO>> createFeedback({
    required String comment,
    required int placeId,
  }) async {
    try {
      final Result<Map?> result = await client.produce(
        route: AuthApi.createFeedback(comment: comment, placeId: placeId),
      );
      return result.when(
        success: (response) {
          if (response == null) {
            return const Result.failure(
              NetworkException.type(error: 'Incorrect data parsing!'),
            );
          }

          final FeedbackDTO feedbackDTO =
              FeedbackDTO.fromJson(response as Map<String, dynamic>);

          return Result.success(feedbackDTO);
        },
        failure: (NetworkException exception) =>
            Result<FeedbackDTO>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('createFeedback remote=> ${NetworkException.type(error: e.toString())}');
      }

      return Result<FeedbackDTO>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }

  @override
  Future<Result<FeedbackDTO>> likeFeedback({
    required String id,
  }) async {
    try {
      final Result<Map?> result = await client.produce(
        route: AuthApi.addLikeToFeedback(id: id),
      );
      return result.when(
        success: (response) {
          if (response == null) {
            return const Result.failure(
              NetworkException.type(error: 'Incorrect data parsing!'),
            );
          }

          final FeedbackDTO feedbackDTO =
              FeedbackDTO.fromJson(response as Map<String, dynamic>);

          return Result.success(feedbackDTO);
        },
        failure: (NetworkException exception) =>
            Result<FeedbackDTO>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('likeFeedback remote=> ${NetworkException.type(error: e.toString())}');
      }

      return Result<FeedbackDTO>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }

  @override
  Future<Result<List<Favorite>?>> likeProduct({
    required String id,
  }) async {
    try {
      final Result<Map?> result = await client.produce(
        route: AuthApi.addLikeToFavorites(id: id),
      );
      return result.when(
        success: (response) {
          if (response == null) {
            return const Result.failure(
              NetworkException.type(error: 'Incorrect data parsing!'),
            );
          }

          final List<Favorite>? places = (response['favorites'] as List?)
              ?.map((item) => Favorite.fromJson(item as Map<String, dynamic>))
              .toList();

          return Result<List<Favorite>>.success(places ?? []);
        },
        failure: (NetworkException exception) =>
            Result<List<Favorite>>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('likeProduct remote=> ${NetworkException.type(error: e.toString())}');
      }

      return Result<List<Favorite>>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }

  @override
  Future<Result<int>> createPlan({
    required int amount,
    required int placeId,
    required String date,
    required String status,
  }) async {
    try {
      final Result<Map> result = await client.produce(
        route: AuthApi.createPlan(
          amount: amount,
          placeId: placeId,
          date: date,
          status: status,
        ),
      );
      return result.when(
        success: (response) {
          log('$response');
          return Result<int>.success(response['id'] as int);
        },
        failure: (NetworkException exception) => Result<int>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('createPlan remote=> ${NetworkException.type(error: e.toString())}');
      }

      return Result<int>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }

  @override
  Future<Result<List<PlanDTO>>> getPlans() async {
    try {
      final Result<List?> result = await client.produce(
        route: const AuthApi.getPlans(),
      );

      return result.when(
        success: (List? response) {
          if (response == null) {
            return const Result.failure(
              NetworkException.type(error: 'Incorrect data parsing!'),
            );
          }
          try {
            final List<PlanDTO> places = response
                .map((item) => PlanDTO.fromJson(item as Map<String, dynamic>))
                .toList();

            return Result<List<PlanDTO>>.success(places);
          } catch (e) {
            return Result.failure(
              NetworkException.type(error: 'Data parsing error: $e'),
            );
          }
        },
        failure: (NetworkException exception) =>
            Result<List<PlanDTO>>.failure(exception),
      );
    } catch (e) {
      if (kDebugMode) {
        l.d('getPlans remote => ${NetworkException.type(error: e.toString())}');
      }
      return Result<List<PlanDTO>>.failure(
        NetworkException.type(error: e.toString()),
      );
    }
  }
}
