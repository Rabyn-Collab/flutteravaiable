import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/movie_provider.dart';




class TabBarWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final movieData = ref.watch(movieProvider);
        return movieData.when(
            data: (data){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2/3,
                        crossAxisCount: 2),
                    itemBuilder: (context, index){
                    return GridTile(
                        header: Image.network(data[index].poster_path),
                        footer: Container(
                          color: Colors.black,
                          child: Column(
                            children: [
                              Text(data[index].title),
                              Text(data[index].overview)
                            ],
                          ),
                        ),
                        child: Container());
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(10),
                      //   child: Stack(
                      //     children: [
                      //       Image.network(data[index].poster_path),
                      //       Text(data[index].vote_average)
                      //     ],
                      //   ));
                    }
                ),
              );
            },
            error: (err, stack){
              return Center(child: Text('$err'));
            },
            loading: (){
              return Center(child: CircularProgressIndicator());
            }
        );
      }
    );
  }
}
