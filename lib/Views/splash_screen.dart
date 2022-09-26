import 'package:flutter/material.dart';
import 'package:guard_app/Views/phone_verify.dart';

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

        color: bgColor,                margin: EdgeInsets.only(top: size.height*0.07),

        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(right: size.width*0.1),
                child: Image.asset("images/logo.png",height: size.height*0.5,width: size.width*0.5,),
              ),
              SizedBox(height: size.height*0.1,),
              Text("Welcome To Guards App",style: TextStyle(fontSize: 22.0,color: Colors.black),),

              Container(
                margin: EdgeInsets.only(top: size.height*0.02),
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.08,

                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PhoneVerify()));
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
      ),
    );
  }
}
