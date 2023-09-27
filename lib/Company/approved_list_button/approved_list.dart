import 'package:cse499_project/Company/approved_list_button/approved/approvedORdecline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Approved_list_button extends StatelessWidget {
  const Approved_list_button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "select you want in company",
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Company_ApprovedorDecline()));
                //print('Verification button pressed');
              },
              child: Text('Approved'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle add crops button press
              },
              child: Text('List'),
            ),
          ],
        ),
      ),
    );
  }
}
