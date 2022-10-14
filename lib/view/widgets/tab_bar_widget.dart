import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttersamplestart/view/widgets/custom_loading.dart';
import '../../providers/movie_provider.dart';







class TabBarWidget extends StatelessWidget {
final bool isSearchPage;
TabBarWidget(this.isSearchPage);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final movieData = isSearchPage ? ref.watch(movieSearchProvider) :ref.watch(movieProvider);
            if(movieData.isLoad == true){
              return Center(child: CustomLoading());
            }else if(movieData.errText.isEmpty){
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: movieData.movies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2/3,
                        crossAxisCount: 2),
                    itemBuilder: (context, index){
                      return GridTile(
                          header: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                placeholder: (c, s) => Center(child: CustomLoading(),),
                                errorWidget: (c,s,d) => Image.asset('assets/images/movie.png'),
                                imageUrl:  movieData.movies[index].poster_path)),
                          child: Container());
                    }
                ),
              );

            }else{
               return Center(child: Text(movieData.errText));
            }
        }
    );
  }
}














//
//
//
// class TabBarWidget extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, child) {
//         final movieData = ref.watch(movieProvider);
//         return movieData.when(
//             data: (data){
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GridView.builder(
//                   itemCount: data.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                         childAspectRatio: 2/3,
//                         crossAxisCount: 2),
//                     itemBuilder: (context, index){
//                     return GridTile(
//                         header: Image.network(data[index].poster_path),
//                         footer: Container(
//                           color: Colors.black,
//                           child: Column(
//                             children: [
//                               Text(data[index].title),
//                               Text(data[index].overview)
//                             ],
//                           ),
//                         ),
//                         child: Container());
//
//                       // ClipRRect(
//                       //   borderRadius: BorderRadius.circular(10),
//                       //   child: Stack(
//                       //     children: [
//                       //       Image.network(data[index].poster_path),
//                       //       Text(data[index].vote_average)
//                       //     ],
//                       //   ));
//                     }
//                 ),
//               );
//             },
//             error: (err, stack){
//               return Center(child: Text('$err'));
//             },
//             loading: (){
//               return Center(child: CircularProgressIndicator());
//             }
//         );
//       }
//     );
//   }
// }
