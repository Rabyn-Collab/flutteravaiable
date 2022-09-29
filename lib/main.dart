import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/counter_provider.dart';
import 'package:fluttersamplestart/view/home_page.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';



void main(){
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
              home: HomePage()
          );
        }
    );
  }
}



class Counter extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        body: Container(
          child: Consumer(
           builder: (context, ref, child) {
           //  final numberData = ref.watch(counterProvider).number;
             final numberData = ref.watch(numberProvider);
             return Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text('$numberData', style: TextStyle(fontSize: 50),),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     TextButton(
                         onPressed: () {
                           ref.read(numberProvider.notifier).state++;
                         }, child: Text('increment')),
                     TextButton(
                         onPressed: () {
                           ref.read(numberProvider.notifier).state--;
                         }, child: Text('decrement')),
                   ],
                 ),
               ],
             );
           }
          ),
        )
    );
  }



}
