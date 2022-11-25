import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/view/login_page.dart';

import '../providers/auth_provider.dart';
import 'home_page.dart';





class StatusPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    FlutterNativeSplash.remove();
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final authData = ref.watch(authProvider);
              return authData.user.isEmpty ? LoginPage() : HomePage();
            }
    )
    );
  }
}
