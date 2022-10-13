import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/api.dart';
import 'package:fluttersamplestart/providers/movie_provider.dart';
import 'package:fluttersamplestart/view/widgets/tab_bar_widget.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Watch Now', style: TextStyle( fontSize: 30, fontWeight: FontWeight.w500),),
                IconButton(onPressed: (){}, icon: Icon(Icons.search, size: 30,))
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 45),
            child: Consumer(
              builder: (context, ref, child) {
                return TabBar(
                    onTap: (index) {
                      switch(index){
                        case 0:
                          ref.read(movieProvider.notifier).changeCategory(apiPath: Api.getPopularMovie);
                         break;
                        case 1:
                          ref.read(movieProvider.notifier).changeCategory(apiPath: Api.getTopRatedMovie);
                          break;
                        default:
                          ref.read(movieProvider.notifier).changeCategory(apiPath: Api.getUpcomingMovie);
                      }
                    },
                    indicator: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    tabs: [
                      Tab(
                        text: 'Popular',
                      ),
                      Tab(
                        text: 'Top_Rated',
                      ),
                      Tab(
                        text: 'UpComing',
                      ),
                    ]
                );
              }
            ),
          ),
        ),
          body: TabBarView(
              children: [
                TabBarWidget(),
                TabBarWidget(),
                TabBarWidget(),
          ])
      ),
    );
  }
}
