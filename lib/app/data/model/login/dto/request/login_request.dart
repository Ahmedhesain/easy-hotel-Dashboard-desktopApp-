class LoginRequest {
  LoginRequest({
    this.userCode,
    this.password,
  });

  String? userCode;
  String? password;

  Map<String, dynamic> toJson() => {
    "userCode": userCode,
    "password": password,
  };
}
