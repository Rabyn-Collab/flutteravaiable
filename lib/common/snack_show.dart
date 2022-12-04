import 'package:flutter/material.dart';
import 'package:fluttersamplestart/view/cart_page.dart';
import 'package:get/get.dart';



class SnackShow{

  static showFailureSnack(BuildContext context, message, bool? isAdd){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        action: isAdd == true ? SnackBarAction(label: 'Go to Cart', onPressed: (){
          Get.to(() => CartPage(), transition:  Transition.leftToRight);
        })  : null,
        duration: Duration(seconds: 1),
        content: Text(message)));
  }
  static showCommonSnack(BuildContext context, message, bool? isAdd){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        action: isAdd == true ? SnackBarAction(label: 'Go to Cart', onPressed: (){
          Get.to(() => CartPage(), transition:  Transition.leftToRight);
        })  : null,
        duration: Duration(seconds: 1),
        content: Text(message)));
  }

  static popIt(context){
    Navigator.of(context).pop();
  }

}