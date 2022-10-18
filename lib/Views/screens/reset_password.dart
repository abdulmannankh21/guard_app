
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guard_app/Features/authentiction/auth_provider.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ResetPasswordScreen> createState() => _PasswordState();
}

class _PasswordState extends ConsumerState<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  Widget textItem(
      String name, TextEditingController controller, bool obsecureText) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Color.fromARGB(255, 106, 106, 106),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Password Reset",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Please enter your registered email we'll ")],
            ),
            Padding(
              padding: EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("send a password reset email to it")],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [textItem("Email", emailController, false)],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: (() {
              
                ref
                    .read(authControllerProvider)
                    .resetPaswordInrepo(emailController.text, context);
                
              }),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: Text(
                    "Reset",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
