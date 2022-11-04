import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/service/firebase_auth_service.dart';
import 'package:image_picker/image_picker.dart';
import '../models/auth_state.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>(
    (ref) => AuthProvider(AuthState(user: null, err: '', isLoad: false)));

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider(super.state);

  Future<void> userSignUp(
      {required String email,
      required String password,
      required XFile image,
      required String username}) async {
    state = state.copyWith(authState: state, isLoad: true);
    final response = await FirebaseAuthService.userSignUp(
        email: email, password: password, image: image, username: username);
    response.fold((l) {
      state = state.copyWith(authState: state, isLoad: false, err: l);
    }, (r) {
      state = state.copyWith(authState: state, isLoad: false, err: '', user: r);
    });
  }



  Future<void> userLogin({required String email,required String password}) async {
    state = state.copyWith(authState: state, isLoad: true);
    final response = await FirebaseAuthService.userLogin(
        email: email, password: password);
    response.fold((l) {
      state = state.copyWith(authState: state, isLoad: false, err: l);
    }, (r) {
      state = state.copyWith(authState: state, isLoad: false, err: '', user: r);
    });
  }



}
