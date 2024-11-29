abstract class LoginState {}

class LoginInitialState extends LoginState {
  final bool isButtonEnable;
  LoginInitialState({
    this.isButtonEnable = false,
  });
  LoginInitialState copyWith({
    bool? isButtonEnable,
  }) {
    return LoginInitialState(
      isButtonEnable: isButtonEnable ?? this.isButtonEnable,
    );
  }
}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final bool success;
  LoginSuccessState({
    required this.success,
  });
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState({
    required this.message,
  });
}

class LoginNavigateRecoverSecretState extends LoginState {}
