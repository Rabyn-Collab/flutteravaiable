import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/view/status_page.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 500));

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
              home: StatusPage()
          );
        }
    );
  }
}

