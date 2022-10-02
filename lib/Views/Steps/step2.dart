
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:guard_app/Views/Steps/step3.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'dart:io' as io;
class Step2 extends StatefulWidget {



  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  int _chevronCounter = 0;
  int _customCounter = 0;
  io.File? pickedImage;
  String pickedImagePath = '';
  var icon=[
    Icon(Icons.person),
    Icon(Icons.description),
    Icon(Icons.person),
    Icon(Icons.payment),
  ];
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
      padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02,top: 0.0 ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Icon(Icons.arrow_back_ios,size: MediaQuery.of(context).size.width*0.07,),
                SizedBox(width: 20.0,),
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
                if (index == 2) {
                  return ProgressStepWithArrow(
                    width: widthOfStep,
                    defaultColor: Color.fromRGBO(247, 247, 247, 1),
                    progressColor: Colors.amber,
                    wasCompleted: true,
                    child: icon[index-1],


                  );
                }
                return ProgressStepWithChevron(
                  width: widthOfStep,
                  defaultColor: Color.fromRGBO(247, 247, 247, 1),
                  progressColor: Colors.amber,
                  wasCompleted: false,
                  child: icon[index-1],


                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035,),
            getFieldsOne(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

            InkWell(
              onTap: () {
                //_incrementChevronStepper();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Step3()));
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
    ), // This trailing comma makes auto-formatting nicer for build methods.
  );
  Widget getFieldsOne(){
    return Padding(
      padding: const EdgeInsets.only(left:8.0,right: 8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload Documents",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),

            SizedBox(height: 10.0,),
            customFields("ID Front*", "Add ID Front",null),
            SizedBox(height: 10.0,),

            customFields("ID Back*", "Add ID Back",null),
            SizedBox(height: 10.0,),

            customFields("License Front*", "Add License Front",null),
            SizedBox(height: 10.0,),

            customFields("License Back*", "Add License Back",null),
            SizedBox(height: 10.0,),

            // customFields("Password", "Enter your password",Icon(Icons.visibility)),
            // SizedBox(height: 10.0,),
            // customFields("Password", "Enter your Address",Icon(Icons.location_on_rounded)),

          ],
        ),
      ),
    );
  }
  Widget customFields(name,hint,icon){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$name",
          style: TextStyle(
              fontSize: 14, color: Colors.black),
        ),
        SizedBox(height: 10.0,),
        DottedBorder(
          dashPattern: [4,4],
          child: GestureDetector(
            onTap: (){
              takePicture(ImageSource.camera);
            },
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                suffixIcon: icon,
                border: InputBorder.none,
                hintText: "$hint",
                fillColor: Color.fromRGBO(247, 247, 247, 1),

                filled: true,
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
  Widget customPic(){
    return Row(
      children: [
        Container(
          height: 70.0,
          width: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage("images/painting.png")
            )
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20.0,right: 10.0),
          height: MediaQuery.of(context).size.height*0.07,
          width: MediaQuery.of(context).size.width*0.7,

          decoration: BoxDecoration(
            color: Color.fromRGBO(247, 247, 247, 1),
              borderRadius: BorderRadius.circular(7.0),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("pic.png"),
              Text("Edit",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),),

            ],
          ),
        ),

      ],
    );
  }

  Future<void>? takePicture(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 70, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);
    if (image != null) {
      pickedImage = io.File(image.path);
      pickedImagePath = pickedImage!.path;
      print('image selected. $pickedImage');
    } else {
      print('No image selected.');
    }
  }
}