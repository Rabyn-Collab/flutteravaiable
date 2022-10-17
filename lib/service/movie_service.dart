import 'dart:convert';

import 'package:fluttersamplestart/exceptions/api_exception.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../api.dart';
import '../models/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


class MovieService{

 static  Future<Either<String, List<Movie>>> getMovieByCategory ({required String apiPath, required int page}) async{
   final dio = Dio();
       try{
         if(apiPath == Api.getPopularMovie){
           final response = await dio.get(apiPath,
               queryParameters: {
                 'api_key': '2a0f926961d00c667e191a21c14461f8',
                 'page': 1,
                 'language': 'en-US'
               }
           );
           Hive.box<String>('data').put('movies', jsonEncode(response.data));

         }
        final response = await dio.get(apiPath,
            queryParameters: {
               'api_key': '2a0f926961d00c667e191a21c14461f8',
                'page': page,
               'language': 'en-US'
              }
        );
        final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
        return  right(data);
       }on DioError catch (err){
        final errMessage =  DioException().getDioError(err);
        if(errMessage == 'No Internet.' && apiPath == Api.getPopularMovie){
           final box =    Hive.box<String>('data');
           if(box.isNotEmpty){
             final data = box.get('movies');
             final movieData = (jsonDecode(data!)['results'] as List).map((e) => Movie.fromJson(e)).toList();
             return  right(movieData);

           }else{
             return  left(errMessage);
           }
        }else{
          return  left(errMessage);
        }

      }


   }







 static  Future<Either<String, List<Movie>>> getSearchMovie ({required String query, required String apiPath, required int page}) async{
   final dio = Dio();
   try{
     final response = await dio.get(apiPath,
         queryParameters: {
           'api_key': '2a0f926961d00c667e191a21c14461f8',
           'page': page,
         'query': query
         }
     );
      if((response.data['results'] as List).isEmpty){
        return  left('try using another keyword');
      }else{
        final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
        return  right(data);
      }

   }on DioError catch (err){
     final errMessage =  DioException().getDioError(err);
     return  left(errMessage);
   }


 }





 static  Future<Either<String, String>> getMovieKey ({ required int videoId}) async{
   final dio = Dio();
   try{
     final response = await dio.get('${Api.getVideoKey}/$videoId/videos',
         queryParameters: {
           'api_key': '2a0f926961d00c667e191a21c14461f8',
         }
     );
     if((response.data['results'] as List).isEmpty){
       return  left('try using another keyword');
     }else{
       final data = (response.data['results'] as List)[0]['key'] as String;
       return  right(data);
     }

   }on DioError catch (err){
     final errMessage =  DioException().getDioError(err);
     return  left(errMessage);
   }


 }



}
