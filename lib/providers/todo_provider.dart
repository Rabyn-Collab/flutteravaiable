import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/models/todo.dart';



class A{
  final String a;
  A(this.a);
}

class B extends A{
  B(super.a);

}



final todoProvider = StateNotifierProvider<TodoProvider, List<Todo>>((ref) => TodoProvider([]));

class TodoProvider extends StateNotifier<List<Todo>>{
  TodoProvider(super.state);


  void addTodo(Todo todo){
    // List m = [22, 55, 77, 99];
    // int n = 90;
    // m = [...m, n];
     state = [...state, todo];
  }

  void removeTodo(){

  }

}


