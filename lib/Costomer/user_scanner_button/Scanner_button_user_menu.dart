import 'package:cse499_project/Costomer/Scanner/Scanner.dart';
import 'package:flutter/material.dart';

class Customer_Scanner_button extends StatelessWidget {
  Customer_Scanner_button({Key? key}) : super(key: key);

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
                      return ScannerPage();
                    },
                  ),
                );

                print('Verification button pressed');
              },
              child: Text('Scanner'),
            ),
          ],
        ),
      ),
    );
  }
}
