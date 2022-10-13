import '../api.dart';
import '../models/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


class MovieService{

 static  Future<Either<String, List<Movie>>> getMovieByCategory ({required String apiPath, required int page}) async{
   final dio = Dio();
       try{
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
          return  left('${err.message}');
      }


   }










}
