class LoginService{
  Future<bool> login(String email, String password) async {
    return Future.delayed(const Duration(seconds: 1), () => true);
  }
}