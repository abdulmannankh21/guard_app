import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guard_app/Features/Storage/storage_provider.dart';
import 'package:guard_app/Views/Steps/step4.dart';
import 'package:progress_stepper/progress_stepper.dart';

class Step3 extends ConsumerStatefulWidget {
  @override
  ConsumerState<Step3> createState() => _Step3State();
}

class _Step3State extends ConsumerState<Step3> {
  bool disabled = true;
  var icon = [
    Icon(Icons.person),
    Icon(Icons.description),
    Icon(Icons.person),
    Icon(Icons.payment),
  ];

  var summary;
  final TextEditingController summaryController = new TextEditingController();
  var work;
  final TextEditingController workController = new TextEditingController();

  int _chevronCounter = 0;
  int _customCounter = 0;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    summaryController.dispose();
    workController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  clearText() {
    summaryController.clear();
    workController.clear();
  }

  Widget getFieldsOne() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Something About You",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10.0,
            ),
            customFields(summaryController, "Personal Summary*",
                "Add about yourSelf", null),
            SizedBox(
              height: 10.0,
            ),
            customFields(workController, "Previous Work*",
                "Add about your work Experince ", null),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget customFields(controller, name, hint, icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$name",
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 6 * 24.0,
          child: TextFormField(
            onChanged: ((value) {
              if (summaryController.text != "" && workController.text != "") {
                setState(() {
                  disabled = false;
                });
              }
            }),
            controller: controller,
            maxLines: 6,
            decoration: InputDecoration(
              suffixIcon: icon,
              border: InputBorder.none,
              hintText: "$hint",
              fillColor: Color.fromRGBO(247, 247, 247, 1),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        )
      ],
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
                    if (index == 3) {
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
                    if (!disabled) {
                      setState(() {
                        summary = summaryController.text;
                        work = workController.text;
                      });

                      ref.read(storageProvider).addDetail(
                          summary: summary,
                          workExperience: work,
                          context: context);

                      EasyLoading.showSuccess("Details added");

                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: ((context) => Step4())));
                    } else {
                      EasyLoading.showError("Please fill all the fields");
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                        color: disabled
                            ? Color.fromARGB(255, 64, 64, 64)
                            : Colors.black),
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
              ],
            ),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
}
