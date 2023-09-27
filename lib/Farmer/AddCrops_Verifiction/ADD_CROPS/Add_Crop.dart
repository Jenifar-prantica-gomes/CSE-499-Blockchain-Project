import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cse499_project/EthereumService.dart'; // Import your EthereumService.dart
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class Farmer_AddCrops extends StatelessWidget {
  Farmer_AddCrops({Key? key}) : super(key: key);
  TextEditingController _itemHarvestingTime = TextEditingController();
  TextEditingController _itemFertilizer = TextEditingController();
  TextEditingController _itemId = TextEditingController();
  TextEditingController _itemDeliveryDate = TextEditingController();
  TextEditingController _itemName = TextEditingController();
  TextEditingController _itemWeight = TextEditingController();
  TextEditingController _itemPlace = TextEditingController();

  // EthereumService instance to interact with the Ethereum smart contract
  final EthereumService ethereumService = EthereumService();
  // final counter1 = ref.watch(EthereumService.provider).count ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Farmer",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            TextFormField(
              controller: _itemId,
              decoration: InputDecoration(
                labelText: 'Item ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _itemName,
              decoration: InputDecoration(
                labelText: 'Item name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _itemWeight,
              decoration: InputDecoration(
                labelText: 'Kg',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.0),
            TextFormField(
              controller: _itemDeliveryDate,
              decoration: InputDecoration(
                labelText: 'Date: DD/MM/YYYY',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.0),
            TextFormField(
              controller: _itemPlace,
              decoration: InputDecoration(
                labelText: 'Place',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.0),
            TextFormField(
              controller: _itemFertilizer,
              decoration: InputDecoration(
                labelText: 'Fertilizer',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.0),
            TextFormField(
              controller: _itemHarvestingTime,
              decoration: InputDecoration(
                labelText: 'Harvesting time',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                // Get the values from text fields
                String foodId = _itemId.text;
                String foodName = _itemName.text;
                String cultivationDate = _itemHarvestingTime.text;
                String location = _itemPlace.text;
                String fertilizerType = _itemFertilizer.text;

                try {
                  // Call the Ethereum smart contract function
                  await ethereumService.sendTransaction(
                    foodId,
                    foodName,
                    cultivationDate,
                    location,
                    fertilizerType,
                  );

                  // Save data to Firestore
                  Map<String, dynamic> data = {
                    "Food ID": foodId,
                    "Food name": foodName,
                    "Food harvesting time": cultivationDate,
                    "Food Delivery": _itemDeliveryDate.text,
                    "Place": location,
                    "Fertilizer": fertilizerType,
                  };

                  await FirebaseFirestore.instance
                      .collection("farmer add food")
                      .add(data);

                  // Show a success dialog or navigate to the next screen
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Success"),
                        content: Text("Transaction submitted successfully."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );

                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => Company_ApprovedorDecline()));
                } catch (e) {
                  // Handle any errors that occur during Ethereum interaction
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("An error occurred: $e"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
