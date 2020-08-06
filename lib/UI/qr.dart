import 'dart:convert';

import 'package:Butyful/UI/production.dart';
import 'package:Butyful/UI/qrbottomshit.dart';
import 'package:Butyful/Utils/color.dart';
import 'package:Butyful/Utils/responsiveUI.dart';
import 'package:Butyful/Utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Qr extends StatefulWidget {
  @override
  _QrState createState() => _QrState();
}

class _QrState extends State<Qr> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  @override
  void initState() {
    super.initState();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (scanData != null) {
        try {
          List data = scanData.split(',');
          print(data);
          if (data.length == 2) {
            print(data[0]);
            controller.pauseCamera();
            await Navigator.push(context,
                MaterialPageRoute(builder: (_) => Production(qrdata: data)));
            controller.resumeCamera();
            print(data);
          } else {
            controller.pauseCamera();
            await showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                isScrollControlled: true,
                enableDrag: true,
                context: context,
                builder: (context) => QrBottomShit());
            controller.resumeCamera();
          }
        } catch (e) {
          controller.pauseCamera();
          await showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              isScrollControlled: true,
              enableDrag: true,
              context: context,
              builder: (context) => QrBottomShit());
          controller.resumeCamera();
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: accents,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: ResponsiveWH.responsiveW(70.0, context),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.all(20.0),
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundColor: primary,
              child: IconButton(
                  icon: Icon(
                    Icons.lightbulb_outline,
                    color: Color(0xffffffff),
                  ),
                  onPressed: () {
                    controller.toggleFlash();
                  }),
              radius: 30.0,
            )),
      ],
    );
  }
}
