import 'dart:io';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttersamplestart/providers/fire_instances.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dartz/dartz.dart';
import '../exceptions/firebase_exception.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAuthService {

 static Future<Either<String, User>> userSignUp(
      {required String email,
      required String password,
      required XFile image,
      required String username}) async {
    try {
      final imageId = DateTime.now().toString();
      final ref = FireInstances.fireStorage.ref().child('userImage/${imageId}');
      await ref.putFile(File(image.path));
      final imageUrl = await ref.getDownloadURL();
      UserCredential credential =
          await FireInstances.fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final response = await FirebaseMessaging.instance.getToken();
      await FireInstances.fireChatCore.createUserInFirestore(
        types.User(
            firstName: username,
            id: credential.user!.uid, // UID from Firebase Authentication
            imageUrl: imageUrl,
            metadata: {
              'email': email,
              'token': response
            }
            ),
      );
      return Right(credential.user!);
    } on FirebaseAuthException catch (err) {
      return Left(AuthExceptionHandler.handleException(err));
    }
  }


 static Future<Either<String, User>> userLogin({required String email,required String password}) async {
   try {

     final  userDb = FireInstances.fireStore.collection('users');
     UserCredential credential =
     await FireInstances.fireAuth.signInWithEmailAndPassword(
       email: email,
       password: password,
     );
     final response = await FirebaseMessaging.instance.getToken();
     await userDb.doc(credential.user!.uid).update({
       'metadata': {
         'email': email,
         'token': response
       }
     });


     return Right(credential.user!);
   } on FirebaseAuthException catch (err) {
     return Left(AuthExceptionHandler.handleException(err));
   }
 }


}
