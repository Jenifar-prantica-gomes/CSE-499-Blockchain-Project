import 'package:flutter/material.dart';

class Profile_Company_user extends StatefulWidget {
  const Profile_Company_user({Key? key}) : super(key: key);

  @override
  State<Profile_Company_user> createState() => _Profile_Company_userState();
}

class _Profile_Company_userState extends State<Profile_Company_user> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcom Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              //Text("${loggedInUser.username}")
            ],
          ),
        ),
      ),
    );
  }
}
