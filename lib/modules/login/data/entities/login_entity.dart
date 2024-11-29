class LoginRequest {
  String username;
  String password;
  String totpCode;
  LoginRequest({
    required this.username,
    required this.password,
    required this.totpCode,
  });

  toMap() {
    return {
      "username": username,
      "password": password,
      "totp_code": totpCode,
    };
  }
}
