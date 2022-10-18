

import 'package:flutter/material.dart';
import 'package:guard_app/Features/authentiction/auth_provider.dart';
import 'package:guard_app/Views/screens/reset_password.dart';

import 'package:guard_app/Views/screens/signUp.dart';
import 'package:guard_app/constants.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  bool circular = false;
  bool hidepass = true;

  @override
 



  bool signUp = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  Widget PassItem(
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
          
          suffixIcon: IconButton(
            icon: obsecureText
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                hidepass = !hidepass;
              });
            },
          ),
          labelText: name,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Color.fromARGB(255, 81, 80, 80),
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

  Widget colorButton(String name) {
    return InkWell(
   
             
        onTap: (() =>  ref.read(authControllerProvider).signInwithGmailAndPassword(email:_emailController.text, pass: _passwordController.text,context: context)),
            
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 14, 3, 3),
            Color.fromARGB(255, 0, 0, 0),
          ]),
        ),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : Text(name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Align(
              alignment: AlignmentDirectional(-0.3, 0.6),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 130,
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.05, 1),
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Image(
                        image: AssetImage('images/logo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  textItem("Email or phone ", _emailController, false),
                  const SizedBox(
                    height: 15,
                  ),
                  PassItem("Password", _passwordController, hidepass),
                   Padding(padding: const EdgeInsets.all(2),child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                  TextButton(onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ResetPasswordScreen())),
                  child: const Text("forgot password?",style: TextStyle(fontWeight: FontWeight.bold),),
                  )],),),
                  Padding(padding: const EdgeInsets.all(1),child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ const Text("  if you don't have account click here for"),
                  TextButton(child: const Text("Signup",style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),)),)],),),
                  const SizedBox(
                    height: 15,
                  ),
                  colorButton("LOGIN"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
