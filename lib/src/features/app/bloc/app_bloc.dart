import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wrap_architecture/src/features/app/logic/not_auth_logic.dart';
import 'package:flutter_wrap_architecture/src/features/auth/repository/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_bloc.freezed.dart';

const _tag = 'AppBLoC';

class AppBLoC extends Bloc<AppEvent, AppState> {
  final IAuthRepository _authRepository;

// final LocalStorage _storage = LocalStorage();

  /// Статус аутентификации
  bool get isAuthenticated => _authRepository.isAuthenticated;

  AppBLoC(
    this._authRepository,
  ) : super(const AppState.loadingState()) {
    NotAuthLogic().statusSubject.listen(
      (value) async {
        log('_startListenDio message from stream :: $value');

        if (value == 401) {
          await _authRepository.clearUser().whenComplete(() {
            add(const AppEvent.startListenDio());
            log('notauthworket is worked', name: _tag);
            // }
          });
          // }
        }
      },
    );

    on<AppEvent>(
      (AppEvent event, Emitter<AppState> emit) async => event.map(
        exiting: (_Exiting event) async => _exit(event, emit),
        checkAuth: (_CheckAuth event) async => _checkAuth(event, emit),
        logining: (_Logining event) async => _login(event, emit),
        refreshLocal: (_RefreshLocal event) async => _refreshLocal(event, emit),
        startListenDio: (_StartListenDio event) async =>
            _startListenDio(event, emit),
        sendDeviceToken: (_SendDeviceToken event) async =>
            _sendDeviceToken(event, emit),

        // onboardingSave: (_OnboardingSave event) async =>
        //     _onboardingSave(event, emit),
      ),
    );
  }

  Future<void> _checkAuth(
    _CheckAuth event,
    Emitter<AppState> emit,
  ) async {
    emit(const AppState.loadingState());

    log("app_bloc -> _checkAuth -> isAuthen:$isAuthenticated");

    // if (_authRepository.isAuthenticated) {
    //   emit(const AppState.inAppState());
    // } else {
    //   emit(const AppState.notAuthorizedState());
    // // }

    // final forceUpdateResult = await _authRepository.getForceUpdateVersion();

    // forceUpdateResult.when(
    //   success: (response) {
    //     try {
    //       final iosData = response.first as Map<String, dynamic>;
    //       final androidData = response.last as Map<String, dynamic>;

    //       final iosVersion = iosData['version'] as String;
    //       final iosIsCritical = iosData['isCritical'] as bool;

    //       final androidVersion = androidData['version'] as String;
    //       final androidIsCritical = androidData['isCritical'] as bool;

    //       final int versionProj = getExtendedVersionNumber(event.version);
    //       // final int versionProjAndroid = getExtendedVersionNumber(event.version);

    //       final int versionFromServerIos = getExtendedVersionNumber(iosVersion);
    //       final int versionFromServerAndroid =
    //           getExtendedVersionNumber(androidVersion);

    //       if (versionProj < versionFromServerIos && Platform.isIOS) {
    //         emit(
    //           AppState.notAvailableVersion(
    //             version: iosVersion,
    //             isCritical: iosIsCritical,
    //           ),
    //         );
    //       } else if (versionProj < versionFromServerAndroid &&
    //           Platform.isAndroid) {
    //         emit(
    //           AppState.notAvailableVersion(
    //             version: androidVersion,
    //             isCritical: androidIsCritical,
    //           ),
    //         );
    //       } else {
    //         if (_authRepository.isAuthenticated) {
    //           emit(const AppState.inAppState());
    //         } else {
    //           emit(const AppState.notAuthorizedState());
    //         }
    //       }
    //     } catch (e) {
    //       log('_checkAuth: $e', name: _tag);
    //       // emit(
    //       //   AppState.errorState(
    //       //     message: 'Something is wrong (_checkAuth $e)',
    //       //   ),
    //       // );

    //       if (_authRepository.isAuthenticated) {
    //         emit(const AppState.inAppState());
    //       } else {
    //         emit(const AppState.notAuthorizedState());
    //       }
    //     }
    //   },
    //   failure: (e) {
    if (_authRepository.isAuthenticated) {
      emit(const AppState.inAppState());
    } else {
      emit(const AppState.notAuthorizedState());
    }
    // emit(AppState.errorState(message: 'Something is wrong (checkAuth $e)'));
    // },
    // );
  }

  Future<void> _login(
    _Logining event,
    Emitter<AppState> emit,
  ) async {
    log('AppBloc _login ', name: _tag);

    emit(const AppState.inAppState());
  }

  Future<void> _exit(
    _Exiting event,
    Emitter<AppState> emit,
  ) async {
    log("App Bloc -> exit");
    // emit(const AppState.loadingState());

    await _authRepository.clearUser();
    // await _storage.deleteSecureData('HalykLifeLoginCredentials');
    emit(const AppState.notAuthorizedState());
  }

  Future<void> _refreshLocal(
    _RefreshLocal event,
    Emitter<AppState> emit,
  ) async {
    await state.maybeWhen(
      inAppState: () async {
        emit(const AppState.loadingState());
        await Future.delayed(const Duration(milliseconds: 100));
        emit(const AppState.inAppState());
      },
      orElse: () async {
        emit(const AppState.loadingState());
        await Future.delayed(const Duration(milliseconds: 100));
        emit(const AppState.notAuthorizedState());
      },
    );
  }

  void _startListenDio(
    _StartListenDio event,
    Emitter<AppState> emit,
  ) {
    emit(const AppState.notAuthorizedState());
  }

  Future<void> _sendDeviceToken(
    _SendDeviceToken event,
    Emitter<AppState> emit,
  ) async {
    // final result = await _authRepository.sendDeviceToken();

    // result.fold(
    //   (l) {
    //     log('_sendDeviceToken left: ${mapFailureToMessage(l)}', name: _tag);
    //   },
    //   (r) {
    //     log('_sendDeviceToken righy: $r', name: _tag);
    //   },
    // );
  }

  int getExtendedVersionNumber(String version) {
    final List<String> versionCellstr = version.split('.');
    final List<int> versionCells =
        versionCellstr.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }

  @override
  void onChange(Change<AppState> change) {
    log('AppBloc - $change');
    super.onChange(change);
  }
}

///
///
/// Event class
///
///
@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.checkAuth({
    required String version,
  }) = _CheckAuth;

  const factory AppEvent.logining() = _Logining;

  const factory AppEvent.exiting() = _Exiting;

  const factory AppEvent.refreshLocal() = _RefreshLocal;

  const factory AppEvent.startListenDio() = _StartListenDio;

  const factory AppEvent.sendDeviceToken() = _SendDeviceToken;
}

///
///
/// State class
///
///
@freezed
class AppState with _$AppState {
  const factory AppState.loadingState() = _LoadingState;

  const factory AppState.notAuthorizedState() = _NotAuthorizedState;

  const factory AppState.inAppState() = _InAppState;

  const factory AppState.errorState({required String message}) = _ErrorState;
}
