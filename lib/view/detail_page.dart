import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/models/posts.dart';
import 'package:fluttersamplestart/providers/fire_crud_providers.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:fluttersamplestart/service/firebase_crud_service.dart';


class DetailPage extends StatelessWidget {
  final Post post;
  final types.User user;
  DetailPage(this.post, this.user);
final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
             Image.network(post.imageUrl, height: 300, width: double.infinity,fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer(
                builder: (context, ref, child) {
                  final postData = ref.watch(singlePostStream(post.id));
                  return Column(
                    children: [
                      Text(post.detail),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: commentController,
                        decoration: InputDecoration(
                            hintText: 'add comment'
                        ),
                        onFieldSubmitted: (val) {
                         ref.read(crudProvider.notifier).addComment(comment: Comment(
                             imageUrl: user.imageUrl!,
                             text: val,
                             username: user.firstName!
                         ), id: post.id);
                         commentController.clear();
                        },
                      ),
                      postData.when(data: (data){
                        return Column(
                          children: data.comments.map((e) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Image.network(e.imageUrl),
                                    title: Text(e.username),
                                    subtitle: Text(e.text),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }, error: (err, stack) => Text('$err'), loading: () => Center(child: CircularProgressIndicator())
                      )

                    ],
                  );
                }
              ),
            )
          ],
        )
    );
  }
}
