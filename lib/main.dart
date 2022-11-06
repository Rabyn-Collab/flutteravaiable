import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/view/auth_page.dart';
import 'package:fluttersamplestart/view/status_page.dart';
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
              home: StatusPage()
          );
        }
    );
  }
}

StreamController<int>  numberStream = StreamController().stream.asBroadcastStream() as StreamController<int>;


class Counter extends StatelessWidget {


  int number = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: StreamBuilder<int>(
              initialData: 0,
              stream: numberStream.stream,
              builder: (context, snapshot) {
                // if(snapshot.connectionState == ConnectionState.waiting){
                //   return Center(child: CircularProgressIndicator());
               if(snapshot.hasData){
                  return Center(child: Text('${snapshot.data}', style: TextStyle(fontSize: 20),));
                }else{
                  return Center(child: Text('${snapshot.data}', style: TextStyle(fontSize: 20),));
                }
              }
            )
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            numberStream.sink.add(number++);
          },
        child: Icon(Icons.add),
      ),
    );
  }
}

