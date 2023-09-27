import 'package:cse499_project/Farmer/AddCrops_Verifiction/ADD_CROPS/Add_Crop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Farmer_AddCrops_Button extends StatelessWidget {
  const Farmer_AddCrops_Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     // Handle verification button press
            //     print('Verification button pressed');
            //   },
            //   child: Text('Verification'),
            // ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Farmer_AddCrops()));
                print('Add Crops button pressed');
              },
              child: Text('Add Crops'),
            ),
          ],
        ),
      ),
    );
  }
}
