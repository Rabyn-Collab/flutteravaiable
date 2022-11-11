




import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/models/posts.dart';
import 'package:image_picker/image_picker.dart';
import '../models/auth_state.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../models/post_state.dart';
import '../service/firebase_crud_service.dart';






final crudProvider = StateNotifierProvider<CrudProvider, PostState>(
        (ref) => CrudProvider(PostState(isSuccess: false, err: '', isLoad: false)));

class CrudProvider extends StateNotifier<PostState> {
  CrudProvider(super.state);

  // add post
  Future<void> postAdd(
      {
        required String title,
        required String detail,
        required XFile image,
        required String uid,
      }) async {
    state = state.copyWith(postState: state, isLoad: true, err: '', isSuccess: false);
    final response = await FirebaseCrudService.addPost(title: title, detail: detail, image: image, uid: uid);
    response.fold((l) {
      state = state.copyWith(postState: state, isLoad: false, err: l);
    }, (r) {
      state = state.copyWith(postState: state, isLoad: false, err: '', isSuccess: r);
    });
  }


//update post
  Future<void> updatePost(
      {
        required String title,
        required String detail,
        XFile? image,
        String? imageId,
        required String id,
      }) async {
    state = state.copyWith(postState: state, isLoad: true, err: '', isSuccess: false);
    final response = await FirebaseCrudService.updatePost(title: title,
      detail: detail, image: image, id: id, imageId: imageId);
    response.fold((l) {
      state = state.copyWith(postState: state, isLoad: false, err: l);
    }, (r) {
      state = state.copyWith(postState: state, isLoad: false, err: '', isSuccess: r);
    });
  }


//remove post
  Future<void> removePost(
      {
       required String imageId,
        required String id,
      }) async {
    state = state.copyWith(postState: state, isLoad: true, err: '', isSuccess: false);
    final response = await FirebaseCrudService.removePost(id: id, imageId: imageId);
    response.fold((l) {
      state = state.copyWith(postState: state, isLoad: false, err: l);
    }, (r) {
      state = state.copyWith(postState: state, isLoad: false, err: '', isSuccess: r);
    });
  }


//add Like

   Future<void> addLike({required String username,
    required String id, required int likes}) async {
    state = state.copyWith(postState: state, isLoad: true, err: '', isSuccess: false);
    final response = await FirebaseCrudService.addLike(id: id, username: username, likes: likes);
    response.fold((l) {
      state = state.copyWith(postState: state, isLoad: false, err: l);
    }, (r) {
      state = state.copyWith(postState: state, isLoad: false, err: '', isSuccess: r);
    });
  }



  //add comment

  Future<void> addComment({required Comment comment,
    required String id}) async {
    state = state.copyWith(postState: state, isLoad: true, err: '', isSuccess: false);
    final response = await FirebaseCrudService.addComment(id: id, comment: comment);
    response.fold((l) {
      state = state.copyWith(postState: state, isLoad: false, err: l);
    }, (r) {
      state = state.copyWith(postState: state, isLoad: false, err: '', isSuccess: r);
    });
  }


}
