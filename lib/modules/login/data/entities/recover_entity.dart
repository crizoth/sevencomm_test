class RecoverRequest {
  String username;
  String password;
  String code;
  RecoverRequest({
    required this.username,
    required this.password,
    required this.code,
  });

  toMap() {
    return {
      "username": username,
      "password": password,
      "code": code,
    };
  }
}
