import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              Image.asset('assets/images/dollar-gill-0V7_N62zZcU-unsplash.jpg'),
              Container(
                 height: 250,
                  width: double.infinity,
                  child: Image.network('https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGJvb2t8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',)),
            ],
          ),
        )
    );
  }
}
