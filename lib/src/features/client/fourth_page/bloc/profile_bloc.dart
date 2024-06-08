import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapar/src/features/auth/model/user_dto.dart';
import 'package:sapar/src/features/auth/repository/auth_repository.dart';

part 'profile_bloc.freezed.dart';

const _tag = "ProfileBloc";

class ProfileBLoC extends Bloc<ProfileEvent, ProfileState> {
  final IAuthRepository _authRepository;

  /// Статус аутентификации
  bool get isAuthenticated => _authRepository.isAuthenticated;

  ProfileBLoC({
    required IAuthRepository authRepository,
    // required AppBloc appBloc,
  })  : _authRepository = authRepository,
        // _appBloc = appBloc,
        super(const ProfileState.errorState(message: '')) {
    // _appSubscription = _appBloc.stream.listen((appState) {
    //   appState.whenOrNull(
    //     notAuthorizedState: () {},
    //   );
    // });

    on<ProfileEvent>(
      (ProfileEvent event, Emitter<ProfileState> emit) async => event.map(
        getProfile: (_GetProfile event) async => _getProfile(event, emit),
        logOut: (_LogOut event) async => _logOut(event, emit),
      ),
    );
  }

  Future<void> _getProfile(
    _GetProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.loadingState());

    final result = await _authRepository.getUser();

    result.when(
      success: (user) {
        emit(ProfileState.loadedState(user: user));
      },
      failure: (e) {
        e.maybeWhen(
          orElse: () {
            emit(
              ProfileState.errorState(
                message: e.msg ?? 'Неизвестная ошибка в блоке',
              ),
            );
          },
        );
      },
    );
  }

  //   final user = _authRepository.getProfile();

  //   if (user != null) {
  //     final result = jsonDecode(user) as Map<String, dynamic>;
  //     final userr = UserDTO.fromJson(result);
  //     emit(ProfileState.loadedState(user: userr));

  //     ///FIX ME NEED TO REMOVE
  //   }
  // }

  Future<void> _logOut(
    _LogOut event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.loadingState());

    emit(const ProfileState.exitedState());
  }

  @override
  void onChange(Change<ProfileState> change) {
    log('ProfileBloc - $change');
    super.onChange(change);
  }
}

///
///
/// Event class
///
///
@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.getProfile() = _GetProfile;

  const factory ProfileEvent.logOut() = _LogOut;
}

///
///
/// State class
///
///

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.loadedState({
    required UserDTO user,
  }) = _LoadedState;

  const factory ProfileState.loadingState() = _LoadingState;

  const factory ProfileState.exitedState() = _ExitedState;

  const factory ProfileState.errorState({
    required String message,
  }) = _ErrorState;
}
