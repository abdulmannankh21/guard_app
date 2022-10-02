import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guard_app/Views/Steps/step2.dart';
import 'package:progress_stepper/progress_stepper.dart';

class Step1 extends StatefulWidget {
  @override
  _Step1State createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  var firstName;
  var lastName;
  var dob;
  var email;
  var address;
  var password;
  bool _passwordVisible = false ;

  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController dobController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  clearText() {
    firstNameController.clear();
    lastNameController.clear();
    dobController.clear();
    addressController.clear();
    emailController.clear();
    passwordController.clear();
  }

// Adding Guard
  CollectionReference guard = FirebaseFirestore.instance.collection('guard');
  Future<void> guardDetails() {
    return guard
        .add({
          'id': guard.doc().id,
          'first name': firstName,
          'last name': lastName,
          'date of birth': dob,
          'email': email,
          'address': address,
          'postedBy': FirebaseAuth.instance.currentUser!.uid
        })
        .then((value) =>
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Step2()),
        ))
        .catchError((error) => Fluttertoast.showToast(
        msg: "Failed to Add",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0));
  }


  int _chevronCounter = 0;
  int _customCounter = 0;
  var icon = [
    Icon(Icons.person),
    Icon(Icons.description),
    Icon(Icons.person),
    Icon(Icons.payment),
  ];

  // void _incrementChevronStepper() {
  //   setState(() {
  //     if (_chevronCounter != 5) {
  //       _chevronCounter++;
  //     }
  //   });
  // }
  // void _decrementChevronStepper() {
  //   setState(() {
  //     if (_chevronCounter != 0) {
  //       _chevronCounter--;
  //     }
  //   });
  // }
  // void _incrementCustomStepper() {
  //   setState(() {
  //     if (_customCounter != 3) {
  //       _customCounter++;
  //     }
  //   });
  // }
  // void _decrementCustomStepper() {
  //   setState(() {
  //     if (_customCounter != 0) {
  //       _customCounter--;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 254, 1),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02,
                top: 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: MediaQuery.of(context).size.width * 0.07,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Image.asset('images/header.png'),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  ProgressStepper(
                    width: MediaQuery.of(context).size.width,
                    height: 25,
                    color: Colors.red,
                    progressColor: Colors.amber,
                    stepCount: 4,
                    builder: (index) {
                      double widthOfStep = 300 / 4;
                      if (index == 1) {
                        return ProgressStepWithArrow(
                          width: widthOfStep,
                          defaultColor: Color.fromRGBO(247, 247, 247, 1),
                          progressColor: Colors.amber,
                          wasCompleted: true,
                          child: icon[index - 1],
                        );
                      }
                      return ProgressStepWithChevron(
                        width: widthOfStep,
                        defaultColor: Color.fromRGBO(247, 247, 247, 1),
                        progressColor: Colors.amber,
                        wasCompleted: false,
                        child: icon[index - 1],
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.035,
                  ),
                  getFieldsOne(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  InkWell(
                    onTap: () {
                      //_incrementChevronStepper();
                      setState(() {
                        firstName = firstNameController.text;
                        lastName = lastNameController.text;
                        dob = dobController.text;
                        email = emailController.text;
                        address = addressController.text;
                        password = passwordController.text;
                        guardDetails();
                        clearText();

                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(color: Colors.black),
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     OutlinedButton(
                  //       onPressed: _decrementCustomStepper,
                  //       child: const Text(
                  //         '-1',
                  //         style: TextStyle(
                  //           color: Colors.red,
                  //         ),
                  //       ),
                  //     ),
                  //     OutlinedButton(
                  //       onPressed: _incrementCustomStepper,
                  //       child: const Text(
                  //         '+1',
                  //         style: TextStyle(
                  //           color: Colors.green,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
  Widget getFieldsOne() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Provide your basic information",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10.0,
            ),
            customFields(firstNameController,"First name", "Enter your first name", null,
                ),
            SizedBox(
              height: 10.0,
            ),
            customFields(lastNameController,
                "Last name", "Enter your Last name", null),
            SizedBox(
              height: 10.0,
            ),
            customFields(dobController,"Date Of birth", "e.g 18/23/2022",
                Icon(Icons.calendar_today), ),
            SizedBox(
              height: 10.0,
            ),
            customFields(emailController,"Email", "email@gmail.com", null),
            SizedBox(
              height: 10.0,
            ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pasword",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(
              height: 10.0,
            ),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: passwordController,
          obscureText: !_passwordVisible,
          //This will obscure text dynamically

          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color.fromRGBO(247, 247, 247, 1),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(5.0),),
            // Here is key idea
            hintText: 'Enter your password',
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.black,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
        ),
        ),
          ],
        ),
            SizedBox(
              height: 10.0,
            ),
            customFields(addressController,"Address", "Enter your Address",
                Icon(Icons.location_on_rounded)),
          ],
        ),
      ),
    );
  }
  Widget customFields(controller,name, hint, icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$name",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: icon,
            suffixIconColor: Colors.black,
            border: InputBorder.none,
            hintText: "$hint",
            fillColor: Color.fromRGBO(247, 247, 247, 1),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        )
      ],
    );
  }
}
