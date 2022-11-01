import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/toggle_provider.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;
    final isLogin = ref.watch(loginProvider);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: deviceHeight * 0.33,
                color: const Color(0xff4252B5),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Image.asset(
                        'assets/images/firebase.png',
                        height: deviceHeight * 0.1,
                      ),
                    )),
              ),
              Positioned(
                  right: width * 0.08,
                  left: width * 0.08,
                  top: deviceHeight * 0.21,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    child: Container(
                      height: deviceHeight * 0.48,
                      child: (Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                 Padding(
                                  padding: EdgeInsets.only(top: 60.0),
                                  child: Text(
                                   isLogin ? "Login" : 'Sign Up',
                                    style: TextStyle(
                                        fontSize: 22, color: Color(0xff4252B5)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                _buildPadding(
                                  hintText: 'Email',
                                  icon: CupertinoIcons.mail
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                _buildPadding(
                                    hintText: 'Password',
                                    icon: CupertinoIcons.padlock
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  backgroundColor: const Color(0xff4252B5),
                                ),
                                onPressed: () {},
                                child: const Text("Submit")),
                          )
                        ],
                      )),
                    ),
                  )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Dont Have a Account?",
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                            onPressed: () {
                              ref.read(loginProvider.notifier).toggle();
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 18),
                            ))
                      ],
                    ),
                  )),
            ],
          )),
    );
  }

  Padding _buildPadding({required String hintText, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          hintText: hintText,
          suffixIcon: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
