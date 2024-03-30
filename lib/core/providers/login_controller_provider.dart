import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easyFinance/core/states/user_states.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  void login(String email, String password) async {
    state = const LoginStateLoading();

  }
}

final loginControllerProvider =
StateNotifierProvider<LoginController, LoginState>(
        (ref) => LoginController(ref));
