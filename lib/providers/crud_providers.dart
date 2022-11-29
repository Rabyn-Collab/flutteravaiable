import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product_state.dart';
import '../service/crud_service.dart';



final crudProvider = StateNotifierProvider<CrudProvider, ProductState>(
        (ref) => CrudProvider(ProductState.initState(), ref));

class CrudProvider extends StateNotifier<ProductState> {

  final StateNotifierProviderRef ref;
  CrudProvider(super.state, this.ref);




  Future<void> productAdd(
      {
        required String title,
        required String detail,
        required XFile image,
        required int price ,
      }) async {
    final auth = ref.watch(authProvider);
    state = state.copyWith( isLoad: true, err: '', isSuccess: false);
    final response = await CrudService.addProduct(title: title, detail: detail, price: price, image: image, token:auth.user[0].token );
    response.fold((l) {
      state = state.copyWith( isLoad: false, err: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(isLoad: false, err: '', isSuccess: r);
    });
  }


//update post
//   Future<void> updatePost(
//       {
//         required String title,
//         required String detail,
//         XFile? image,
//         String? imageId,
//         required String id,
//       }) async {
//     state = state.copyWith(postState: state, isLoad: true, err: '', isSuccess: false);
//     final response = await FirebaseCrudService.updatePost(title: title,
//       detail: detail, image: image, id: id, imageId: imageId);
//     response.fold((l) {
//       state = state.copyWith(postState: state, isLoad: false, err: l);
//     }, (r) {
//       state = state.copyWith(postState: state, isLoad: false, err: '', isSuccess: r);
//     });
//   }


//remove post
//   Future<void> removePost(
//       {
//        required String imageId,
//         required String id,
//       }) async {
//     state = state.copyWith(postState: state, isLoad: true, err: '', isSuccess: false);
//     final response = await FirebaseCrudService.removePost(id: id, imageId: imageId);
//     response.fold((l) {
//       state = state.copyWith(postState: state, isLoad: false, err: l);
//     }, (r) {
//       state = state.copyWith(postState: state, isLoad: false, err: '', isSuccess: r);
//     });
//   }







}
