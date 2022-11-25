import 'package:dartz/dartz.dart';
import 'package:fluttersamplestart/api.dart';
import '../exceptions/api_exception.dart';
import '../models/user.dart';
import 'package:dio/dio.dart';

class AuthService {

  static final dio = Dio();

 static Future<Either<String, User>> userSignUp({required String email, required String password,
   required String username}) async {
    try {
      final response = await dio.post(Api.signUp, data: {
        'email': email,
        'password': password,
        'full_name': username
      });
      return Right(User.fromJson(response.data));
    } on DioError  catch (err) {
      return Left(DioException.fromDioError(err).errorMessage);
    }
  }


 static Future<Either<String, User>> userLogin({required String email,required String password}) async {
   try {
     final response = await dio.post(Api.login, data: {
       'email': email,
       'password': password
     });
     return Right(User.fromJson(response.data));
   } on DioError catch (err) {
     return Left(DioException.fromDioError(err).errorMessage);
   }
 }


}
