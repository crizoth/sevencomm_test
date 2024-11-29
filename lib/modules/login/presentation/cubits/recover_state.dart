abstract class RecoverState {}

class RecoverInitialState extends RecoverState {
  final bool isButtonEnable;
  RecoverInitialState({
    this.isButtonEnable = false,
  });
  RecoverInitialState copyWith({
    bool? isButtonEnable,
  }) {
    return RecoverInitialState(
      isButtonEnable: isButtonEnable ?? this.isButtonEnable,
    );
  }
}

class RecoverLoadingState extends RecoverState {}

class RecoverSuccessState extends RecoverState {
  final bool success;
  RecoverSuccessState({
    required this.success,
  });
}

class RecoverErrorState extends RecoverState {
  final String message;
  RecoverErrorState({
    required this.message,
  });
}

class RecoverNavigateRecoverSecretState extends RecoverState {}
