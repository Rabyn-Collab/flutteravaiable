import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/fire_crud_providers.dart';
import '../common/snack_show.dart';
import '../models/posts.dart';
import '../providers/common_provider.dart';

class EditPage extends ConsumerStatefulWidget {
  final Post post;
  EditPage(this.post, {Key? key}) : super(key: key);


  @override
  ConsumerState<EditPage> createState() => _EditPageState();
}

class _EditPageState extends ConsumerState<EditPage> {

  final _form = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();


  @override
  void initState() {
    titleController..text = widget.post.title;
    detailController..text = widget.post.detail;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ref.listen(crudProvider, (previous, next) {
      if(next.err != ''){
        SnackShow.showFailureSnack(context, next.err);
      }else if(next.isSuccess){
        Navigator.of(context).pop();
      }
    });

    final deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Image.asset(
                  'assets/images/firebase.png',
                  height: 100,
                  width: 100,
                ),
              ),
              Expanded(
                child: Form(
                  key: _form,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: (
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 60.0),
                                child: Text('EditPost',
                                  style: TextStyle(
                                      fontSize: 22, color: Color(0xff4252B5)),
                                ),
                              ),

                              _buildPadding(
                                  valid: (val){
                                    if(val!.isEmpty){
                                      return 'please provide title';
                                    }
                                    return null;
                                  },
                                  controller: titleController,
                                  hintText: 'Title',
                                  icon: CupertinoIcons.ant_circle_fill
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              _buildPadding(
                                  valid: (val){
                                    if(val!.isEmpty){
                                      return 'please provide detail';
                                    }else if(val.length >= 500){
                                      return 'maximum length is 500';
                                    }
                                    return null;
                                  },
                                  isPass: false,
                                  controller: detailController,
                                  hintText: 'Detail',
                                  icon: CupertinoIcons.arrow_down_doc
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  final image = ref.watch(imageProvider);
                                  final crud = ref.watch(crudProvider);
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)
                                          ),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white
                                              ),
                                              onPressed: () {
                                                showDialog(context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'choose option'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                                ref.read(imageProvider.notifier).pickAnImage(
                                                                    true);
                                                              },
                                                              child: Text(
                                                                  'camera')),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                                ref.read(imageProvider.notifier).pickAnImage(false);
                                                              },
                                                              child: Text(
                                                                  'gallery')),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: image != null ? Image.file(
                                                  File(image.path)) : Image
                                                  .network(widget.post.imageUrl)
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(14),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(15)),
                                              backgroundColor: const Color(
                                                  0xff4252B5),
                                            ),
                                            onPressed: crud.isLoad
                                                ? null
                                                : () async {
                                              _form.currentState!.save();
                                              if (_form.currentState!
                                                  .validate()) {
                                                if (image == null) {
                                                  ref.read(crudProvider.notifier).updatePost(
                                                    title: titleController.text.trim(),
                                                    detail: detailController
                                                        .text.trim(),
                                                    id: widget.post.id,
                                                  );
                                                } else {
                                                  ref.read(
                                                      crudProvider.notifier)
                                                      .updatePost(
                                                      title: titleController
                                                          .text.trim(),
                                                      detail: detailController
                                                          .text.trim(),
                                                      image: image,
                                                      id: widget.post.id,
                                                      imageId: widget.post.imageId
                                                  );
                                                }
                                              }
                                            },
                                            child: crud.isLoad
                                                ? CircularProgressIndicator()
                                                : const Text("Submit")),
                                      )

                                    ],
                                  );
                                }
                              ),

                            ],
                          )),
                    ),
                  ),
                ),
              ),

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
