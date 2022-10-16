import 'package:fluttersamplestart/models/movie.dart';




class MovieState{

  final String errText;
  final List<Movie> movies;
  final bool isLoad;
  final String apiPath;
  final int page;
  final bool isLoadMore;


  MovieState({
  required this.movies,
  required this.isLoad,
  required this.errText,
  required this.apiPath,
    required this.page,
    required this.isLoadMore
 });


 MovieState copyWith({required MovieState movieState, String? errText, List<Movie>? movies,
   bool? isLoad, String? apiPath, int? page, bool? isLoadMore}){
   return MovieState(
       movies: movies ?? movieState.movies,
       isLoad: isLoad ?? movieState.isLoad,
       errText: errText ??  movieState.errText,
       apiPath: apiPath ?? movieState.apiPath,
     page: page ?? movieState.page,
     isLoadMore:  isLoadMore ?? movieState.isLoadMore
   );
 }

}

