import 'package:cse499_project/Farmer/OTP/farmar_login.dart';
import 'package:cse499_project/Farmer/OTP/farmar_singUp.dart';
import 'package:flutter/material.dart';

class Farmer_LOG_OR_SING extends StatelessWidget {
  const Farmer_LOG_OR_SING({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String phoneNumber = ""; // Initialize the phoneNumber variable

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "..Farmer login OR singUp..",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16.0), // add some space between the buttons

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Farmar_login();
                    },
                  ),
                );
              },
              child: Text('login'),
            ),
            SizedBox(height: 16.0), // add some space between the buttons

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Farmar_sing_up();
                    },
                  ),
                );
              },
              child: Text('sing up'),
            ),
          ],
        ),
      ),
    );
  }
}
