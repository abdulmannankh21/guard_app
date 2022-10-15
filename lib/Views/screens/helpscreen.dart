import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: Text(
          'Support',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: IconButton(
          icon: Image.network(
              'https://cdn1.iconfinder.com/data/icons/user-worker-employee-business-avatars/100/26-1User_34-512.png'),
          iconSize: 100,
          onPressed: () {},
        ),
      ),
    );
  }
}
