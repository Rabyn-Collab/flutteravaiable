import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/models/cart_item.dart';
import 'package:fluttersamplestart/models/user.dart';
import 'package:fluttersamplestart/view/status_page.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:hive_flutter/hive_flutter.dart';

final boxA = Provider<List<User>>((ref) => []);
final boxB = Provider<List<CartItem>>((ref) => []);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 500));
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CartItemAdapter());
final userBox = await Hive.openBox<User>('user');
final cartBox = await Hive.openBox<CartItem>('carts');

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Color(0xFFF2F5F9)
  // ));
  runApp(ProviderScope(
      overrides: [
        boxA.overrideWithValue(userBox.values.toList().cast<User>()),
        boxB.overrideWithValue(cartBox.values.toList().cast<CartItem>()),
      ],
      child: Home()));
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

