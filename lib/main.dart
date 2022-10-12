import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/view/home_page.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


//
// Future<void> getData() async{
//  await Future.delayed(Duration(seconds: 10));
//   print('hello world');
// }


void main(){
  //getData();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Color(0xFFF2F5F9)
  // ));
  runApp(ProviderScope(child: Home()));
}


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: Colors.black,
                appBarTheme: AppBarTheme(color: Colors.black)
              ),
              home: HomePage()
          );
        }
    );
  }
}

