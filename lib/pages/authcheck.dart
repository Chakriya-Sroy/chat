import 'package:chat/controller/auth.dart';
import 'package:chat/pages/auth/login.dart';
import 'package:chat/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});
 
  @override
 
  Widget build(BuildContext context) {
  return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (auth) {
        return Obx(() {
          if (auth.isUserLogin.value) {
            return Home();
          } else {
            return Login();
          }
        });
      },
    ); 
}}


