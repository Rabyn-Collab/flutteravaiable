import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/common_provider.dart';
import 'package:fluttersamplestart/providers/room_provider.dart';
import 'package:fluttersamplestart/service/firebase_crud_service.dart';
import 'package:fluttersamplestart/view/chat_page.dart';
import 'package:get/get.dart';


class UserDetail extends StatelessWidget {
final types.User user;
UserDetail(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.imageUrl!),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(user.firstName!),
                        Text(user.metadata!['email']),
                        Consumer(
                          builder: (context, ref, child) {
                            final isLoad = ref.watch(loadingProvider);
                            return  ElevatedButton(
                                onPressed: isLoad ? null : () async{
                                  ref.read(loadingProvider.notifier).toggle();
                                    final response = await ref.read(roomProvider).roomCreate(user);
                                  ref.read(loadingProvider.notifier).toggle();
                                    if(response != null){
                                      Get.to(() => ChatPage(response, user.metadata!['token'], user.firstName!), transition: Transition.leftToRight);
                                    }
                                }, child: Text('Chat')
                            );
                          }
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Consumer(
                  builder: (context, ref, child){
                    final userPost = ref.watch(userPostStream(user.id));
                    return userPost.when(
                        data: (data){
                         return GridView.builder(
                           shrinkWrap: true,
                           itemCount: data.length,
                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                               mainAxisSpacing: 5,
                                 crossAxisSpacing: 5,
                                 crossAxisCount: 2,
                               childAspectRatio: 2/3
                             ),
                             itemBuilder: (context, index){
                             return Image.network(data[index].imageUrl);
                             }
                         );
                        },
                        error: (err, stack) => Text('$err') ,
                        loading: () => Center(child: CircularProgressIndicator())
                    ) ;
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
