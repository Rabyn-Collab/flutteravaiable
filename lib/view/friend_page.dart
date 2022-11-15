import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/room_provider.dart';



class FriendPage extends ConsumerWidget{
  const FriendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userData = ref.watch(roomStream);
    return Scaffold(
        body: Container(
          child:  userData.when(
              data: (data){
                return ListView.builder(
                  itemCount: data.length,
                    itemBuilder: (context, index){
                     return ListTile(
                       leading: CircleAvatar(
                         backgroundImage: NetworkImage(data[index].imageUrl!),
                       ),
                       title: Text(data[index].name!),
                     );
                    }
                );
              },
              error: (err, stack) => Text('$err'),
              loading: () => Center(child: CircularProgressIndicator())
          ),
        )
    );
  }
}
