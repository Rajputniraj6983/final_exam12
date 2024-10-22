import 'package:final_exam1/controller/auth_controller.dart';
import 'package:final_exam1/services/firebase_service.dart';
import 'package:final_exam1/view/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {
   AuthController controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          height: 30,
          width: 30,
          decoration: ShapeDecoration.fromBoxDecoration(
            const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xFFF7F7F9)),
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Column(
          children: [const SizedBox(height: 150),
            const Text(
              "Sign in now",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
            ), const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controller.txtemail,
                decoration: InputDecoration(
                  hintText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),focusColor: const Color(0xFFF7F7F9),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controller.txtpass,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),focusColor: const Color(0xFFF7F7F9),
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined,color: Colors.grey,),
                ),
              ),
            ),
           const SizedBox(height: 20),
            Container(
              height: 70,
              width: 360,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color(0xFF24BAEC),
              ),
              child: Center(
                child: InkWell(onTap: () {
                  AuthServices.authServices.createAcc(controller.txtemail.text, controller.txtpass.text);
                  controller.txtemail.clear();
                  controller.txtpass.clear();
                  Get.to(const HomeScreen(),transition: Transition.leftToRight);
                },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
