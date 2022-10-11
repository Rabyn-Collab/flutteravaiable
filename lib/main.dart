import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/service/movie_service.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


//
// Future<void> getData() async{
//  await Future.delayed(Duration(seconds: 10));
//   print('hello world');
// }


void main(){
  //getData();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFFF2F5F9)
  ));
  runApp(ProviderScope(child: Home()));
}


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
               // themeMode: ThemeMode.dark,
               //  theme: ThemeData.light().copyWith(
               //  primaryColor: Colors.red
               //  ),
              home: Container()
          );
        }
    );
  }
}

