import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse499_project/Company/QR_Code_generate/QR_CODE_GENERATE.dart';
import 'package:cse499_project/Company/approved_list_button/approved_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Company_ApprovedorDecline extends StatelessWidget {
  Company_ApprovedorDecline({Key? key}) : super(key: key);

  Future<void> _approveData(String foodId, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('farmer add food')
        .doc(foodId)
        .update({'approved': true});

    Fluttertoast.showToast(msg: 'Approved');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Qr_generate(foodId: foodId)),
    );
  }

  Future<void> _rejectData(String foodId) async {
    await FirebaseFirestore.instance
        .collection('farmer add food')
        .doc(foodId)
        .update({'approved': false});

    Fluttertoast.showToast(msg: 'Rejected');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('industry'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('farmer add food')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final farmerData =
                            snapshot.data!.docs.reversed.toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: farmerData.length,
                          itemBuilder: (context, index) {
                            final _dataFarmer = farmerData[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(_dataFarmer['Food ID']),
                                        Text(_dataFarmer['Food name']),
                                        Text(_dataFarmer['Place']),
                                        Text(_dataFarmer['Fertilizer']),
                                        Text(_dataFarmer[
                                            'Food harvesting time']),
                                        Text(_dataFarmer['Food Delivery']),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      _approveData(_dataFarmer.id, context);
                                    },
                                    child: Text("Approve"),
                                  ),
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      _rejectData(_dataFarmer.id);
                                    },
                                    child: Text("Reject"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
