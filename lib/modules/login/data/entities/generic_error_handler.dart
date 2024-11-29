import 'dart:convert';

class GenericErrorHandler {
  String? message;
  String? status;
  GenericErrorHandler({
    this.message,
    this.status,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (message != null) {
      result.addAll({'message': message});
    }
    if (status != null) {
      result.addAll({'status': status});
    }

    return result;
  }

  factory GenericErrorHandler.fromMap(Map<String, dynamic> map) {
    return GenericErrorHandler(
      message: map['message'],
      status: map['status'],
    );
  }

  getMessage() {
    if (message == 'Invalid credentials') {
      return 'Credenciais inválidas';
    }
    if (message == 'Invalid TOTP code') {
      return 'Código TOTP inválido';
    }
    if (message == 'Invalid recovery code') {
      return 'Código de recuperação inválido';
    }

    if (message == 'Invalid password') {
      return 'Senha inválida';
    }
    if (message == 'User not found') {
      return 'Usuário não encontrado';
    }
  }

  String toJson() => json.encode(toMap());

  factory GenericErrorHandler.fromJson(String source) =>
      GenericErrorHandler.fromMap(json.decode(source));
}
