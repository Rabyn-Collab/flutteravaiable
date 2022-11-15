import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/fire_instances.dart';
import 'package:fluttersamplestart/providers/room_provider.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatPage extends StatelessWidget {
  final types.Room room;
  ChatPage(this.room);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
         builder: (context, ref, child) {
           final messageData = ref.watch(messageStream(room));
           return Container(
             child: messageData.when(
                 data: (data){
                   return Chat(
                     messages: data,
                     showUserAvatars: true,
                     showUserNames: true,
                     onSendPressed: (PartialText ) {

                     }, user: types.User(
                     id: FireInstances.fireChatCore.firebaseUser!.uid
                   )
                   );
                 },
                 error: (err, stack) => Text('$err'),
                 loading: () => Center(child: CircularProgressIndicator())
             ),
           );
         }
          )
    );
  }
}
