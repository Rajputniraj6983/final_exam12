import 'package:final_exam1/view/screen/singup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/download.png')),SizedBox(height: 100),
          InkWell(onTap: () {
            Get.to(SingupScreen(),transition: Transition.leftToRight);
          },
            child: Container(alignment: Alignment.center,
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blueGrey,
              ),
              child: Text("Get Started",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
            ),
          )
        ],
      ),
    );
  }
}
