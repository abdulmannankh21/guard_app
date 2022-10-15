import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_repository.dart';
import 'dart:io';

import 'package:guard_app/Models/user_model.dart';

// ignore: prefer_typing_uninitialized_variables

final authControllerProvider = Provider((ref) {
  
  final authRespository = ref.watch(authrepoProvider);

  return AuthController(authrepository: authRespository);
});

//future provider



class AuthController {
  late final AuthRespository authrepository;

  AuthController({required this.authrepository});



  //method for Gmail authentication

  void signInWithGoogle(BuildContext ctx) {
    authrepository.signInWithGoogle(context: ctx);
  }

  void signInWithPhone(BuildContext context, String phone) {
    // ignore: avoid_print
    print(phone);
    authrepository.signInWithPhoneNumber(phone, context);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authrepository.verifyOTP(
        context: context, verificationId: verificationId, userOTP: userOTP);
  }

 
}
