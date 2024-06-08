// To parse this JSON data, do
//
//     final userDto = userDtoFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapar/src/features/auth/model/place_dto.dart';

part 'record_dto.freezed.dart';
part 'record_dto.g.dart';

@freezed
class RecordDTO with _$RecordDTO {
  const factory RecordDTO({
    required int id,
    required String name,
    required List<PlaceDTO>? places,
  }) = _RecordDTO;

  factory RecordDTO.fromJson(Map<String, dynamic> json) =>
      _$RecordDTOFromJson(json);
}
