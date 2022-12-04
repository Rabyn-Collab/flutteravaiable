import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/auth_provider.dart';

import '../providers/order_providers.dart';



class OrderHistory extends ConsumerWidget {


  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final order = ref.watch(orderHistory(auth.user[0].id));
    return Scaffold(
        body: Container(
          child: order.when(
              data: (data){
                return ListView.builder(
                  itemCount:  data.length,
                    itemBuilder: (context, index){
                    return ExpansionTile(
                        title: Text('${data[index].dateTime}'),
                      children: data[index].products.map((e) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(e.imageUrl, height: 200, width: 200,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(e.title),
                                      Text('price:-Rs.${e.price}'),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Text('${e.quantity}'),
                                      )

                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),

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
