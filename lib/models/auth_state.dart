import 'package:fluttersamplestart/models/user.dart';





class AuthState{
  final bool isLoad;
  final bool isSuccess;
  final String err;
  final List<User> user;


  AuthState({
   required this.user,
    required this.err,
    required this.isLoad,
    required this.isSuccess
  });



  AuthState copyWith({bool? isLoad, String? err, List<User>? user, bool? isSuccess }){
    return AuthState(
        err:  err ?? this.err,
        isLoad: isLoad ?? this.isLoad,
        user: user ?? this.user,
      isSuccess: isSuccess ?? this.isSuccess
    );
  }


}