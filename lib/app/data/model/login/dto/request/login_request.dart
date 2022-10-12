class LoginRequest {
  LoginRequest({
    this.userName,
    this.password,
  });

  String? userName;
  String? password;

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "password": password,
    "version": "2.0",
  };
}
