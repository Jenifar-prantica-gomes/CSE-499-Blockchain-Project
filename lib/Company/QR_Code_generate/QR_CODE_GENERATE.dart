import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Qr_generate extends StatefulWidget {
  final String foodId;

  Qr_generate({Key? key, required this.foodId}) : super(key: key);

  @override
  _Qr_generateState createState() => _Qr_generateState();
}

class _Qr_generateState extends State<Qr_generate> {
  late TextEditingController _controller;
  late String qrData;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.foodId);
    qrData = generateQrData();
  }

  Future<void> fetchFoodData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('farmer add food')
        .doc(_controller.text)
        .get();

    if (snapshot.exists) {
      String foodID = snapshot['Food ID'];
      String foodName = snapshot['Food name'];
      String fertilizer = snapshot['Fertilizer'];
      String harvestingTime = snapshot['Food harvesting time'];
      String place = snapshot['Place'];

      setState(() {
        qrData =
            "$qrData\nFood ID:$foodID\nFood name:$foodName\nFertilizer$fertilizer\nHarvest time:$harvestingTime\nPlace:$place";
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String generateQrData() {
    return "Qr ID: ${widget.foodId}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          QrImage(
            data: qrData,
            size: 200,
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Food ID",
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: fetchFoodData,
                  child: Text("Fetch Food Data"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
