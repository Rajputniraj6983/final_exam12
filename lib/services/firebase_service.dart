import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthServices {
  static AuthServices authServices = AuthServices._();
  AuthServices._();
  final FirebaseAuth auth = FirebaseAuth.instance;


  Future<void> createAcc(String mail, String pass) async {
    try{
      UserCredential userCrediental = await auth.createUserWithEmailAndPassword(email: mail,password: pass);
      print(userCrediental.user!.email);
    }catch(e)
    {
      log(e.toString());
    }
  }
  Future<String> loginApp(String mail,String pass) async {
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: mail, password: pass);
      log(userCredential.user!.email.toString());
      getCurrentUser();
      return 'Success';
    }
    catch(e)
    {
      return 'fail';
    }
  }
  User? getCurrentUser(){
    User? user = auth.currentUser;
    return user;
  }
  Future<void> currentUser() async {
    User? user = auth.currentUser;
    if (user == null) {
      Get.back();
    }
  }
}
