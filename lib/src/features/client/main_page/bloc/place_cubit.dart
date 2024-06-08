import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapar/src/features/auth/model/place_dto.dart';

import 'package:sapar/src/features/auth/repository/auth_repository.dart';

part 'place_cubit.freezed.dart';

const _tag = "PlaceCubit";

class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit(
    this._authRepository,
  ) : super(const PlaceState.loadingState());

  final IAuthRepository _authRepository;

  Future<void> getAllPlaces() async {
    emit(const PlaceState.loadingState());
    final result = await _authRepository.getAllPlaces();

    result.when(
      success: (response) {
        emit(PlaceState.loadedAllState(places: response));
        log('loaded places from cubit');
      },
      failure: (e) {
        e.maybeWhen(
          orElse: () {
            emit(
              PlaceState.errorState(message: '$_tag - ${e.msg}'),
            );
          },
        );
      },
    );
  }

  Future<void> getPlaceById({required String id}) async {
    emit(const PlaceState.loadingState());
    final result = await _authRepository.getPlaceById(id: id);

    result.when(
      success: (response) {
        emit(PlaceState.loadedOneState(place: response));
        log('loaded place from cubit');
      },
      failure: (e) {
        e.maybeWhen(
          orElse: () {
            emit(
              PlaceState.errorState(message: '$_tag - ${e.msg}'),
            );
          },
        );
      },
    );
  }

  @override
  void onChange(Change<PlaceState> change) {
    log(change.toString(), name: _tag);
    super.onChange(change);
  }
}

@freezed
class PlaceState with _$PlaceState {
  const factory PlaceState.initialState() = _InitialState;

  const factory PlaceState.loadedAllState({
    required List<PlaceDTO> places,
  }) = _LoadedState;

  const factory PlaceState.loadedOneState({
    required PlaceDTO place,
  }) = _LoadedOneState;

  const factory PlaceState.loadingState() = _LoadingState;

  const factory PlaceState.errorState({
    required String message,
  }) = _ErrorState;
}
