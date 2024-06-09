// ignore_for_file: avoid-dynamic
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapar/src/core/network/interfaces/base_client_generator.dart';

part 'auth_api.freezed.dart';

@freezed
class AuthApi extends BaseClientGenerator with _$AuthApi {
  const AuthApi._() : super();

  /// Запрос для авторизации
  const factory AuthApi.login({
    required String login,
    required String password,
  }) = _Login;

  const factory AuthApi.registration({
    required String phone,
    required String password,
    required String name,
    required String surname,
    required String birthDate,
    required String sex,
    required int region,
  }) = _Registration;

  const factory AuthApi.getUser() = _GetUser;

  const factory AuthApi.getPlaceById({
    required String id,
  }) = _GetPlaceById;

  const factory AuthApi.getAllPlaces() = _GetAllPlaces;

  const factory AuthApi.getRegion() = _GetRegion;

  const factory AuthApi.getPlans() = _GetPlans;

  const factory AuthApi.deletePlan({
    required String id,
  }) = _DeletePlan;

  const factory AuthApi.createPlan({
    required int amount,
    required int placeId,
    required String date,
    required String status,
  }) = _CreatePlan;

  const factory AuthApi.addLikeToFeedback({
    required String id,
  }) = _AddLikeToFeedback;

  const factory AuthApi.createFeedback({
    required String comment,
    required int placeId,
  }) = _CreateFeedback;

  const factory AuthApi.addLikeToFavorites({
    required String id,
  }) = _AddLikeToFavorites;

//
//
//
//
//
//
//
//
//
//
//
//
//

  /// Здесь описываются body для всех запросов
  /// По умолчанию null
  @override
  dynamic get body => whenOrNull(
        login: (login, password) => jsonEncode(
          <String, dynamic>{
            'phone': login,
            'password': password,
          },
        ),
        registration:
            (phone, password, name, surname, birthDate, sex, region) =>
                jsonEncode(
          <String, dynamic>{
            'phone': phone,
            'password': password,
            'name': name,
            'surname': surname,
            'birthDate': birthDate,
            'sex': sex,
            'region': region,
          },
        ),
        createFeedback: (comment, placeId) => jsonEncode(
          <String, dynamic>{
            'comment': comment,
            'place': placeId,
          },
        ),
        createPlan: (amount, placeId, date, status) => jsonEncode(
          <String, dynamic>{
            'amount': amount,
            'placeId': placeId,
            'date': date,
            'status': status,
          },
        ),
      );

  /// Используемые методы запросов, по умолчанию 'GET'
  @override
  String get method => maybeWhen(
        orElse: () => 'GET',
        login: (_, __) => 'POST',
        registration: (a, b, c, d, e, f, g) => 'POST',
        createFeedback: (comment, placeId) => 'POST',
        createPlan: (a, b, c, d) => 'POST',
        deletePlan: (id) => 'DELETE',
        // addLikeToFavorites: (id) => 'POST',
        // addLikeToFeedback: (id) => "POST",
      );

  /// Пути всех запросов (после [kBaseUrl])
  @override
  String get path => when(
        login: (_, __) => '/auth/login',
        registration: (a, b, c, d, e, f, g) => '/auth/registration',
        getUser: () => '/user/auth/me',
        getRegion: () => '/region',
        addLikeToFeedback: (String id) => '/feedback/$id/like',
        createFeedback: (String comment, int place) => '/feedback/',
        addLikeToFavorites: (String id) => '/user/$id/favorites',
        getPlaceById: (String id) => '/place/$id',
        getAllPlaces: () => '/place',
        getPlans: () => '/plans',
        createPlan: (a, b, c, d) => '/plans',
        deletePlan: (String id) => '/plans/$id',
      );

  /// Параметры запросов
  @override
  Map<String, dynamic>? get queryParameters => whenOrNull();
}
