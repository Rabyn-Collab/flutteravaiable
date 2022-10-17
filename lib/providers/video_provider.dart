import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/movie_service.dart';




final videoProvider = FutureProvider.family((ref, int id) => VideoProvider.getVideoId(id: id));


class VideoProvider{

static  Future<String> getVideoId({required int id}) async{
        final response = await MovieService.getMovieKey(videoId: id);
        return response.fold((l) => throw l , (r) => r);
  }


}