import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeScreen extends StatefulWidget {
  static const routeName = "/qr-code";

  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Barcode result;
  late QRViewController controller;

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
        resultInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //for opening the qr code link in the browser
  void customLaunch(command) async {
    await launch(command);
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
                        child: Text('Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}'),
                        onTap: () => {customLaunch(result.code)},
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
