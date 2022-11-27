import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/view/login_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/user.dart';
import '../providers/auth_provider.dart';
import 'home_page.dart';





class StatusPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    FlutterNativeSplash.remove();
    return Scaffold(
        body: ValueListenableBuilder<Box<User>>(
          valueListenable: Hive.box<User>('user').listenable(),
          builder: (c, box, w) {
            return box.isEmpty ? LoginPage() : HomePage();
          }
        )
    );
  }
}
