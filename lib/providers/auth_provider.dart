// import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttersamplestart/providers/fire_instances.dart';
// import 'package:fluttersamplestart/service/firebase_auth_service.dart';
// import 'package:image_picker/image_picker.dart';
// import '../models/auth_state.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
//
//
//
//
// final userStream = StreamProvider.autoDispose((ref) => FireInstances.fireAuth.authStateChanges());
// final friendStream = StreamProvider.autoDispose((ref) => FireInstances.fireChatCore.users());
//
// final singleUserStream = StreamProvider.autoDispose((ref) {
//   final uid = FirebaseChatCore.instance.firebaseUser!.uid;
//   final data = FireInstances.fireStore.collection('users').doc(uid).snapshots();
//   return data.map((event) {
//     final json = event.data() as Map<String, dynamic>;
//       return types.User(
//         id: event.id,
//         metadata: json['metadata'],
//         firstName: json['firstName'],
//         imageUrl: json['imageUrl']
//     );
//   });
//
// });
//
//
// final authProvider = StateNotifierProvider<AuthProvider, AuthState>(
//     (ref) => AuthProvider(AuthState(user: null, err: '', isLoad: false)));
//
// class AuthProvider extends StateNotifier<AuthState> {
//   AuthProvider(super.state);
//
//   Future<void> userSignUp(
//       {required String email,
//       required String password,
//       required XFile image,
//       required String username}) async {
//     state = state.copyWith(authState: state, isLoad: true, err: '');
//     final response = await FirebaseAuthService.userSignUp(
//         email: email, password: password, image: image, username: username);
//     response.fold((l) {
//       state = state.copyWith(authState: state, isLoad: false, err: l);
//     }, (r) {
//       state = state.copyWith(authState: state, isLoad: false, err: '', user: r);
//     });
//   }
//
//
//
//   Future<void> userLogin({required String email,required String password}) async {
//     state = state.copyWith(authState: state, isLoad: true, err: '');
//     final response = await FirebaseAuthService.userLogin(
//         email: email, password: password);
//     response.fold((l) {
//       state = state.copyWith(authState: state, isLoad: false, err: l);
//     }, (r) {
//       state = state.copyWith(authState: state, isLoad: false, err: '', user: r);
//     });
//   }
//
//
//   Future<void> userLogOut() async {
//      await FireInstances.fireAuth.signOut();
//   }
//
//
//
//
//
// }
