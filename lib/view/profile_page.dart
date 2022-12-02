import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/auth_provider.dart';



class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text(auth.user[0].username),
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text(auth.user[0].email),
          ),
          ListTile(
            onTap: (){
              ref.read(authProvider.notifier).userLogOut();
            },
            leading: Icon(Icons.exit_to_app),
            title: Text('LogOut'),
          ),
        ],
      ),
    );
  }
}
