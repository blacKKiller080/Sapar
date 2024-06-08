import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapar/src/features/auth/model/feedback_dto.dart';

import 'package:sapar/src/features/auth/repository/auth_repository.dart';

part 'feedback_cubit.freezed.dart';

const _tag = "FeedbackCubit";

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit(
    this._authRepository,
  ) : super(const FeedbackState.loadingState());

  final IAuthRepository _authRepository;

  Future<void> createFeedback({
    required String comment,
    required int placeId,
  }) async {
    emit(const FeedbackState.loadingState());
    final result = await _authRepository.createFeedback(
      comment: comment,
      placeId: placeId,
    );

    result.when(
      success: (response) {
        emit(FeedbackState.loadedState(feedbackDTO: response));
        log('loaded feedback from cubit');
      },
      failure: (e) {
        e.maybeWhen(
          orElse: () {
            emit(
              FeedbackState.errorState(message: '$_tag - ${e.msg}'),
            );
          },
        );
      },
    );
  }

  Future<void> likeFeedback({
    required String id,
  }) async {
    emit(const FeedbackState.loadingState());
    final result = await _authRepository.likeFeedback(id: id);

    result.when(
      success: (response) {
        emit(FeedbackState.loadedState(feedbackDTO: response));
        log('liked feedback from cubit');
      },
      failure: (e) {
        e.maybeWhen(
          orElse: () {
            emit(
              FeedbackState.errorState(message: '$_tag - ${e.msg}'),
            );
          },
        );
      },
    );
  }

  @override
  void onChange(Change<FeedbackState> change) {
    log(change.toString(), name: _tag);
    super.onChange(change);
  }
}

@freezed
class FeedbackState with _$FeedbackState {
  const factory FeedbackState.initialState() = _InitialState;

  const factory FeedbackState.loadedState({
    required FeedbackDTO feedbackDTO,
  }) = _LoadedState;

  const factory FeedbackState.loadingState() = _LoadingState;

  const factory FeedbackState.errorState({
    required String message,
  }) = _ErrorState;
}
