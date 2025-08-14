
import 'package:calling_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../callservice/callservice.dart';
import '../home_screen/home_screen.dart';


class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final  phoneNumberController = TextEditingController();

  final  userNameController = TextEditingController();

  final  keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {



    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 450,
              width: double.infinity,
              decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50,),
                    const Text("Calling App",style: TextStyle(color: Colors.white, fontSize: 30),),
                    const SizedBox(height: 10,),
                    const Text("Login to your account",style: TextStyle(color: Colors.white, fontSize: 20),),
                    const SizedBox(height: 30,),
                    Image.asset("assets/images/pngwing.com.png", width: 130,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter your phone number";
                        }
                        return null;
                      },
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter your phone number",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter username";
                        }
                        return null;
                      },
                      controller: userNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Enter username",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 20,),
                    MaterialButton(
                      minWidth: 210,
                      height: 50,
                      onPressed: (){
                        if(keyForm.currentState!.validate()){
                          sharedPreferences!.setString("phoneNumber", phoneNumberController.text);
                          sharedPreferences!.setString("username", userNameController.text);
                          CallService callService = CallService();
                          callService.onUserLogin(phoneNumberController.text,
                              userNameController.text);
                          Get.to(HomeScreen());
                        }
                      },
                      color: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("Login",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),


    );
  }
}
