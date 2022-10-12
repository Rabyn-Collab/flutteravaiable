import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/service/movie_service.dart';
import '../models/movie.dart';



final movieProvider = FutureProvider((ref) => MovieProvider.getMovieData());


class MovieProvider{

static  Future<List<Movie>>  getMovieData() async{

    final data = await MovieService.getMovieByCategory();
    return data.fold((l) {
      throw l;
    }, (r) {
      return r;
    });
  }



}