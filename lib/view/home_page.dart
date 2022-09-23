import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttersamplestart/models/book.dart';
import 'package:sizer/sizer.dart';



class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final topBar = MediaQuery.of(context).padding.top;
    final bottomBar = MediaQuery.of(context).padding.bottom;
   // final height = MediaQuery.of(context).size.height - topBar;
    final height = 100.h - topBar;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F5F9),
      elevation: 0,
      title: Text('Hi John,', style: TextStyle(color: Colors.black, fontFamily: 'Regular', fontWeight: FontWeight.w500),),
        actions: [
          Icon(Icons.search, color: Colors.black,size: 30,),
         // Icon(CupertinoIcons.search, color: Colors.black,),
          SizedBox(width: 10,),
          Icon(Icons.notification_important, color: Colors.black,size: 30,),
          SizedBox(width: 10,),
        ],
      ),
      backgroundColor: Color(0xFFF2F5F9),
        body: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
             //  Container(
             //   // margin: EdgeInsets.only(top: 20, left: 20),
             //  //  margin: EdgeInsets.all(20),
             //   // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
             // //   padding: EdgeInsets.all(50),
             //  //  padding: EdgeInsets.only(left: 50),
             //    color: Colors.black26,
             //    height: 150,
             //    width: double.infinity,
             //    child: Text('hello world'),
             //  ),
             //  SizedBox(height: 20,),
             //  Padding(
             //    padding: const EdgeInsets.all(8.0),
             //    child: Text('hello world'),
             //  ),
            //  Image.asset('assets/images/dollar-gill-0V7_N62zZcU-unsplash.jpg'),
              Container(
                 height: 250,
                  width: double.infinity,
                  child: CachedNetworkImage(
                   imageUrl: 'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGJvb2t8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                  errorWidget: (c, s, d) => Image.asset('assets/images/dollar-gill-0V7_N62zZcU-unsplash.jpg'),
                    placeholder: (c, s) => Center(child: CircularProgressIndicator()),
                  )
              ),
              SizedBox(height: 15,),
              Container(
                height: 250,
                width: width,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                     itemCount: books.length,
                    itemBuilder: (context, index){
                       return Container(
                         padding: EdgeInsets.only(left:index == 0? 5 : 0),
                         margin: EdgeInsets.only(right: 15),
                         width: 350,
                         child: Stack(
                           children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 200,
                                width: 350,
                                child: Card(
                                  child: Row(
                                    children: [
                                      SizedBox(width: 120,),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(books[index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                            SizedBox(height: 10,),
                                            Text(books[index].detail, maxLines: 4, style: TextStyle(color: Colors.blueGrey),),
                                            SizedBox(height: 17,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(books[index].rating),
                                                Text(books[index].genre, style:  TextStyle(color: Colors.blue),)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                             Positioned(
                               bottom: 20,
                               child: ClipRRect(
                                   borderRadius: BorderRadius.circular(15),
                                   child: Image.network(books[index].imageUrl, height: 300, width: 120, fit: BoxFit.fitHeight,)),
                             )
                           ],
                         ),
                       );
                    }
                ),
              ),
            ],
          ),
        )
    );
  }
}
