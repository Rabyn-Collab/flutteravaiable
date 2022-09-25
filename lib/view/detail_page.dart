import 'package:flutter/material.dart';
import 'package:fluttersamplestart/models/book.dart';



class DetailPage extends StatelessWidget {

  final Book book;

  DetailPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            Container(
                child: Image.network(book.imageUrl, height: 350, width: double.infinity, fit: BoxFit.fitWidth,)
            ),
            //next
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(book.title),
                      Column(
                        children: [
                          Text(book.rating),
                          Text(book.genre),
                        ],
                      )
                    ],
                  ),
                  //next
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(book.detail),
                  ),
                  //next
                 SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: Color(0xFF007084),
                          minimumSize: Size(150, 50)
                        ),
                          onPressed: (){},
                          child: Text('Read book')
                      ),
                      SizedBox(width: 15,),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              minimumSize: Size(150, 50)
                          ),
                          onPressed: (){

                          },
                          child: Text('Read book')
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
