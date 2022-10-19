import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/api.dart';
import 'package:fluttersamplestart/providers/movie_provider.dart';
import 'package:fluttersamplestart/view/search_page.dart';
import 'package:fluttersamplestart/view/widgets/tab_bar_widget.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';



class HomePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    FlutterNativeSplash.remove();
    final height = 100.h - MediaQuery.of(context).padding.top;
    final width =  MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight:  height * 0.10,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Watch Now', style: TextStyle( fontSize: width > 612 ? 12.sp: 16.sp, fontWeight: FontWeight.w500),),
                IconButton(
                    onPressed: (){
                  Get.to(() => SearchPage(), transition: Transition.leftToRight);
                }, icon: Icon(Icons.search, size: 7.w,))
              ],
            ),
          ),
          bottom:  TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
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
              labelStyle: TextStyle(fontSize: width > 612 ? 11.sp: 12.sp),
                  indicator: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(5.w)
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


          ),
        ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
              children: [
                TabBarWidget(false),
                TabBarWidget(false),
                TabBarWidget(false),
          ])
      ),
    );
  }
}
