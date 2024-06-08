import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapar/src/features/auth/model/place_dto.dart';
import 'package:sapar/src/features/auth/model/plan_dto.dart';

import 'package:sapar/src/features/auth/repository/auth_repository.dart';

part 'plan_cubit.freezed.dart';

const _tag = "PlanCubit";

class PlanCubit extends Cubit<PlanState> {
  PlanCubit(
    this._authRepository,
  ) : super(const PlanState.loadingState());

  final IAuthRepository _authRepository;

  Future<void> createPlan({
    required int amount,
    required int placeId,
    required String date,
    required String status,
  }) async {
    emit(const PlanState.loadingState());
    final result = await _authRepository.createPlan(
      amount: amount,
      placeId: placeId,
      date: date,
      status: status,
    );

    result.when(
      success: (response) {
        emit(PlanState.loadedState(statusCode: response));
        log('created plan from cubit');
      },
      failure: (e) {
        e.maybeWhen(
          orElse: () {
            emit(
              PlanState.errorState(message: '$_tag - ${e.msg}'),
            );
          },
        );
      },
    );
  }

  Future<void> getPlans() async {
    emit(const PlanState.loadingState());
    final result = await _authRepository.getPlans();

    result.when(
      success: (response) {
        emit(PlanState.loadedAllPlans(places: response));
        log('created plan from cubit');
      },
      failure: (e) {
        e.maybeWhen(
          orElse: () {
            emit(
              PlanState.errorState(message: '$_tag - ${e.msg}'),
            );
          },
        );
      },
    );
  }

  @override
  void onChange(Change<PlanState> change) {
    log(change.toString(), name: _tag);
    super.onChange(change);
  }
}

@freezed
class PlanState with _$PlanState {
  const factory PlanState.initialState() = _InitialState;

  const factory PlanState.loadedState({
    required int statusCode,
  }) = _LoadedState;

  const factory PlanState.loadedAllPlans({
    required List<PlanDTO> places,
  }) = _LoadedAllPlans;

  const factory PlanState.loadingState() = _LoadingState;

  const factory PlanState.errorState({
    required String message,
  }) = _ErrorState;
}
