import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard_app/Views/loginScreen.dart';
import 'package:guard_app/Views/mainScreen.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        color: bgColor,
        margin: EdgeInsets.only(top: size.height * 0.07),
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.1),
              child: Image.asset(
                "images/logo.png",
                height: size.height * 0.5,
                width: size.width * 0.5,
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Text(
              "Welcome To Guards App",
              style: TextStyle(fontSize: 22.0, color: Colors.black),
            ),
            Container(
                margin: EdgeInsets.only(top: size.height * 0.02),
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      Future.delayed(
                          const Duration(
                            seconds: 2,
                          ),
                              () {});
                      if (false) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const MainScreen()));
                      } else {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) =>  LoginScreen()));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.07,
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            "Get Started ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
