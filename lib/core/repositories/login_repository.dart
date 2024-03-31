import 'package:easyFinance/core/services/login_service.dart';

class LoginRepository {
  final LoginService _loginService;

  LoginRepository(this._loginService);

  Future<bool?> login(String email, String password) async {
    return await _loginService.login(email, password);
  }
}