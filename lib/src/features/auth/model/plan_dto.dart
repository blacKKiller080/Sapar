import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapar/src/features/auth/model/place_dto.dart';

part 'plan_dto.freezed.dart';
part 'plan_dto.g.dart';

@freezed
class PlanDTO with _$PlanDTO {
  const factory PlanDTO({
    required int id,
    required int amount,
    required DateTime date,
    required String status,
    required PlaceDTO place,
  }) = _PlanDTO;

  factory PlanDTO.fromJson(Map<String, dynamic> json) =>
      _$PlanDTOFromJson(json);
}
