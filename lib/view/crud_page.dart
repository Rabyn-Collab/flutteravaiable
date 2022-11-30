import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/crud_providers.dart';
import 'package:fluttersamplestart/view/edit_page.dart';
import 'package:get/get.dart';

import '../service/crud_service.dart';



class CrudPage extends ConsumerWidget {


  @override
  Widget build(BuildContext context, ref) {
    final productDb = ref.watch(productData);
    return Container(
      child: productDb.when(
          data: (data){
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading:Container(
                          height: 100,
                          width: 100,
                          child: Image.network(data[index].image)),
                      title: Text(data[index].product_name,),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           IconButton(onPressed: (){
                             Get.to(() => EditPage(data[index]), transition: Transition.leftToRight);
                           }, icon: Icon(Icons.edit)),
                           IconButton(
                               onPressed: () async{
                            await ref.read(crudProvider.notifier).removeProduct(imageId: data[index].imageId, id: data[index].id);
                           }, icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          },
          error: (err, stack) => Center(child: Text('$err')),
          loading: () => Center(child: CircularProgressIndicator())
      ),
    );
  }
}
