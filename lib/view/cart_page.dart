import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/auth_provider.dart';

import '../providers/cart_provider.dart';
import '../providers/order_providers.dart';






class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final cartData = ref.watch(cartProvider);
    final totalData = ref.watch(cartProvider.notifier).total;
    final auth = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: cartData.isEmpty ? Center(child: Text('Add Some')): Column(
            children: [
              Expanded(
                child: Container(
                  child:  ListView.builder(
                      itemCount: cartData.length,
                      itemBuilder: (context, index){
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Image.network(cartData[index].imageUrl, height: 200, width: 200,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cartData[index].title),
                                  Text('price:-Rs.${cartData[index].price}'),
                                  Row(
                                    children: [
                                      OutlinedButton(onPressed: (){
                                        ref.read(cartProvider.notifier).singleAddToCart(cartData[index]);
                                      }, child: Icon(Icons.add)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Text('${cartData[index].quantity}'),
                                      ),
                                      OutlinedButton(onPressed: (){
                                        ref.read(cartProvider.notifier).singleRemoveToCart(cartData[index]);
                                      }, child: Icon(Icons.remove))
                                    ],
                                  )

                                ],
                              )

                            ],
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total'),
                        Text('Rs. ${totalData}')
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () async{

                        final response =  await ref.read(orderProvider).createOrder(
                            totalData,
                            DateTime.now().toString(), cartData, auth.user[0].id, auth.user[0].token);
                        if(response !='success'){

                        }else{
                          ref.read(cartProvider.notifier).clear();
                        }

                    }, child: Text('CheckOut'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
