import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';




class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
        body: Container()
    );
  }
}
