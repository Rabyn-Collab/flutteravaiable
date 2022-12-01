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
 static final cloudinary = CloudinaryPublic('dx5eyrlaf', 'sample_pics', cache: false);

  static Future<Either<String, bool>> addProduct(
      {
        required String title,
        required String detail,
        required int price,
        required XFile image,
        required String token
      }) async {
    try {

      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image),
        );
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


  static Future<Either<String, bool>> updateProduct(
      {
        required String title,
        required String detail,
        XFile? image,
        String? imageId,
        required String id,
        required int price,
        required String token
      }) async {
    try {

      if(image == null){
         await dio.patch('${Api.updateProduct}/$id',
             data:{
               'photo': 'no need',
               'product_name': title,
               'product_detail': detail,
               'price': price,
         },options: Options(
         headers: {
         HttpHeaders.authorizationHeader: 'Bearer $token',
         }
         ));
      }else {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image),
        );
        await dio.patch('${Api.updateProduct}/$id',
            data:{
              'product_name': title,
              'product_detail': detail,
              'price': price,
              'public_id': response.publicId,
              'oldImageId': imageId,
              'photo': response.secureUrl
            },options: Options(
                headers: {
                  HttpHeaders.authorizationHeader: 'Bearer $token',
                }
            ));
      }
      return Right(true);
    } on DioError catch (err) {
      return Left(DioException.fromDioError(err).errorMessage);
    }
  }


  static Future<Either<String, bool>> removeProduct(
      {
       required String imageId,
        required String id,
        required String token
      }) async {
    try {
      await dio.delete('${Api.removeProduct}/$id',
          data:{
            'public_id': imageId,
          },options: Options(
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              }
          ));
      return Right(true);
    } on DioError catch (err) {
      return Left(DioException.fromDioError(err).errorMessage);
    }
  }


  static Future<List<Product>>  getProducts() async {
    try {
      final response = await dio.get(Api.baseUrl);
        return (response.data as List).map((e) => Product.fromJson(e)).toList();
    } on DioError catch (err) {
      throw DioException.fromDioError(err).errorMessage;
    }
  }





}
