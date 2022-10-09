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
     state = [...state, todo];
  }

  void removeTodo(int index){
     state.removeAt(index);
     state = [...state];
  }

  void editTodo(Todo todo, String label){
    todo.label = label;
    state = [...state];
    // state = [
    //   for(final element in state )
    //     if(element == todo) todo else element
    // ];
  }



}


