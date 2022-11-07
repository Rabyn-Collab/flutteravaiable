import 'package:firebase_auth/firebase_auth.dart';




class PostState{
  final bool isLoad;
  final String err;
  final bool isSuccess;


  PostState({
    required this.isSuccess,
    required this.err,
    required this.isLoad
  });

  PostState copyWith({required PostState postState,bool? isLoad, String? err, bool? isSuccess }){
    return PostState(
        err:  err ?? postState.err,
        isLoad: isLoad ?? postState.isLoad,
        isSuccess: isSuccess ?? postState.isSuccess
    );
  }


}