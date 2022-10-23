import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:guard_app/Features/authentiction/auth_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordState();
}

class _PasswordState extends ConsumerState<PasswordScreen> {
  TextEditingController confirmPasword = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool obsecureState = true;
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if((FirebaseAuth.instance.currentUser?.email)!=null)
    emailController.text =  FirebaseAuth.instance.currentUser!.email!;
  }

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

  Widget passItem(
      BuildContext context, String name, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obsecureState,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: obsecureState
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                obsecureState = !obsecureState;
              });
            },
          ),
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
          "User SignIn",
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
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [textItem("Email", emailController, false)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  passItem(
                    context,
                    'Create your password',
                    password,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  passItem(
                    context,
                    'Confirm your password',
                    confirmPasword,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              //Todo add text field here
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                if (password.text == confirmPasword.text) {
                  ref.read(authControllerProvider).signUpwithEmailandPasword(
                      emailController.text, password.text,context);

                 
                } else {
                  EasyLoading.showError(
                      "Confirm Password and New Password should be similar ");
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: Text(
                    "Login",
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
