import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/exceptions/api_exception.dart';
import 'package:image_picker/image_picker.dart';
import '../api.dart';
import '../models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

final productData = FutureProvider((ref) => CrudService.getProducts());

class CrudService {

  static final dio =Dio();

  static Future<Either<String, bool>> addProduct(
      {
        required String title,
        required String detail,
        required int price,
        required XFile image,
        required String token
      }) async {
    try {
      final cloudinary = CloudinaryPublic('dx5eyrlaf', 'sample_pics', cache: false);
      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image),
        );

        print(response.secureUrl);
        print(response.publicId);
         await dio.post(Api.addProduct, data: {
           'product_name': title,
           'product_detail': detail,
           'price': price,
           'imageUrl': response.secureUrl,
           'public_id': response.publicId
         },options: Options(
           headers: {
             HttpHeaders.authorizationHeader: 'Bearer $token',
           }
         ));
      } on CloudinaryException catch (e) {
        print(e.message);
        print(e.request);
      }
      return Right(true);
    } on DioError catch (err) {
      return Left(DioException.fromDioError(err).errorMessage);
    }
  }


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
