import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/modules/login/presentation/cubits/login_cubit.dart';
import 'package:flutter_dev_test/modules/login/presentation/cubits/login_state.dart';
import 'package:flutter_dev_test/modules/login/presentation/cubits/recover_state.dart';
import 'package:flutter_dev_test/modules/login/data/entities/generic_error_handler.dart';
import 'package:flutter_dev_test/modules/login/data/entities/login_entity.dart';
import 'package:flutter_dev_test/modules/login/data/entities/recover_entity.dart';
import 'package:flutter_dev_test/modules/login/data/login_repository.dart';

class RecoverCubit extends Cubit<RecoverState> {
  String userName;
  String password;
  String? code;
  final repository = AuthRepository();

  RecoverCubit({required this.userName, required this.password})
      : super(RecoverInitialState());

  setcode(String value) {
    code = value;
    checkButtonIsEnable();
  }

  Future<void> makeRecover(BuildContext context) async {
    emit(RecoverLoadingState());

    final recoverParams = RecoverRequest(
      password: password,
      code: code!,
      username: userName,
    );

    try {
      final data = await repository.postRecoverSecret(recoverParams);

      final loginCubit = context.read<LoginCubit>();
      loginCubit.secret = data.totpSecret;
      code = '';
      Navigator.pop(context);
      loginCubit.getOtp();
      emit(RecoverSuccessState(success: true));
    } on GenericErrorHandler catch (err) {
      emit(RecoverErrorState(message: err.getMessage()));
    } catch (e) {
      emit(RecoverErrorState(message: 'Erro inesperado. Tente novamente.'));
    }
  }

  checkButtonIsEnable() {
    if (isNotNullOrEmpty(code) && code!.length == 6) {
      emit(RecoverInitialState(isButtonEnable: true));
    } else {
      emit(RecoverInitialState(isButtonEnable: false));
    }
  }

  isNotNullOrEmpty(String? value) {
    return value != null && value != '';
  }
}
