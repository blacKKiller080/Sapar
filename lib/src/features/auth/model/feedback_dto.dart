import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_dto.freezed.dart';
part 'feedback_dto.g.dart';

@freezed
class FeedbackDTO with _$FeedbackDTO {
  const factory FeedbackDTO({
    required int id,
    double? rating,
    required String comment,
    required int likes,
  }) = _FeedbackDTO;

  factory FeedbackDTO.fromJson(Map<String, dynamic> json) =>
      _$FeedbackDTOFromJson(json);
}
