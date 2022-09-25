import 'package:flutter/material.dart';
import 'package:fluttersamplestart/models/book.dart';
import 'package:fluttersamplestart/view/detail_page.dart';
import 'package:get/get.dart';




class BookShow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return  Container(
      height: 250,
      width: width,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: books.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Get.to(() => DetailPage(books[index]), transition: Transition.leftToRight);
              },
              child: Container(
                padding: EdgeInsets.only(left:index == 0? 5 : 0),
                margin: EdgeInsets.only(right: 15),
                width: 370,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 200,
                        width: 370,
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
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Text(books[index].genre, style:  TextStyle(color: Colors.blue),),
                                        )
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
                      bottom: 15,
                      child: ClipRRect(
                        //  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(books[index].imageUrl, height: 200, width: 120, fit: BoxFit.fitHeight,)),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
