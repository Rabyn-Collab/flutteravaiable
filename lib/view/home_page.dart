import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/fire_instances.dart';
import 'package:fluttersamplestart/providers/firebase_auth_provider.dart';
import 'package:fluttersamplestart/service/firebase_crud_service.dart';
import 'package:fluttersamplestart/view/create_page.dart';
import 'package:get/get.dart';





class HomePage extends ConsumerWidget {

  final uid = FireInstances.fireAuth.currentUser!.uid;

  @override
  Widget build(BuildContext context, ref) {
    final friendData = ref.watch(friendStream);
    final userData = ref.watch(singleUserStream);
    final postData = ref.watch(postStream);
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Chat'),
      ),
        drawer: Drawer(
          child: userData.when(
              data: (data){
                return ListView(
                  children: [
                    DrawerHeader(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(data.imageUrl!), fit: BoxFit.cover)
                          ),
                          child: Text(data.firstName!, style: TextStyle(color: Colors.white),),
                        )
                    ),
                    ListTile(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      leading: Icon(Icons.mail),
                      title: Text(data.metadata!['email']),
                    ),
                    ListTile(
                      onTap: (){
                        Navigator.of(context).pop();
                        Get.to(() => CreatePage(), transition: Transition.leftToRight);
                      },
                      leading: Icon(Icons.add_circle),
                      title: Text('Create Post'),
                    ),
                    ListTile(
                      onTap: (){
                        Navigator.of(context).pop();
                        ref.read(authProvider.notifier).userLogOut();
                      },
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Sign Out'),
                    )
                  ],
                );
              },
              error: (err, stack) => Center(child: Text('$err')),
              loading: () => Center(child: CircularProgressIndicator())
          )
        ),
        body: Column(
          children: [
            Container(
              height: 140,
              child:  friendData.when(
                  data: (data){
                    return ListView.builder(
                      itemCount: data.length,
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 36,
                                 backgroundImage: NetworkImage( data[index].imageUrl!),
                                 ),
                              SizedBox(height: 10,),
                              Text(data[index].firstName!)
                            ],
                          ),
                        );
                        }
                    );
                  },
                  error: (err, stack) => Center(child: Text('$err')),
                  loading: () => Container()
              ),
            ),
            Expanded(
                child: postData.when(
                    data: (data){
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: data.length,
                          itemBuilder: (context, index){
                          return Container(
                            height: 455,
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data[index].title),
                                        if(uid == data[index].uid) IconButton(
                                            style: IconButton.styleFrom(
                                              minimumSize: Size.zero, // Set this
                                              padding: EdgeInsets.zero,
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap
                                            ),
                                            onPressed: (){}, icon: Icon(Icons.more_horiz))
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Image.network(data[index].imageUrl, fit: BoxFit.cover, height: 300, width: double.infinity,),
                                    SizedBox(height: 20,),
                                    Text(data[index].detail, overflow: TextOverflow.ellipsis,)
                                  ],
                                ),
                              ),
                            ),
                          );
                          }
                      );
                    },
                    error: (err, stack) => Text('$err'),
                    loading: () => Center(child: CircularProgressIndicator(),)
                )
            )
          ],
        )
    );
  }
}
