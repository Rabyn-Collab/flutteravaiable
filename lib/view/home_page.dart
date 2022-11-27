import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/auth_provider.dart';
import 'package:fluttersamplestart/service/crud_service.dart';


class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final productDb = ref.watch(productData);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
          actions: [
            TextButton(onPressed: (){
              ref.read(authProvider.notifier).userLogOut();
            }, child:Text('Log Out', style: TextStyle(color: Colors.white),))
          ],
      ),
        body: Container(
          child: productDb.when(
              data: (data){
                return GridView.builder(
                  itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 3/2,
                        crossAxisCount: 2
                    ),
                    itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridTile(
                        header: Image.network(data[index].image),
                          child: Container(),
                        footer: Container(
                          color: Colors.black45,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(data[index].product_name, style: TextStyle(color: Colors.white),),
                              Text('${data[index].price}', style: TextStyle(color: Colors.white),)
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
        )
    );
  }
}
