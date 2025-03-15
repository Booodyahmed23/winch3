abstract class LoginState {}

class SuccessState extends LoginState {
  SuccessState(login);
}

class SuccessLogoutState extends LoginState {
  SuccessLogoutState(Logout);
}

class LoginStateLoading extends LoginState {}

class LoginStateInt extends LoginState {}

class ErrorState extends LoginState {
  String errorMessage;

  ErrorState({required this.errorMessage});
}