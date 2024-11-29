import 'package:flutter_dev_test/modules/login/data/entities/generic_error_handler.dart';
import 'package:flutter_dev_test/modules/login/data/entities/login_entity.dart';
import 'package:flutter_dev_test/modules/login/data/login_repository.dart';
import 'package:flutter_dev_test/modules/login/presentation/cubits/login_state.dart';

class PostLoginUsecase {
  final AuthRepository repository = AuthRepository();

  Future<LoginState> call({required LoginRequest request}) async {
    try {
      final data = await repository.postLogin(request);

      if (data['status'] == 'success') {
        return LoginSuccessState(success: true);
      } else {
        return LoginErrorState(message: data['message'] ?? 'Erro desconhecido');
      }
    } on GenericErrorHandler catch (err) {
      if (err.message == 'Invalid TOTP code') {
        return LoginNavigateRecoverSecretState();
      } else {
        return LoginErrorState(message: err.getMessage());
      }
    } catch (e) {
      return LoginErrorState(message: 'Erro inesperado. Tente novamente.');
    }
  }
}
