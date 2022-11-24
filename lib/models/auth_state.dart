import 'package:fluttersamplestart/models/user.dart';





class AuthState{
  final bool isLoad;
  final String err;
  final User user;


  AuthState({
   required this.user,
    required this.err,
    required this.isLoad
  });

  AuthState.intiState(): user=User(), isLoad=false, err='';

  AuthState copyWith({bool? isLoad, String? err, User? user }){
    return AuthState(
        err:  err ?? this.err,
        isLoad: isLoad ?? this.isLoad,
        user: user ?? this.user
    );
  }


}