// To parse this JSON data, do
//
//     final userDto = userDtoFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_dto.freezed.dart';
part 'image_dto.g.dart';

@freezed
class ImageDTO with _$ImageDTO {
  const factory ImageDTO({
    required int id,
    required String url,
    String? secureUrl,
  }) = _ImageDTO;

  factory ImageDTO.fromJson(Map<String, dynamic> json) =>
      _$ImageDTOFromJson(json);
}
