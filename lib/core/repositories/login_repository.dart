import 'package:easyFinance/core/services/login_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginRepository {
  final LoginService _loginService;

  LoginRepository(this._loginService);

  Future<bool?> login(String email, String password) async {
    return await _loginService.login(email, password);
  }
  Future<bool> signUp(String email, String password) async {
    return await _loginService.signUp(email, password);
  }
}

final loginRepositoryProvider = Provider(
    (ref) => LoginRepository(ref.read(loginServiceProvider)));
