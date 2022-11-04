import 'package:firebase_auth/firebase_auth.dart';




class AuthState{
final bool isLoad;
final String err;
final User? user;


AuthState({
   this.user,
  required this.err,
  required this.isLoad
});

AuthState copyWith({required AuthState authState,bool? isLoad, String? err, User? user }){
  return AuthState(
   err:  err ?? authState.err,
    isLoad: isLoad ?? authState.isLoad,
    user: user ?? authState.user
  );
}


}