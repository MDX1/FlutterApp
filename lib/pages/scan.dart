import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Qscanner extends StatefulWidget {
  Qscanner({Key? key}) : super(key: key);

  @override
  State<Qscanner> createState() => _QscannerState();
}

class _QscannerState extends State<Qscanner> {
  String? scanResult;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.deepPurple[300],
        title: Text('QR scanner', style: TextStyle(fontSize: 30)),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                onPrimary: Colors.black,
              ),
              icon: Icon(Icons.camera_alt_outlined, size: 40),
              label: Text('SCANEAZA', style: TextStyle(fontSize: 25)),
              onPressed: scanBarcode,
            ),
            SizedBox(height: 10),
            Text(
              scanResult == null ? 'Scan a code' : 'Scan results : $scanResult',
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      )),
    );
  }

  Future scanBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      scanResult = 'Failed to scan';
    }
    if (!mounted) return;

    setState(() => this.scanResult = scanResult);
  }
}
