import 'package:bloc/bloc.dart';
import 'package:carwinch/auth/domain/usecase/logout_use_case.dart';

import '../../domain/usecase/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(super.initialState);
  late LoginUsecase loginUsecase;
  late RemoteLogoutUsecase remoteLogoutUsecase;
  Future<void> login(String username, String password) async {
    try {
      emit(LoginStateLoading());

      final logedin = await loginUsecase(username, password);
      if (logedin.status) {
        emit(SuccessState(logedin));
      } else {
        emit(ErrorState(errorMessage: logedin.message));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> logOut() async {
    // emit(LoginStateLoading());
    // final remoteLogoutUsecase = RemoteLogoutUsecase();
    try {
      emit(LoginStateLoading());
      final loggedout = await remoteLogoutUsecase.call();
      if (loggedout.status) {
        emit(SuccessLogoutState(loggedout));
      } else {
        emit(ErrorState(errorMessage: loggedout.message));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
