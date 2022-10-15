import 'package:flutter/material.dart';
import 'package:guard_app/Views/screens/signIn.dart';

class SimpleDialogBox extends StatelessWidget {
  SimpleDialogBox(BuildContext context);

  _displayDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // ignore: prefer_const_constructors
        return Expanded(
          child: SimpleDialog(
            title: Text('Email sent'),
            children: [
              Text("Email has been sent .Check your Email to reset pasword"),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SignInScreen())));
                      },
                      child: Text("ok"))
                ],
              )
            ],
            elevation: 10,
            //backgroundColor: Colors.green,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _displayDialog(context);
  }
}
