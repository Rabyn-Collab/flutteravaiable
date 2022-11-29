import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/crud_providers.dart';
import 'package:get/get.dart';
import '../common/snack_show.dart';
import '../providers/common_provider.dart';

class CreatePage extends ConsumerWidget {
  CreatePage({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final detailController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(crudProvider, (previous, next) {
      if(next.err != ''){
        SnackShow.showFailureSnack(context, next.err);
      }
    });

    final deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;
    final image = ref.watch(imageProvider);
    final crud = ref.watch(crudProvider);
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
                    color: const Color(0xff4252B5),
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
                        height: deviceHeight * 0.60,
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
                                          "Create Product" ,
                                          style: TextStyle(
                                              fontSize: 22, color: Color(0xff4252B5)),
                                        ),
                                      ),

                                      Column(
                                        children: [
                                          const SizedBox(height: 20,),
                                          _buildPadding(
                                              valid: (val){
                                                if(val!.isEmpty){
                                                  return 'please provide label';
                                                }
                                                return null;
                                              },
                                              controller: nameController,
                                              hintText: 'title',
                                              icon: CupertinoIcons.add_circled_solid
                                          ),
                                        ],
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),
                                      _buildPadding(
                                          valid: (val){
                                            if(val!.isEmpty) {
                                              return 'please provide detail';
                                            }
                                            return null;
                                          },
                                          controller: detailController,
                                          hintText: 'Detail',
                                          icon: CupertinoIcons.doc_text_viewfinder
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      _buildPadding(
                                          valid: (val){
                                            if(val!.isEmpty){
                                              return 'please provide price';
                                            }
                                            return null;
                                          },
                                          isPass: true,
                                          controller: priceController,
                                          hintText: 'Price',
                                          icon: CupertinoIcons.drop_triangle,
                                        isPrice: true
                                      ),
                                    ],
                                  ),
                                ),

                                 Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white
                                    ),
                                    onPressed: (){
                                      showDialog(context: context, builder: (context){
                                        return AlertDialog(
                                          title: Text('choose option'),
                                          actions: [
                                            TextButton(
                                                onPressed: (){
                                                  Navigator.of(context).pop();
                                                  ref.read(imageProvider.notifier).pickAnImage(true);
                                                }, child: Text('camera')),
                                            TextButton(
                                                onPressed: (){
                                                  Navigator.of(context).pop();
                                                  ref.read(imageProvider.notifier).pickAnImage(false);
                                                }, child: Text('gallery')),
                                          ],
                                        );
                                      });
                                    },
                                    child: image != null ? Image.file(File(image.path)):  Center(
                                        child: Text('please select an image', style: TextStyle(color: Colors.black),)),
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
                                      onPressed: crud.isLoad ? null: () async {
                                        _form.currentState!.save();
                                        if(_form.currentState!.validate()){


                                            if(image == null){
                                              Get.defaultDialog(
                                                  title: 'required image',
                                                  content: Text('please provide image'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: (){
                                                          Navigator.of(context).pop();
                                                        }, child: Text('close'))
                                                  ]
                                              );
                                            }else{

                                              await ref.read(crudProvider.notifier).productAdd(
                                                 image: image,
                                                detail: detailController.text.trim(),
                                                price: int.parse(priceController.text.trim()),
                                                title: nameController.text.trim()
                                              );

                                            }

                                        }


                                      },
                                      child:crud.isLoad ? CircularProgressIndicator(): const Text("Submit")),
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
    bool? isPass,
    bool? isPrice
  }) {
    return TextFormField(
      controller:  controller,
      validator: valid,
      keyboardType: isPrice == true ? TextInputType.number : TextInputType.text,
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