import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_repository.dart';

// ignore: prefer_typing_uninitialized_variables

final authControllerProvider = Provider((ref) {
  final authRespository = ref.watch(authrepoProvider);

  return AuthController(authrepository: authRespository);
});

//future provider

class AuthController {
  late final AuthRespository authrepository;

  AuthController({required this.authrepository});

  void updatePassword({required String password}) {}

  void signInwithGmailAndPassword(
      {required String email,
      required String pass,
      required BuildContext context}) {
    authrepository.signInwithEmailandPas(email, pass, context);
  }

  //method for Gmail authentication
  void resetPaswordInrepo(String email, BuildContext context) {
    authrepository.resetPasword(email, context);
  }

  void updateEmail({required String email}) {
    authrepository.updateEmail(email);
  }

  void signUpwithEmailandPasword(
      String email, String password, BuildContext context) {
    authrepository.sigUpwithEmailAndPasword(
        Email: email, Password: password, context: context);
  }

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
