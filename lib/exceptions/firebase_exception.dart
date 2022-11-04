
class AuthExceptionHandler {

  static String handleException(e) {
    switch (e.code) {
      case "user-not-found":
       return "Your email address appears to be malformed.";

      case "wrong-password":
        return "Your password is wrong.";

      case "ERROR_USER_NOT_FOUND":
        return "User with this email doesn't exist.";

      case "ERROR_USER_DISABLED":
      return  "User with this email has been disabled.";

      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many requests. Try again later.";


      case "network-request-failed":
        return "no internet connection";


      case "ERROR_EMAIL_ALREADY_IN_USE":
      return    "The email has already been registered. Please login or reset your password.";

      default:
        return   "An undefined Error happened.";
    }

  }



}