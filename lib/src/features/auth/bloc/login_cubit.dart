import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapar/src/features/auth/model/record_dto.dart';
import 'package:sapar/src/features/auth/model/user_dto.dart';

import 'package:sapar/src/features/auth/repository/auth_repository.dart';

part 'login_cubit.freezed.dart';

const _tag = "LoginCubit";

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    this._authRepository,
  ) : super(const LoginState.loadingState());

  final IAuthRepository _authRepository;

  Future<void> login({
    required String login,
    required String password,
  }) async {
    emit(const LoginState.loadingState());
    final result = await _authRepository.login(
      login: login,
      password: password,
    );

    result.when(
      success: (response) {
        emit(LoginState.tokenState(accessToken: response));
      },
      failure: (e) {
        e.maybeWhen(
          orElse: () {
            emit(
              LoginState.errorState(
                message: '${e.msg}',
                loginErrorMessage: 'Неверный ИИН',
                passwordErrorMessage: 'Неверный пароль',
              ),
            );
          },
        );
      },
    );
  }

  Future<void> registration({
    required String phone,
    required String password,
    required String name,
    required String surname,
    required String birthDate,
    required String sex,
    required int region,
  }) async {
    emit(const LoginState.loadingState());
    final result = await _authRepository.registration(
      phone: phone,
      password: password,
      name: name,
      surname: surname,
      birthDate: birthDate,
      sex: sex,
      region: region,
    );

    result.when(
      success: (response) {
        emit(LoginState.tokenState(accessToken: response));
      },
      failure: (e) {
        e.maybeWhen(
          orElse: () {
            emit(
              LoginState.errorState(
                message: '$_tag - ${e.msg}',
                loginErrorMessage: 'Неверный ИИН',
                passwordErrorMessage: 'Неверный пароль',
              ),
            );
          },
        );
      },
    );
  }

  Future<void> getRegion() async {
    emit(const LoginState.loadingState());
    final result = await _authRepository.getRegion();

    result.when(
      success: (response) {
        emit(LoginState.regionState(region: response));
        log('loaded regions from cubit');
      },
      failure: (e) {
        e.maybeWhen(
          orElse: () {
            emit(
              LoginState.errorState(message: '$_tag - ${e.msg}'),
            );
          },
        );
      },
    );
  }

  Future<void> getUser() async {
    emit(const LoginState.loadingState());
    final result = await _authRepository.getUser();

    result.when(
      success: (response) {
        emit(LoginState.loadedState(user: response));
      },
      failure: (e) {
        e.maybeWhen(
          orElse: () {
            emit(
              LoginState.errorState(message: '$_tag - ${e.msg}'),
            );
          },
        );
      },
    );
  }

  @override
  void onChange(Change<LoginState> change) {
    log(change.toString(), name: _tag);
    super.onChange(change);
  }
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initialState() = _InitialState;

  const factory LoginState.tokenState({
    required String accessToken,
  }) = _TokenState;

  const factory LoginState.regionState({
    required List<RecordDTO> region,
  }) = _RegionState;

  const factory LoginState.loadedState({
    required UserDTO user,
  }) = _LoadedState;

  const factory LoginState.loadingState() = _LoadingState;

  const factory LoginState.errorState({
    required String message,
    String? loginErrorMessage,
    String? passwordErrorMessage,
  }) = _ErrorState;
}
