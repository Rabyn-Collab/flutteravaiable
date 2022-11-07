import 'dart:io';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttersamplestart/providers/fire_instances.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dartz/dartz.dart';
import '../exceptions/firebase_exception.dart';


class FirebaseCrudService {

  static Future<Either<String, bool>> addPost(
      {
        required String title,
        required String detail,
        required XFile image,
        required String uid,
      }) async {
    try {
      final imageId = DateTime.now().toString();
      final ref = FireInstances.fireStorage.ref().child('postImage/${imageId}');
      await ref.putFile(File(image.path));
      final imageUrl = await ref.getDownloadURL();
      await FireInstances.postDb.add({
      'title': title,
       'detail': detail,
      'imageUrl':imageUrl,
      'uid': uid,
      'comments': [],
      'like':{
        'totalLikes': 0,
        'usernames': []
      },
        'imageId': imageId
      });

      return Right(true);
    } on FirebaseAuthException catch (err) {
      return Left(AuthExceptionHandler.handleException(err));
    }
  }







}
