import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shealth/providers/auth.dart';
import 'package:shealth/providers/doctors.dart';
import 'package:shealth/routers/RouteNames.dart';

import 'custombutton.dart';

class QrCodeScreen extends StatefulWidget {
  static const routeName = "/qr-code";

  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Barcode result;
  late QRViewController controller;
  late String doctorid;

  bool resultInitialized = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        doctorid = result.code;
        resultInitialized = true;
      });
      readQR();
      Navigator.pushNamed(context, RouteNames.ladning);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //for opening the qr code link in the browser
  void readQR() {
    print(doctorid);
    Doctors()
        .addDoctor(Provider.of<Auth>(context, listen: false).token, doctorid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Container(
                width: 200,
                height: 200,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (resultInitialized)
                    ? GestureDetector(
                        child: Column(
                          children: [
                            Text('Doctor ID: ${result.code}'),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              text: 'Add doc id',
                              onTap: readQR,
                            )
                          ],
                        ),
                        onTap: () => {readQR()},
                      )
                    : Text('Scan a code'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
