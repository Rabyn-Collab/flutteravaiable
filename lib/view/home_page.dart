import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/models/todo.dart';

import '../providers/todo_provider.dart';




class HomePage extends StatelessWidget {
final labelController = TextEditingController();
final labelController1 = TextEditingController();
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
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: (){
                                   showDialog(context: context, builder:(context) => AlertDialog(
                                     title: Text('edit'),
                                     content: Column(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         TextFormField(
                                           controller: labelController1..text = e.label,
                                           onFieldSubmitted: (val){
                                             if(val.isEmpty){
                                               Navigator.of(context).pop();
                                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                   duration: Duration(seconds: 1),
                                                   content: Text('provider todo')
                                               ));
                                             }else{
                                               Navigator.of(context).pop();
                                               ref.read(todoProvider.notifier).editTodo(e, val);
                                               labelController1.clear();
                                             }

                                           },
                                           decoration: InputDecoration(
                                               contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                               border: OutlineInputBorder(),
                                               hintText: 'add some todo',
                                               prefixIcon: Icon(Icons.note)
                                           ),
                                         ),

                                       ],
                                     ),
                                   ));
                                        },
                                        icon: Icon(Icons.edit, color: Colors.green,)
                                    ),
                                    IconButton(
                                        onPressed: (){
                                          //print(todoData.indexOf(e));
                                          ref.read(todoProvider.notifier).removeTodo(todoData.indexOf(e));
                                        },
                                        icon: Icon(Icons.delete, color: Colors.red,)
                                    ),
                                  ],
                                ),
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




