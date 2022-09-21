import 'package:flutter/material.dart';
import 'package:fluttersamplestart/view/home_page.dart';
import 'package:sizer/sizer.dart';


void main(){
  runApp(Home());
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
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
