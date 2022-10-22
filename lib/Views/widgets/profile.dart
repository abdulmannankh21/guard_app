import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guard_app/Features/Storage/data_provider.dart';
import 'package:guard_app/Models/user_model.dart';
import 'package:guard_app/Views/screens/details_profile.dart';
import 'package:guard_app/Views/screens/helpscreen.dart';
import 'package:guard_app/Views/screens/notificationscreen.dart';
import 'package:guard_app/Views/screens/settingScreen.dart';
import 'package:guard_app/Views/screens/signIn.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool loading = true;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var value = await ref.read(dataProvier).getCurrentUserData();

    setState(() {
      if(user?.firstName==null)
       loading = false;
      user = value;
     
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03),
        child: SingleChildScrollView(
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //rgba(255,255,254,255)
                      color: Color.fromRGBO(255, 255, 254, 1),

                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Accounts",
                                style: TextStyle(
                                    fontSize: size.width * 0.07,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.notifications_none_outlined,
                                size: size.width * 0.08,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20, top: size.height * 0.03),
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.22,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${user?.profilePicUrl}"),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.black26),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${user?.firstName}  ${user?.lastName}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Divider(
                            color: Colors.black12,
                          ),
                          //Add tile about
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => DetailsScreen()))),
                            child: ListTile(
                              leading: Icon(
                                Icons.info,
                                color: Colors.grey,
                              ),
                              title: Text("About"),
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black12,
                          ),
                          //Add tile support
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder:  ((context) => NotificationScreen())));
                            },
                            child: ListTile(
                              leading: Icon(
                                Icons.notifications,
                                color: Colors.grey,
                              ),
                              title: Text("Notifications"),
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                             
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder:  ((context) => HelpScreen())));


                            },
                            child: ListTile(
                              leading: Icon(
                                Icons.support,
                                color: Colors.grey,
                              ),
                              title: Text("Support"),
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          //Add tile notification
                          Divider(
                            color: Colors.black12,
                          ),
                          //add tile seeting
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SettingScreen()))),
                            child: ListTile(
                              leading: Icon(
                                Icons.settings,
                                color: Colors.grey,
                              ),
                              title: Text("Settings"),
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black12,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.4, top: 10.0),
                            child: TextButton(
                                child: Text("Logout"),
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => SignInScreen())),
                                      (route) => false);
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
