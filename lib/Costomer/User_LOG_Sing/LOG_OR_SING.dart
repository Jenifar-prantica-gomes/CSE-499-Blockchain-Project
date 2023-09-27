import 'package:cse499_project/Costomer/user_login_singup/User_Sing_up/Customer_Sing.dart';
import 'package:cse499_project/Costomer/user_login_singup/user_login/Customer_login.dart';
import 'package:flutter/material.dart';

class User_LOG_OR_SING extends StatelessWidget {
  const User_LOG_OR_SING({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Customer_Login();
                    },
                  ),
                );
              },
              child: Text('Log In'),
            ),
            SizedBox(height: 16.0), // add some space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Customer_SingUpPage();
                    },
                  ),
                );
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
