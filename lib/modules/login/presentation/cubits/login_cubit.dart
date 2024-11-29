import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/modules/login/data/usecases/post_login_usecase.dart';
import 'package:flutter_dev_test/modules/login/presentation/cubits/login_state.dart';
import 'package:flutter_dev_test/modules/login/data/entities/generic_error_handler.dart';
import 'package:flutter_dev_test/modules/login/data/entities/login_entity.dart';
import 'package:flutter_dev_test/modules/login/data/login_repository.dart';
import 'package:otp/otp.dart';

class LoginCubit extends Cubit<LoginState> {
  String? userName;
  String? password;
  String? totpCode;
  String? secret;
  final repository = AuthRepository();
  final PostLoginUsecase loginUsecase = PostLoginUsecase();

  setUserName(String value) {
    userName = value;
    checkButtonIsEnable();
  }

  setPassword(String value) {
    password = value;
    checkButtonIsEnable();
  }

  getOtp() {
    totpCode = OTP.generateTOTPCodeString(
      secret ?? '',
      DateTime.now().millisecondsSinceEpoch,
      interval: 30,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );
    print(totpCode);
  }

  Future<void> makeLogin() async {
    emit(LoginLoadingState());

    final loginParams = LoginRequest(
      password: password ?? '',
      totpCode: totpCode ?? '',
      username: userName ?? '',
    );

    try {
      final data = await repository.postLogin(loginParams);

      if (data['status'] == 'success') {
        emit(LoginSuccessState(success: true));
      } else {
        emit(LoginErrorState(message: data['message'] ?? 'Erro desconhecido'));
      }
    } on GenericErrorHandler catch (err) {
      if (err.message == 'Invalid TOTP code') {
        password = '';
        userName = '';
        emit(LoginNavigateRecoverSecretState());
      } else {
        password = '';
        userName = '';
        emit(LoginErrorState(message: err.getMessage()));
      }
    } catch (e) {
      password = '';
      userName = '';
      emit(LoginErrorState(message: 'Erro inesperado. Tente novamente.'));
    }
  }

  checkButtonIsEnable() {
    if (isNotNullOrEmpty(userName) && isNotNullOrEmpty(password)) {
      emit(LoginInitialState(isButtonEnable: true));
    } else {
      emit(LoginInitialState(isButtonEnable: false));
    }
  }

  isNotNullOrEmpty(String? value) {
    return value != null && value != '';
  }

  LoginCubit() : super(LoginInitialState());
}
