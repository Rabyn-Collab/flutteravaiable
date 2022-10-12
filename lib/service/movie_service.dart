import '../api.dart';
import '../models/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


class MovieService{

 static  Future<Either<String, List<Movie>>> getMovieByCategory () async{
   final dio = Dio();
       try{
        final response = await dio.get(Api.getPopularMovie,
            queryParameters: {
               'api_key': '2a0f926961d00c667e191a21c14461f8',
                'page': 1,
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
