import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/view/sign_up_page.dart';
import '../common/snack_show.dart';
import '../providers/auth_provider.dart';
import 'package:get/get.dart';

class LoginPage extends ConsumerWidget {
   LoginPage({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();
  final passController = TextEditingController();
  final mailController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(authProvider, (previous, next) {
     if(next.err != ''){
     SnackShow.showFailureSnack(context, next.err);
     }
    });

    final deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;
    final auth = ref.watch(authProvider);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    height: deviceHeight * 0.33,
                    color: Colors.grey[290],
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Image.asset(
                            'assets/images/shop.png',
                            height: deviceHeight * 0.1,
                          ),
                        )),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                             'Don\'t Have a Account',
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {
                                _form.currentState!.reset();
                                Get.to(() => SignUpPage(), transition:  Transition.leftToRight);
                              },
                              child:  Text(
                                "Sign Up",
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                  right: width * 0.08,
                  left: width * 0.08,
                  top: deviceHeight * 0.21,
                  child: Form(
                    key: _form,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: deviceHeight * 0.48 ,
                        child: (
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                   Padding(
                                    padding: EdgeInsets.only(top: 60.0),
                                    child: Text(
                                     "Login",
                                      style: TextStyle(
                                          fontSize: 22, color: Color(0xff4252B5)),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  _buildPadding(
                                      valid: (val){
                                        if(val!.isEmpty){
                                          return 'please provide email';
                                        }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)){
                                          return 'please provide  valid email';
                                        }
                                        return null;
                                      },
                                    controller: mailController,
                                    hintText: 'Email',
                                    icon: CupertinoIcons.mail
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  _buildPadding(
                                      valid: (val){
                                        if(val!.isEmpty){
                                          return 'please provide password';
                                        }else if(val.length > 20){
                                          return 'maximum length is 19';
                                        }
                                        return null;
                                      },
                                      isPass: true,
                                    controller: passController,
                                      hintText: 'Password',
                                      icon: CupertinoIcons.padlock
                                  ),
                                ],
                              ),
                            ),


                            const SizedBox(
                              height: 10,
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)),
                                    backgroundColor: const Color(0xff4252B5),
                                  ),
                                  onPressed: auth.isLoad ? null: () async {
                                    _form.currentState!.save();
                                    if(_form.currentState!.validate()) {
                                      //login method
                                      await ref.read(authProvider.notifier)
                                          .userLogin(
                                        email: mailController.text.trim(),
                                        password: passController.text.trim(),
                                      );
                                    }
                                  },
                                  child:auth.isLoad ? CircularProgressIndicator(): const Text("Submit")),
                            )
                          ],
                        )),
                      ),
                    ),
                  )),

            ],
          )),
    );
  }

  TextFormField _buildPadding({required String hintText,
    required IconData icon,
  required TextEditingController controller,
  required String? Function(String?)? valid,
    bool? isPass
  }) {
    return TextFormField(
      controller:  controller,
      validator: valid,
      obscureText: isPass == true  ? true: false,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        hintText: hintText,
        suffixIcon: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}
