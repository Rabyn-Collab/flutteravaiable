import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/api.dart';
import 'package:fluttersamplestart/service/movie_service.dart';
import '../models/movie_state.dart';





final movieProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(MovieState(
    movies: [], isLoad: false, errText: '', apiPath: Api.getPopularMovie, page: 1)));


class MovieProvider extends StateNotifier<MovieState>{
  MovieProvider(super.state) {
    getMovieData();
  }

    Future<void>  getMovieData() async {
       state = state.copyWith(movieState: state, isLoad: true);
       final data = await MovieService.getMovieByCategory(apiPath: state.apiPath, page: state.page);
        data.fold((l) {
          state = state.copyWith(movieState: state, errText: l, isLoad: false);
        },  (r) {
          state = state.copyWith(movieState: state, isLoad: false,movies: r,errText: '');
        });
   }



  void  changeCategory({required String  apiPath}) async {
    state = state.copyWith(movieState: state, apiPath: apiPath, movies: []);
    getMovieData();
  }


}






final movieSearchProvider = StateNotifierProvider.autoDispose<SearchMovieProvider, MovieState>((ref) => SearchMovieProvider(MovieState(
    movies: [], isLoad: false, errText: '', apiPath: Api.getSearchMovie, page: 1)));


class SearchMovieProvider extends StateNotifier<MovieState>{
  SearchMovieProvider(super.state);

  Future<void>  getMovieData({required String searchText}) async {
    state = state.copyWith(movieState: state, isLoad: true);
    final data = await MovieService.getSearchMovie(apiPath: state.apiPath, query: searchText, page: state.page);
    data.fold((l) {
      state = state.copyWith(movieState: state, errText: l, isLoad: false);
    },  (r) {
      state = state.copyWith(movieState: state, isLoad: false,movies: r,errText: '');
    });
  }



}




















//
// final movieProvider = FutureProvider((ref) => MovieProvider.getMovieData());
//
//
// class MovieProvider{
//
// static  Future<List<Movie>>  getMovieData() async{
//
//     final data = await MovieService.getMovieByCategory();
//     return data.fold((l) {
//       throw l;
//     }, (r) {
//       return r;
//     });
//   }
//
//
//
// }