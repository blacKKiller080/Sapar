import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapar/src/features/auth/model/favorite_dto.dart';

import 'package:sapar/src/features/auth/repository/auth_repository.dart';

part 'favorite_cubit.freezed.dart';

const _tag = "FavoriteCubit";

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(
    this._authRepository,
  ) : super(const FavoriteState.loadingState());

  final IAuthRepository _authRepository;

  Future<void> likeProduct({
    required String id,
  }) async {
    emit(const FavoriteState.loadingState());
    final result = await _authRepository.likeProduct(id: id);

    result.when(
      success: (response) {
        emit(FavoriteState.loadedState(favorites: response ?? []));
        log('liked product from cubit');
      },
      failure: (e) {
        e.maybeWhen(
          orElse: () {
            emit(
              FavoriteState.errorState(message: '$_tag - ${e.msg}'),
            );
          },
        );
      },
    );
  }

  @override
  void onChange(Change<FavoriteState> change) {
    log(change.toString(), name: _tag);
    super.onChange(change);
  }
}

@freezed
class FavoriteState with _$FavoriteState {
  const factory FavoriteState.initialState() = _InitialState;

  const factory FavoriteState.loadedState({
    required List<Favorite> favorites,
  }) = _LoadedState;

  const factory FavoriteState.loadingState() = _LoadingState;

  const factory FavoriteState.errorState({
    required String message,
  }) = _ErrorState;
}
