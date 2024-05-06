import 'package:easyFinance/core/providers/supabase_provider.dart';
import 'package:easyFinance/core/repositories/login_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easyFinance/core/states/login_states.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  void login(String email, String password) async {
    state = const LoginStateLoading();
    try {
      final logged =
          await ref.read(loginRepositoryProvider).login(email, password);
      state = logged ?? false
          ? const LoginStateSuccess()
          : const LoginStateError('invalid login');
    } catch (e) {
      state = const LoginStateError('?');
    } finally {
      print('login status: $state');
    }
  }

  void signUp(String email, String password) async {
    state = const LoginStateLoading();
    try {
      await ref.read(loginRepositoryProvider).signUp(email, password);
      state = const LoginStateSuccess();
    } catch (e) {
      state = const LoginStateError('?');
    }
  }

  void retrieveSession() async {
    state = const LoginStateLoading();
    if (ref.read(supabaseClientProvider.notifier).state!.auth.currentSession !=
        null) {
      state = const LoginStateSuccess();
    } else {
      state = const LoginStateError('no session');
    }
  }

  void signOut() async {
    state = const LoginStateLoading();
    await ref.read(supabaseClientProvider.notifier).state!.auth.signOut();
    state = const LoginStateInitial();
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>(
        (ref) => LoginController(ref));
