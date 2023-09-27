import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey _qrKey = GlobalKey();
  QRViewController? _controller;
  Barcode? result;
  void qr(QRViewController controller) {
    this._controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              child: QRView(key: _qrKey, onQRViewCreated: qr),
            ),
            Center(
              child: (result != null)
                  ? Text(
                      "${result!.code}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                        color: Color(0xffFFA600),
                      ),
                    )
                  : Text("Scan a code"),
            ),
          ],
        ),
      ),
    );
  }
}
