import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/exceptions/api_exception.dart';
import '../api.dart';
import '../models/product.dart';


final productData = FutureProvider((ref) => CrudService.getProducts());

class CrudService {

  static final dio =Dio();

  // static Future<Either<String, bool>> addPost(
  //     {
  //       required String title,
  //       required String detail,
  //       required XFile image,
  //       required String uid,
  //     }) async {
  //   try {
  //     final imageId = DateTime.now().toString();
  //     final ref = FireInstances.fireStorage.ref().child('postImage/${imageId}');
  //     await ref.putFile(File(image.path));
  //     final imageUrl = await ref.getDownloadURL();
  //    final  response = await FireInstances.postDb.add({
  //     'title': title,
  //      'detail': detail,
  //     'imageUrl':imageUrl,
  //     'uid': uid,
  //     'comments': [],
  //     'like':{
  //       'totalLikes': 0,
  //       'usernames': []
  //     },
  //       'imageId': imageId
  //     });
  //     return Right(true);
  //   } on FirebaseException catch (err) {
  //     return Left(AuthExceptionHandler.handleException(err));
  //   }
  // }
  //
  //
  // static Future<Either<String, bool>> updatePost(
  //     {
  //       required String title,
  //       required String detail,
  //       XFile? image,
  //       String? imageId,
  //       required String id,
  //     }) async {
  //   try {
  //
  //     if(image == null){
  //        await FireInstances.postDb.doc(id).update({
  //          'title': title,
  //          'detail': detail,
  //        });
  //     }else {
  //       final oldRef = FireInstances.fireStorage.ref().child(
  //           'postImage/$imageId');
  //       await oldRef.delete();
  //       final newImageId = DateTime.now().toString();
  //       final newRef = FireInstances.fireStorage.ref().child(
  //           'postImage/$newImageId');
  //       await newRef.putFile(File(image.path));
  //       final imageUrl = await newRef.getDownloadURL();
  //       final response = await FireInstances.postDb.doc(id).update({
  //         'title': title,
  //         'detail': detail,
  //         'imageUrl': imageUrl,
  //         'imageId': newImageId
  //       });
  //     }
  //     return Right(true);
  //   } on FirebaseException catch (err) {
  //     return Left(AuthExceptionHandler.handleException(err));
  //   }
  // }
  //
  //
  // static Future<Either<String, bool>> removePost(
  //     {
  //      required String imageId,
  //       required String id,
  //     }) async {
  //   try {
  //       final oldRef = FireInstances.fireStorage.ref().child(
  //           'postImage/$imageId');
  //       await oldRef.delete();
  //        await FireInstances.postDb.doc(id).delete();
  //     return Right(true);
  //   } on FirebaseAuthException catch (err) {
  //     return Left(AuthExceptionHandler.handleException(err));
  //   }
  // }


  static Future<List<Product>>  getProducts() async {
    try {
      final response = await dio.get(Api.baseUrl);
        return (response.data as List).map((e) => Product.fromJson(e)).toList();
    } on DioError catch (err) {
      throw DioException.fromDioError(err).errorMessage;
    }
  }





}
