import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/fire_instances.dart';



final roomStream = StreamProvider.autoDispose((ref) => FireInstances.fireChatCore.rooms());
final messageStream = StreamProvider.family.autoDispose((ref, types.Room room) => FireInstances.fireChatCore.messages(room));
final roomProvider = Provider((ref) => RoomProvider());

class RoomProvider{


  Future<types.Room?> roomCreate(types.User user) async{
       try{
         final response = await FireInstances.fireChatCore.createRoom(user);
         return response;
       }catch(err){
         return null;
       }
  }


}