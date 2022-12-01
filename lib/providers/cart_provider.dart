import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../main.dart';
import '../models/cart_item.dart';
import '../models/product.dart';


final cartProvider = StateNotifierProvider<CartProvider, List<CartItem>>((ref) => CartProvider(ref.watch(boxB)));



class CartProvider extends StateNotifier<List<CartItem>>{
  CartProvider(super.state);

  String addToCart(Product product){
     if(state.isEmpty){
       final newCart = CartItem(
           imageUrl: product.image,
           id: product.id,
           price: product.price,
           title: product.product_name,
           quantity: 1,
           total: product.price
       );
       Hive.box<CartItem>('carts').add(newCart);
       state = [newCart];
       return 'successfully added to cart';
     }else{
       final isPro = state.firstWhere((element) => element.id == product.id, orElse: () => CartItem.empty());
       if(isPro.title == 'no-data'){
         final newCart = CartItem(
             imageUrl: product.image,
             id: product.id,
             price: product.price,
             title: product.product_name,
             quantity: 1,
             total: product.price
         );
         Hive.box<CartItem>('carts').add(newCart);
         state = [...state, newCart];
         return 'successfully added to cart';
       }else{
         return 'already added to cart';
       }
     }
  }


  void singleAddToCart(CartItem cartItem){
      cartItem.quantity = cartItem.quantity + 1;
      cartItem.price = (cartItem.quantity + 1) * cartItem.price;
      cartItem.save();
      state = [
        for(final cart in state) if(cart.id == cartItem.id) cartItem else cart
      ];
  }



  void singleRemoveToCart(CartItem cartItem){
    if(cartItem.quantity > 1){
      cartItem.quantity = cartItem.quantity - 1;
      cartItem.price = (cartItem.quantity - 1) * cartItem.price;
      cartItem.save();
      state = [
        for(final cart in state) if(cart.id == cartItem.id) cartItem else cart
      ];
    }

  }

  void Remove(CartItem cartItem){
    cartItem.delete();
     state.remove(cartItem);
     state = [...state];
  }

  void clear(){
    Hive.box<CartItem>('carts').clear();
    state = [];
  }


  int get total{
   int total = 0;
   for(final cart in state){
      total += cart.quantity * cart.price;
   }
   return total;
  }




}