import 'dart:convert';

class RecoverResponse {
  String? message;
  String? totpSecret;
  RecoverResponse({
    this.message,
    this.totpSecret,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (message != null) {
      result.addAll({'message': message});
    }
    if (totpSecret != null) {
      result.addAll({'totp_secret': totpSecret});
    }

    return result;
  }

  factory RecoverResponse.fromMap(Map<String, dynamic> map) {
    return RecoverResponse(
      message: map['message'],
      totpSecret: map['totp_secret'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecoverResponse.fromJson(String source) =>
      RecoverResponse.fromMap(json.decode(source));
}
