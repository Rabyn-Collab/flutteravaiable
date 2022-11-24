import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dartz/dartz.dart';


class FirebaseAuthService {

 // static Future<Either<String, User>> userSignUp(
 //      {required String email,
 //      required String password,
 //      required XFile image,
 //      required String username}) async {
 //    try {
 //      final imageId = DateTime.now().toString();
 //      final ref = FireInstances.fireStorage.ref().child('userImage/${imageId}');
 //      await ref.putFile(File(image.path));
 //      final imageUrl = await ref.getDownloadURL();
 //      return Right();
 //    } on FirebaseAuthException catch (err) {
 //      return Left(AuthExceptionHandler.handleException(err));
 //    }
 //  }
 //

 // static Future<Either<String, User>> userLogin({required String email,required String password}) async {
 //   try {
 //
 //     final  userDb = FireInstances.fireStore.collection('users');
 //     UserCredential credential =
 //     await FireInstances.fireAuth.signInWithEmailAndPassword(
 //       email: email,
 //       password: password,
 //     );
 //     final response = await FirebaseMessaging.instance.getToken();
 //     await userDb.doc(credential.user!.uid).update({
 //       'metadata': {
 //         'email': email,
 //         'token': response
 //       }
 //     });
 //
 //
 //     return Right(credential.user!);
 //   } on FirebaseAuthException catch (err) {
 //     return Left(AuthExceptionHandler.handleException(err));
 //   }
 // }


}
