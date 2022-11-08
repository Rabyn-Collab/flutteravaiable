import 'dart:io';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/fire_instances.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dartz/dartz.dart';
import '../exceptions/firebase_exception.dart';
import '../models/posts.dart';

final postStream = StreamProvider((ref) => FirebaseCrudService.streamPost);


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
     final  response = await FireInstances.postDb.add({
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
     print(response);

      return Right(true);
    } on FirebaseException catch (err) {
      return Left(AuthExceptionHandler.handleException(err));
    }
  }


  static Future<Either<String, bool>> updatePost(
      {
        required String title,
        required String detail,
        XFile? image,
        String? imageId,
        required String id,
      }) async {
    try {

      if(image == null){
         await FireInstances.postDb.doc(id).update({
           'title': title,
           'detail': detail,
         });
      }else {
        final oldRef = FireInstances.fireStorage.ref().child(
            'postImage/$imageId');
        await oldRef.delete();
        final newImageId = DateTime.now().toString();
        final newRef = FireInstances.fireStorage.ref().child(
            'postImage/$newImageId');
        await newRef.putFile(File(image.path));
        final imageUrl = await newRef.getDownloadURL();
        final response = await FireInstances.postDb.doc(id).update({
          'title': title,
          'detail': detail,
          'imageUrl': imageUrl,
          'imageId': newImageId
        });
      }
      return Right(true);
    } on FirebaseException catch (err) {
      return Left(AuthExceptionHandler.handleException(err));
    }
  }


  static Future<Either<String, bool>> removePost(
      {
       required String imageId,
        required String id,
      }) async {
    try {
        final oldRef = FireInstances.fireStorage.ref().child(
            'postImage/$imageId');
        await oldRef.delete();
         await FireInstances.postDb.doc(id).delete();
      return Right(true);
    } on FirebaseAuthException catch (err) {
      return Left(AuthExceptionHandler.handleException(err));
    }
  }


  static Stream<List<Post>> get  streamPost {
    try {
        final data = FireInstances.postDb.snapshots();
     return data.map((event) => event.docs.map((e) {
       final json = e.data() as Map<String, dynamic>;
       return Post(
           imageUrl: json['imageUrl'],
           uid: json['uid'],
           id: e.id,
           comments: (json['comments'] as List).map((e) => Comment.fromJson(e)).toList(),
           detail: json['detail'],
           like: Like.fromJson(json['like']),
           title: json['title'],
           imageId: json['imageId']
       );
     }).toList());
    } on FirebaseAuthException catch (err) {
      throw AuthExceptionHandler.handleException(err);
    }
  }




}
