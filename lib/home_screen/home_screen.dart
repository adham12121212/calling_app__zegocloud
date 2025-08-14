
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../callservice/callservice.dart';
import '../login_screen/login_screen.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  CallService callService = CallService();


  initState() {
    super.initState();
    callService.onUserLogin(
      sharedPreferences!.getString("phoneNumber")!, sharedPreferences!.getString("username")!);
  }

  final phoneController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: AppBar(
        title: const Text("Calling App"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                children: [
                  Text("Calling App",style: TextStyle(color: Colors.white, fontSize: 30),),
                  SizedBox(height: 10,),
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" Phone: ${sharedPreferences!.getString("phoneNumber")!}",style: TextStyle(color: Colors.white, fontSize: 25),),
                          Text(" Name: ${sharedPreferences!.getString("username")!}",style: TextStyle(color: Colors.white, fontSize: 25),),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            ListTile(
              title: const Text("Logout",style: TextStyle(color: Colors.deepPurple, fontSize: 25,fontWeight: FontWeight.bold),),
              onTap: () {
                callService.onUserLogout();
                sharedPreferences!.clear();
                sharedPreferences!.remove("phoneNumber");
                sharedPreferences!.remove("username");
                Get.off(const LoginScreen());
              },
            ),
          ],
        ),
      ),
      body: Center(
       child: Padding(
         padding: const EdgeInsets.all(25.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             TextFormField(
               controller: phoneController,
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
             const SizedBox(height: 20,),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {
                 ZegoUIKitPrebuiltCallInvitationService().send(
                   resourceID: "callingapp" ,
                     invitees: [
                       ZegoCallUser(phoneController.text, userNameController.text,),
                     ],
                     isVideoCall: true
                 );
                },
                child: const Icon(Icons.call,color: Colors.white,size: 30,),
              ),
            ),

           ],
         ),
       ),
      ),
    );
  }
}
