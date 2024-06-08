import 'package:sapar/src/core/network/result.dart';
import 'package:sapar/src/features/auth/model/favorite_dto.dart';
import 'package:sapar/src/features/auth/model/feedback_dto.dart';
import 'package:sapar/src/features/auth/model/place_dto.dart';
import 'package:sapar/src/features/auth/model/plan_dto.dart';
import 'package:sapar/src/features/auth/model/record_dto.dart';
import 'package:sapar/src/features/auth/model/user_dto.dart';

abstract class IAuthRepository {
  /// Статус аутентификации
  bool get isAuthenticated;

  UserDTO? get user;

  Future<bool> clearUser();

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

  Future<Result<PlaceDTO>> getPlaceById({
    required String id,
  });

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

  bool getOnboarding();

  Future<void> setOnboarding({
    required bool onboarding,
  });
}
