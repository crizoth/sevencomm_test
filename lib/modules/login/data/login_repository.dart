import 'package:dio/dio.dart';
import 'package:flutter_dev_test/modules/login/data/auth_datasource.dart';
import 'package:flutter_dev_test/modules/login/data/entities/generic_error_handler.dart';
import 'package:flutter_dev_test/modules/login/data/entities/login_entity.dart';
import 'package:flutter_dev_test/modules/login/data/entities/recover_entity.dart';
import 'package:flutter_dev_test/modules/login/data/entities/recover_response.dart';

class AuthRepository {
  final datasource = AuthDatasource();

  Future<Map<String, dynamic>> postLogin(LoginRequest request) async {
    try {
      final response = await datasource.postLogin(request);
      return response;
    } on GenericErrorHandler catch (e) {
      rethrow;
    } catch (e) {
      throw Exception('Erro ao processar o login');
    }
  }

  Future<RecoverResponse> postRecoverSecret(RecoverRequest params) async {
    try {
      final response = await datasource.postRecoverSecret(params);
      return RecoverResponse.fromMap(response);
    } on GenericErrorHandler catch (e) {
      rethrow;
    } catch (e) {
      throw Exception('Erro ao processar o login');
    }
  }
}
