// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapar/src/features/auth/model/image_dto.dart';

part 'favorite_dto.freezed.dart';
part 'favorite_dto.g.dart';

@freezed
class Favorite with _$Favorite {
  const factory Favorite({
    required int id,
    required String name,
    required int rating,
    required String description,
    required String ageRestriction,
    required List<ImageDTO>? images,
  }) = _Favorite;

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
}
