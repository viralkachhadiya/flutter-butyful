import 'dart:ui';

import 'package:Butyful/Utils/responsiveUI.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future showQRcode(context, itemcode) {
  return showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black45,
      transitionDuration: Duration(milliseconds: 50),
      context: context,
      pageBuilder: (BuildContext context, Animation a1, Animation a2) {
        return Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100.withOpacity(0.1),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: ResponsiveWH.responsiveH(40, context),
                width: ResponsiveWH.responsiveW(70, context),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: QrImage(
                      data: itemcode,
                      version: QrVersions.auto,
                      gapless: true,
                      size: double.infinity,
                    )),
              ),
            )
          ],
        );
      });
}
