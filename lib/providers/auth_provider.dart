import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../models/auth_state.dart';
import '../service/auth_service.dart';




final authProvider = StateNotifierProvider<AuthProvider, AuthState>(
    (ref) => AuthProvider(AuthState.intiState()));

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider(super.state);

  Future<void> userSignUp(
      {required String email,
      required String password,
      required String username}) async {
    state = state.copyWith( isLoad: true, err: '');
    final response = await AuthService.userSignUp(
        email: email, password: password, username: username);
    response.fold((l) {
      state = state.copyWith(isLoad: false, err: l);
    }, (r) {
      state = state.copyWith( isLoad: false, err: '', user: r);
    });
  }



  Future<void> userLogin({required String email,required String password}) async {
    state = state.copyWith(isLoad: true, err: '');
    final response = await AuthService.userLogin(
        email: email, password: password);
    response.fold((l) {
      state = state.copyWith(isLoad: false, err: l);
    }, (r) {
      state = state.copyWith(isLoad: false, err: '', user: r);
    });
  }


  // Future<void> userLogOut() async {
  //    await FireInstances.fireAuth.signOut();
  // }





}
