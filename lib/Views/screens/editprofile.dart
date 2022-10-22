import 'package:flutter/material.dart';
import 'package:guard_app/Features/Storage/data_provider.dart';
import 'package:guard_app/Features/Storage/storage_provider.dart';

import 'package:guard_app/Models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController dateofBirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  bool hidePassword = true;
  TextEditingController lastNameController = TextEditingController();
  bool loading = true;
  var networkImage;
  TextEditingController passwordController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  UserModel? user;
  TextEditingController workController = TextEditingController();

  XFile? _im;

  @override
  void initState() {
    super.initState();

    setUserData();
  }

  void setUserData() async {
    var newUser = await ref.read(dataProvier).getCurrentUserData();

    setState(() {
      user = newUser;
      loading = false;

      firstNameController.text = "${user?.firstName}";
      lastNameController.text = "${user?.lastName}";
      dateofBirthController.text = "";

      addressController.text = '';
      summaryController.text = '${user?.summary}';
      workController.text = '${user?.workExperience}';
      networkImage = '${user?.profilePicUrl}';
    });
  }

  selectImageFromGallery() async {
    XFile? image = await pickImage(ImageSource.gallery);
    if (image != null) {
      var imageUrl = await ref
          .read(storageProvider)
          .uploadImageToStorage('Add your Profile Pic', File(image.path));
      setState(() {
        networkImage = imageUrl;
      });
    }
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source,imageQuality: 50);
    if (_file != null) {
      return await _file;
    }
    print('No Image Selected');
  }

  Widget customFields(controller, name, hint) {
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
            controller: controller,
            maxLines: 6,
            decoration: InputDecoration(
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

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            _im != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(networkImage),
                                    backgroundColor: Colors.amber,
                                  )
                                : CircleAvatar(
                                    radius: 64,
                                    //already used profile pic shows here
                                    backgroundImage: NetworkImage(networkImage),
                                    backgroundColor: Colors.amber,
                                  ),
                            Positioned(
                                bottom: 0,
                                left: 84,
                                child: InkWell(
                                  onTap: () {
                                    selectImageFromGallery();
                                  },
                                  child: ClipOval(
                                    child: Container(
                                      padding: EdgeInsets.all(3),
                                      color: Colors.white,
                                      child: ClipOval(
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          color: Colors.amber,
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: 'First Name *',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: TextField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: 'Last Name *',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: TextField(
                          controller: dateofBirthController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: 'Date of Birth *',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: TextField(
                          controller: addressController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: 'Address *',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              customFields(summaryController,
                                  "Personal Summary*", "Add about yourSelf"),
                              SizedBox(
                                height: 10.0,
                              ),
                              customFields(workController, "Previous Work*",
                                  "Add about your work Experince "),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'cancel',
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black),
                            ),
                            style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ref.read(storageProvider).updateUserData(
                                  firstName: firstNameController.text,
                                  secondName: lastNameController.text,
                                  dateOfBirth: dateofBirthController.text,
                                  address: addressController.text,
                                  work: workController.text,
                                  adress: addressController.text,
                                  profileImageUrl: networkImage,
                                  summary: summaryController.text);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.amber,
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ));
  }
}
