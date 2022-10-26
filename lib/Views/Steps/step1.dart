import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:guard_app/Features/Storage/storage_provider.dart';
import 'package:guard_app/services/local_notification_service.dart';
import 'package:guard_app/services/location_services.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step1 extends ConsumerStatefulWidget {
  @override
  ConsumerState<Step1> createState() => _Step1State();
}

class _Step1State extends ConsumerState<Step1> {
  String address = "";
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  String cityName = "";
  bool disabled = true;
  String dob = "";
  final TextEditingController dobController = new TextEditingController();
  String email = "";
  final TextEditingController emailController = new TextEditingController();
  String firstName = "";
  final TextEditingController firstNameController = new TextEditingController();
  var icon = [
    Icon(Icons.person),
    Icon(Icons.description),
    Icon(Icons.person),
    Icon(Icons.payment),
  ];

  String lastName = "";
  final TextEditingController lastNameController = new TextEditingController();
  double latitude = 0.0;
  double longitude = 0.0;
  String? messageToken = '';
  LocationServices newLocation = LocationServices();
  String password = "";
  final TextEditingController passwordController = new TextEditingController();

  int _chevronCounter = 0;
  int _customCounter = 0;
  String _passwordVisible = "";
  var _selectedService;
  var _serviceTypes = [
    'Events Manag. ,Stewards,Door supervisor',
    'Key Holding ,& Alarm Response',
    'Dog handling',
    'CCTV monitoring',
    'VIP close protection',
    'Traffic Marshal ,operative/Vehicle immobi.',
    'other type ,of services'
  ];

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

  @override
  void initState() {
    super.initState();
    LocationServices.requestLocationPermission();
    LocalNotificationService.requestPermission();
    getToken();
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        messageToken = token;
      });
    });
  }

  Future<void> setLocation() async {
    var latLong = await LocationServices.getLatLong();

    setState(() {
      latitude = latLong[0];
      longitude = latLong[1];
    });
  }

  clearText() {
    firstNameController.clear();
    lastNameController.clear();
    dobController.clear();
    addressController.clear();
    emailController.clear();
    passwordController.clear();
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
              "Provide your basic information",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10.0,
            ),
            customFields(
              firstNameController,
              "First name *",
              "Enter your first name",
              null,
            ),
          
            SizedBox(
              height: 10.0,
            ),
            customFields(lastNameController, "Last name * ",
                "Enter your Last name", null),
            SizedBox(
              height: 10.0,
            ),
              customFields(
              cityController,
              "City name*",
              "Enter your city name in lower case ",
              null,
            ),
            customFields(
              dobController,
              "Date Of birth *",
              "e.g 18/23/2022",
              Icon(Icons.calendar_today),
            ),
            SizedBox(
              height: 10.0,
            ),
            customFields(addressController, "Address *", "Enter your Address",
                Icon(Icons.location_on_rounded)),
                SizedBox(height: 4,),
            Padding(
                padding: const EdgeInsets.only(right: 2,top: 3,bottom: 4),
                child: Container(
                  //  width: MediaQuery.of(context).size.width * 0.20,
                  child: DropdownButton(
                    hint: Text('Select service  type'),
                    // Not necessary for Option 1
                    value: _selectedService,
                    onChanged: (newValue) {
                      setLocation();
                      setState(() {
                        _selectedService = newValue;
                      });
                    },
                    items: _serviceTypes.map((service) {
                      return DropdownMenuItem(
                        child: new Text(service),
                        value: service,
                      );
                    }).toList(),
                  ),
                )),
            Divider(
              color: Colors.black45,
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
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          onChanged: (value) {
            if (lastNameController.text != "" &&
                firstNameController.text != "" &&
                dobController.text != "" &&
                addressController.text != "") {
              setState(() {
                disabled = false;
              });
            }
          },
          textInputAction: TextInputAction.next,
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
                      if (lastNameController.text != "" &&
                          firstNameController.text != "" &&
                          dobController.text != "" &&
                          addressController.text != "" &&
                          _selectedService != "") {
                        setState(() {
                          disabled = false;
                        });
                      }

                      print('diasbaled : $disabled');
                      if (!disabled) {
                        setState(() {
                          firstName = firstNameController.text;
                          lastName = lastNameController.text;
                          dob = dobController.text;
                          email = emailController.text;
                          address = addressController.text;
                          password = passwordController.text;

                          clearText();

                          ref.read(storageProvider).saveUser(
                              latitude: latitude,
                              longitude: longitude,
                              selectedService: _selectedService.toString(),
                              city: cityController.text.toLowerCase(),
                              token: messageToken ?? '',
                              context: context,
                              firstName: firstName,
                              secondName: lastName,
                              dateOfBirth: dob,
                              email: FirebaseAuth.instance.currentUser!.email!,
                              password: password,
                              address: address);
                        });
                      } else {
                        EasyLoading.showInfo("Fill all the fields * ");
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                          color: disabled
                              ? Color.fromARGB(255, 54, 54, 54)
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
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
}
