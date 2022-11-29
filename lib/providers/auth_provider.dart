import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../main.dart';
import '../models/auth_state.dart';
import '../models/user.dart';
import '../service/auth_service.dart';





final authProvider = StateNotifierProvider<AuthProvider, AuthState>(
    (ref) {
      return AuthProvider(AuthState(user: ref.watch(boxA), err: '', isLoad: false, isSuccess: false));
    });

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider(super.state);

  Future<void> userSignUp(
      {required String email,
      required String password,
      required String username}) async {
    state = state.copyWith( isLoad: true, err: '', isSuccess: false);
    final response = await AuthService.userSignUp(
        email: email, password: password, username: username);
    response.fold((l) {
      state = state.copyWith(isLoad: false, err: l, isSuccess: false);
    }, (r) {
      state = state.copyWith( isLoad: false, err: '', user: [], isSuccess: true);
    });
  }



  Future<void> userLogin({required String email,required String password}) async {
    state = state.copyWith(isLoad: true, err: '');
    final response = await AuthService.userLogin(
        email: email, password: password);
    response.fold((l) {
      state = state.copyWith(isLoad: false, err: l);
    }, (r) {
      Hive.box<User>('user').add(r);
      state = state.copyWith(isLoad: false, err: '', user: [r]);
    });
  }


  void userLogOut() async {
    Hive.box<User>('user').clear();
  }





}
