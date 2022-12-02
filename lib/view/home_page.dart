import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/auth_provider.dart';
import 'package:fluttersamplestart/providers/common_provider.dart';
import 'package:fluttersamplestart/service/crud_service.dart';
import 'package:fluttersamplestart/view/create_page.dart';
import 'package:fluttersamplestart/view/detail_page.dart';
import 'package:fluttersamplestart/view/profile_page.dart';
import 'package:get/get.dart';

import 'cart_page.dart';
import 'crud_page.dart';


class HomePage extends ConsumerWidget {

  List<Widget> _pages = [
     _MainWidget(),
    CreatePage(),
   CrudPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context, ref) {
    final indexD = ref.watch(indexProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
          actions: [
           IconButton(onPressed: (){
             Get.to(() => CartPage(), transition:  Transition.leftToRight);
           }, icon: Icon(Icons.add_shopping_cart))
          ],
      ),
        body: _pages[indexD],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: indexD,
          onTap: (index){
       ref.read(indexProvider.notifier).change(index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add),label: 'Create'),
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit_sharp),label: 'Crud'),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
          ]
      ),
    );
  }
}

class _MainWidget extends ConsumerWidget {


  @override
  Widget build(BuildContext context, ref) {
    final productDb = ref.watch(productData);
    return Container(
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
                return InkWell(
                  onTap: (){
                    Get.to(() => DetailPage(data[index]), transition: Transition.leftToRight);
                  },
                  child: Padding(
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



