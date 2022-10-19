import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/models/movie.dart';
import 'package:fluttersamplestart/providers/video_provider.dart';
import 'package:pod_player/pod_player.dart';




class DetailPage extends ConsumerWidget {
final  Movie movie;
  DetailPage(this.movie);


  @override
  Widget build(BuildContext context, ref) {
    final videoData = ref.watch(videoProvider(movie.id));
    return Scaffold(
        body: SafeArea(
          child: Container(
            child: videoData.when(
                data: (data){
                  return  ListView(
                    children: [
                      VideoWidget(data),
                      Column(
                        children: [
                          Image.network(movie.poster_path, height: 600,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(movie.overview, style: TextStyle(color: Colors.pink, fontSize: 17),),
                          )
                        ],
                      )
                    ],
                  );
                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () => Container()
            ),
          ),
        )
    );
  }
}




class VideoWidget extends StatefulWidget {
final String id;
VideoWidget(this.id);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {

  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/${widget.id}'),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: true,
            isLooping: false,
            videoQualityPriority: [720, 360, 1080]
        )
    )..initialise();
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(
      controller:controller,
      videoThumbnail: const DecorationImage(
        image: NetworkImage('https://images.unsplash.com/photo-1569317002804-ab77bcf1bce4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dW5zcGxhc2h8ZW58MHx8MHx8&w=1000&q=80',
        ),
        fit: BoxFit.cover,
      ),
    );;
  }
}
