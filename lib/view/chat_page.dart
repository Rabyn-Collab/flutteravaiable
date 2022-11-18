import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/fire_instances.dart';
import 'package:fluttersamplestart/providers/room_provider.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../providers/common_provider.dart';

class ChatPage extends StatelessWidget {
  final types.Room room;
  final String token;
  final String name;
  ChatPage(this.room, this.token, this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
         builder: (context, ref, child) {
           final messageData = ref.watch(messageStream(room));
           final isLoad = ref.watch(loadingProvider);
           return Container(
             child: messageData.when(
                 data: (data){
                   return Chat(
                     scrollPhysics: BouncingScrollPhysics(),
                     messages: data,
                     showUserAvatars: true,
                     showUserNames: true,
                       isAttachmentUploading: isLoad,
                       onAttachmentPressed: () async{
                         final ImagePicker _picker = ImagePicker();
                          await _picker.pickImage(source: ImageSource.gallery).then((value) async{
                             if(value != null){
                               try{
                                 ref.read(loadingProvider.notifier).toggle();
                                 final imageId = DateTime.now().toString();
                                 final ref1 = FireInstances.fireStorage.ref().child('chatImage/${imageId}');
                                 await ref1.putFile(File(value.path));
                                 final imageUrl = await ref1.getDownloadURL();
                                 final size = File(value.path).lengthSync();
                                 final message = types.PartialImage(
                                   size: size,
                                   name: value.name,
                                   uri: imageUrl,
                                 );
                                 FireInstances.fireChatCore.sendMessage(
                                   message,
                                   room.id,
                                 );
                                 ref.read(loadingProvider.notifier).toggle();

                               }catch(err){
                                 ref.read(loadingProvider.notifier).toggle();
                               }
                             }
                          });



                       },
                     onSendPressed: (PartialText  message) async{
                       FireInstances.fireChatCore.sendMessage(
                         message,
                         room.id,
                       );
                       final dio = Dio();
                       try{
                         final response = await dio.post('https://fcm.googleapis.com/fcm/send',
                             data: {
                               "notification": {
                                 "title": name,
                                 "body": message.text,
                                 "android_channel_id": "High_importance_channel"
                               },
                               "to": token

                             }, options: Options(
                                 headers: {
                                   HttpHeaders.authorizationHeader : 'key=AAAAVbRrRuw:APA91bGtG4BJVQj_iEO-v3-6-7ChYkOeWT-PexWj0f0em6aHerNaS9DyGgLQw5qkaICjjB85ABZpOOv_KveL5RZm2ZsRe4Ou59OGRslszg0V5ePUaL6iivIiM8pigHKkXCuLzQbJR5dP'
                                 }
                             )
                         );
                         print(response.data);

                       }on FirebaseException catch (err){
                         print(err);
                       }
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
