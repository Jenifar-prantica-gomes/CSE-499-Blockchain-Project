import 'package:cse499_project/Company/Company_Sing_up/comapany_sign_up.dart';
import 'package:cse499_project/Company/Company_login/company_login.dart';
import 'package:flutter/material.dart';

class Company_LOG_OR_SING extends StatelessWidget {
  const Company_LOG_OR_SING({Key? key}) : super(key: key);

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
                      return Company_log_in_page(); //Company_LoginPage();
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
                      return Company_sign_up_page();
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
