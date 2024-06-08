// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapar/src/features/auth/model/favorite_dto.dart';
import 'package:sapar/src/features/auth/model/feedback_dto.dart';
import 'package:sapar/src/features/auth/model/region_dto.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDTO with _$UserDTO {
  const factory UserDTO({
    required int id,
    required String phone,
    required String name,
    required String surname,
    required DateTime birthDate,
    required String sex,
    required List<FeedbackDTO> likedFeedbacks,
    required List<Favorite> favorites,
    required Region region,
  }) = _UserDTO;

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  // @override
  // UserDTO fromJson(Map<String, dynamic> json) => UserDTO.fromJson(json);
}
