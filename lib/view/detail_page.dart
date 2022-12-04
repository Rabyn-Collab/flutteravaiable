import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/common/snack_show.dart';
import 'package:fluttersamplestart/models/product.dart';
import 'package:fluttersamplestart/providers/cart_provider.dart';



class DetailPage extends StatelessWidget {
  final Product product;
  DetailPage(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea( 
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                 color: Color(0xFFdad7ef),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                ),
                margin: EdgeInsets.only(top: 220),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.product_detail),
                      Consumer(
                          builder: (context, ref, child) {
                            return ElevatedButton(
                                onPressed: () {
                                  final response = ref.read(cartProvider.notifier).addToCart(product);
                                  if(response != 'already added to cart'){
                                    SnackShow.showFailureSnack(context, response, true);
                                  }else{
                                    SnackShow.showCommonSnack(context, response, true);
                                  }
                                }, child: Text('Add To Cart'));
                          }
    )
                    ],
                  ),
                ),
              ),

              Container(
                height: 250,
                 padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.product_name),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rs.${product.price}'),
                          SizedBox(width: 100,),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(product.image, fit: BoxFit.cover, height: 200, width: 200,)),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
