import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class CustomLoading extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: Colors.pinkAccent,
      size: 30.0,
    );
  }
}
