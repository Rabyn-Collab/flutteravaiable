import 'package:flutter/material.dart';
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
          bottom: TabBar(
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
          ),
        ),
          body: TabBarView(
              children: [
                TabBarWidget(),
                Text('top'),
                Text('upcoming'),

          ])
      ),
    );
  }
}
