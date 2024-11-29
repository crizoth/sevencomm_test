import 'package:dio/dio.dart';
import 'package:flutter_dev_test/core/http_handler.dart';
import 'package:flutter_dev_test/modules/login/data/entities/generic_error_handler.dart';
import 'package:flutter_dev_test/modules/login/data/entities/login_entity.dart';
import 'package:flutter_dev_test/modules/login/data/entities/recover_entity.dart';

class AuthDatasource {
  final httpHandler = HttpHandler(baseUrl: 'http://192.168.1.7:5000');

  Future<Map<String, dynamic>> postLogin(LoginRequest request) async {
    try {
      final response = await httpHandler.post(
        url: '/auth/login',
        data: request.toMap(),
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Erro inesperado no servidor');
      }
    } on DioException catch (e) {
      throw GenericErrorHandler.fromMap(e.response?.data);
    } catch (e) {
      throw Exception('Erro ao conectar ao servidor');
    }
  }

  Future<Map<String, dynamic>> postRecoverSecret(RecoverRequest params) async {
    try {
      final response = await httpHandler.post(
        url: '/auth/recovery-secret',
        data: params.toMap(),
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Erro inesperado no servidor');
      }
    } on DioException catch (e) {
      throw GenericErrorHandler.fromMap(e.response?.data);
    } catch (e) {
      throw Exception('Erro ao conectar ao servidor');
    }
  }
}
