import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/models/todo.dart';

import '../providers/todo_provider.dart';




class HomePage extends StatelessWidget {
final labelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InkWell(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Consumer(
            builder: (context, ref, child) {
              final todoData = ref.watch(todoProvider);
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    TextFormField(
                      controller: labelController,
                      onFieldSubmitted: (val){
                       if(val.isEmpty){
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                           duration: Duration(seconds: 1),
                             content: Text('provider todo')
                         ));
                       }else{
                         final todo = Todo(label: val, createTime: DateTime.now().toString());
                         ref.read(todoProvider.notifier).addTodo(todo);
                         labelController.clear();
                       }

                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        border: OutlineInputBorder(),
                        hintText: 'add some todo',
                        prefixIcon: Icon(Icons.note)
                      ),
                    ),

                    SizedBox(height: 10,),
                    Expanded(
                        child: ListView(
                          children: todoData.map((e) {
                            return ListTile(
                              title: Text(e.label),
                              subtitle: Text(e.createTime),
                              trailing: IconButton(
                                  onPressed: (){

                                  },
                                  icon: Icon(Icons.delete, color: Colors.red,)
                              ),
                            );
                          }).toList(),
                        )
                    )

                  ],
                ),
              );
            }
          ),
        )
    );
  }
}




