
import 'package:flutter/material.dart';
import 'package:guard_app/Views/screens/mainScreen.dart';
import 'package:progress_stepper/progress_stepper.dart';

class Step4 extends StatefulWidget {
  @override
  _Step4State createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  var icon = [
    Icon(Icons.person),
    Icon(Icons.description),
    Icon(Icons.person),
    Icon(Icons.payment),
  ];

  int _chevronCounter = 0;
  int _customCounter = 0;

  Widget getFieldsOne() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Provide your payment information",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            customPic(Icons.account_balance, "Add your bank"),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.39),
              child: Text(
                "OR",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),

            customPic(Icons.payment, "Add Credit/Debit Card"),

          ],
        ),
      ),
    );
  }

  Widget customPic(icon, name) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02),
      padding: EdgeInsets.only(left: 20.0, right: 10.0),
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Center(
        child: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.18),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "$name",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _incrementChevronStepper() {
    setState(() {
      if (_chevronCounter != 5) {
        _chevronCounter++;
      }
    });
  }

  void _decrementChevronStepper() {
    setState(() {
      if (_chevronCounter != 0) {
        _chevronCounter--;
      }
    });
  }

  void _incrementCustomStepper() {
    setState(() {
      if (_customCounter != 3) {
        _customCounter++;
      }
    });
  }

  void _decrementCustomStepper() {
    setState(() {
      if (_customCounter != 0) {
        _customCounter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 254, 1),
        body: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.02,
              top: 0.0),
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
                    if (index == 4) {
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
                    // _incrementChevronStepper();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02,
                        right: MediaQuery.of(context).size.width * 0.02),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(color: Colors.black),
                    child: const Center(
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
              
              ],
            ),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
}
