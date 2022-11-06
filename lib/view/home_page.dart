import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/firebase_auth_provider.dart';

import '../providers/fire_instances.dart';




class HomePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    final friendData = ref.watch(friendStream);
    final userData = ref.watch(singleUserStream);
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
                  loading: () => Center(child: CircularProgressIndicator())
              ),
            ),
          ],
        )
    );
  }
}
