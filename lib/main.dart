import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttersamplestart/view/home_page.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';



void main(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFFF2F5F9)
  ));
  runApp(Home());
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              //  themeMode: ThemeMode.dark,
              //   theme: ThemeData.dark().copyWith(
              //     buttonColor: Colors.black,
              //   ),
              home: HomePage()
          );
        }
    );
  }
}
