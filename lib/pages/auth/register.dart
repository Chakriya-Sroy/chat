import 'package:chat/controller/auth.dart';
import 'package:chat/pages/auth/login.dart';
import 'package:chat/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController auth =Get.put(AuthController());
    return Scaffold(
      body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(child:Icon(Icons.message,size: 50,color: Colors.blue,),alignment:Alignment.center),
                  Text("Chat"),
                  const SizedBox(height: 50,),
                  Obx(() => auth.message.isEmpty ? 
                          SizedBox():
                          Container(
                            height: 70,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red,width: 3),
                            ),
                            child: Text(auth.message.toString()),
                          )
                      ),
                  Obx(() => CustomerField(label: "Fullname", obscureText: false, controller: auth.fullname,icon: Icon(Icons.person),validateText: auth.fullnameValidation.string,)),
                  Obx(() => CustomerField(label: "Email",obscureText: false,controller: auth.email,icon: Icon(Icons.email),validateText: auth.emailValidation.toString(),)),
                  Obx(() => CustomerField(label: "Password",obscureText: true,controller: auth.password,icon: Icon(Icons.lock),validateText: auth.passwordValidation.toString(),)),          
                  Row(
                   children: [
                     Text("Already have an account ?"),
                     GestureDetector(onTap: (){Get.to(Login());},child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold),))
                   ],
                 ),
                  const SizedBox(height: 20,),
                  MaterialButton(
                  minWidth: double.infinity,
                  height: 70,
                   textColor: Colors.white,
                    color: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    elevation: 0,
                    onPressed: (){
                      auth.signUpWithEmailandPassword();
                    },child: Text("Register"),
                  ),
                
                 const SizedBox(height: 100,),
                ],
              ),
            ),
          ),
        
      
    );
  }
}