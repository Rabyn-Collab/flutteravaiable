import 'package:dartz/dartz.dart';
import '../models/user.dart';
import 'package:dio/dio.dart';

class AuthService {

 static Future<Either<String, User>> userSignUp({required String email, required String password,
   required String username}) async {
    try {

      return Right(User());
    } on DioError  catch (err) {
      return Left('');
    }
  }


 static Future<Either<String, User>> userLogin({required String email,required String password}) async {
   try {

     return Right(User());
   } on DioError catch (err) {
     return Left('');
   }
 }


}
