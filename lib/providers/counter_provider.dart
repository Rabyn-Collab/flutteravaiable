import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// change notifier provider

final counterProvider = ChangeNotifierProvider((ref) => CounterProvider());

class CounterProvider extends ChangeNotifier{
  int number = 0;

  void increment(){
    number = number + 1;
    notifyListeners();
  }
  void decrement(){
    number = number - 1;
    notifyListeners();
  }


}
