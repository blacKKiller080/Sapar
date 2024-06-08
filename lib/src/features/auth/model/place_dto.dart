import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapar/src/features/auth/model/address_dto.dart';
import 'package:sapar/src/features/auth/model/contact_dto.dart';
import 'package:sapar/src/features/auth/model/feedback_dto.dart';
import 'package:sapar/src/features/auth/model/image_dto.dart';
import 'package:sapar/src/features/auth/model/region_dto.dart';

part 'place_dto.freezed.dart';
part 'place_dto.g.dart';

@freezed
class PlaceDTO with _$PlaceDTO {
  const factory PlaceDTO({
    required int id,
    required String name,
    required double rating,
    required String description,
    required String ageRestriction,
    required bool liked,
    List<ImageDTO>? images,
    Region? region,
    Address? address,
    List<FeedbackDTO>? feedbacks,
    Contacts? contacts,
  }) = _PlaceDTO;

  factory PlaceDTO.fromJson(Map<String, dynamic> json) =>
      _$PlaceDTOFromJson(json);
}
