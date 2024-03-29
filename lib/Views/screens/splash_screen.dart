import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:guard_app/Views/screens/mainScreen.dart';

import 'package:guard_app/Views/screens/signIn.dart';

import '../../constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
       
     FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          
        }
      },
    );

     FirebaseMessaging.onMessage.listen(
      (message) {
        
        if (message.notification != null) {
          

        }
      },
    );
    

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        
        if (message.notification != null) {
          
        }
      },
    );
  
  }

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

                      if (FirebaseAuth.instance.currentUser != null) {
                    
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()));
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
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
