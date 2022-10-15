import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:guard_app/Features/authentiction/auth_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _ScreenOneState();
}

class _ScreenOneState extends ConsumerState<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  bool tick = false;
  String userEmail = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationID = "";
  String countryCode = "";
  Widget _buildDropdownItem(Country country, double dropdownItemWidth) =>
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.23,
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            Expanded(
              child: Text(
                "  +${country.phoneCode} " "(${country.iso3Code})",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0),
              ),
            ),
          ],
        ),
      );

  _buildCountryPickerDropdown(
      {bool filtered = false,
      bool sortedByIsoCode = false,
      bool hasPriorityList = false,
      bool hasSelectedItemBuilder = false}) {
    double dropdownButtonWidth = MediaQuery.of(context).size.width * 0.5;
    //respect dropdown button icon size
    double dropdownItemWidth = dropdownButtonWidth - 40;
    double dropdownSelectedItemWidth = dropdownButtonWidth - 30;
    return Row(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.32,
          child: Container(
            padding: EdgeInsets.only(left: 6.0),
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.07,
            child: CountryPickerDropdown(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              itemHeight: null,
              isDense: false,
              itemBuilder: (Country country) =>
                  _buildDropdownItem(country, dropdownItemWidth),
              initialValue: 'AR',
              priorityList: hasPriorityList
                  ? [
                      CountryPickerUtils.getCountryByIsoCode('GB'),
                      CountryPickerUtils.getCountryByIsoCode('CN'),
                    ]
                  : null,
              sortComparator: sortedByIsoCode
                  ? (Country a, Country b) => a.isoCode.compareTo(b.isoCode)
                  : null,
              onValuePicked: (Country country) {
                countryCode = country.phoneCode;
              },
            ),
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              controller: phoneController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusColor: Colors.black,
                border: InputBorder.none,
                labelText: "Enter Your Phone Number",
                labelStyle: TextStyle(color: Colors.black),
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.035,
            right: MediaQuery.of(context).size.width * 0.035,
            top: MediaQuery.of(context).size.height * 0.1),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Enter your mobile number",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _buildCountryPickerDropdown(filtered: false),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "We'll send you login code",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                tick
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            tick = false;
                          });
                        },
                        child: Icon(
                          Icons.check_box,
                          size: 30,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            tick = true;
                          });
                        },
                        child: Icon(
                          Icons.check_box_outline_blank,
                          size: 30,
                        ),
                      ),
                Text(
                  "I agree to Grab a Guard's",
                  style: TextStyle(fontSize: 11, color: Colors.black45),
                ),
                Text(
                  "Terms and Conditions & Privacy Policy",
                  style: TextStyle(fontSize: 11, color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (tick == true) {
                    ref.read(authControllerProvider).signInWithPhone(
                        context,'+'+ countryCode + phoneController.text);
                  }
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Or continue with",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
            SizedBox(
              height: 10,
            ),

            //Facebook Button
            // GestureDetector(
            //   onTap: () {
            //     signInWithFacebook();
            //    setState((){
            //
            //    });
            //   },
            //   child: Container(
            //     width: MediaQuery.of(context).size.width * 0.9,
            //     height: MediaQuery.of(context).size.height * 0.07,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       border: Border.all(color: Colors.black12),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.only(right: 10),
            //           child: Container(
            //             width: 30,
            //             height: 30,
            //             child: ClipRRect(
            //               child: Image.asset(
            //                 "images/facebook.png",
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //           ),
            //         ),
            //         Text(
            //           "Facebook",
            //           style: TextStyle(color: Colors.black, fontSize: 18),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),

            //Gmail Button

            GestureDetector(
              onTap: () {
                setState(() async {
                  ref.read(authControllerProvider).signInWithGoogle(context);
                 
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: 30,
                        height: 30,
                        color: Colors.black,
                        child: ClipRRect(
                          child: Image.asset(
                            "images/google.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Google",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

// Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login(
//       permissions: ['email', 'public_profile', 'user_birthday']
//   );
//
//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
//
//   final userData = await FacebookAuth.instance.getUserData();
//
//   userEmail = userData['email'];
//
//   // Once signed in, return the UserCredential
//   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }

}
