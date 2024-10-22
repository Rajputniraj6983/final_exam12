import 'package:final_exam1/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';



class AuthController {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpass = TextEditingController();

  void signUp(String email, String pass){
    AuthServices.authServices.createAcc(email, pass);
  }

  Future<String> signIn(String email,String pass)
  {
    return  AuthServices.authServices.loginApp(email, pass);
  }
}
