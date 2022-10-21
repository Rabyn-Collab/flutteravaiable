import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 500));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
              home: Container()
          );
        }
    );
  }
}

