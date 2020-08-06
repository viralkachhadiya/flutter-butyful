import 'package:Butyful/UI/qrview.dart';
import 'package:Butyful/Utils/color.dart';
import 'package:Butyful/Utils/responsiveUI.dart';
import 'package:Butyful/Utils/session.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final resultlist = itemReport
        .where((element) =>
            element.itemid.toString().startsWith(query) ||
            element.itemcode.startsWith(query) ||
            element.description.startsWith(query) ||
            element.actualcost.toString().startsWith(query) ||
            element.subcategory.startsWith(query) ||
            element.unit.startsWith(query) ||
            element.inventory.toString().startsWith(query) ||
            element.totalvalue.toString().startsWith(query))
        .toList();
    return ListView.builder(
        itemCount: resultlist.length,
        itemBuilder: (context, index) {
          String qrtext =
              "${resultlist[index].itemid},${resultlist[index].description}";
          return QRCard(
            itemcode: resultlist[index].itemcode,
            description: resultlist[index].description,
            unit: resultlist[index].unit,
            inventory: resultlist[index].inventory,
            actualcost: resultlist[index].actualcost,
            totalvalue: resultlist[index].totalvalue,
            subcategory: resultlist[index].subcategory,
            qrtext: qrtext,
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionlist = itemReport
        .where((element) =>
            element.itemid.toString().startsWith(query) ||
            element.itemcode.startsWith(query) ||
            element.description.startsWith(query) ||
            element.actualcost.toString().startsWith(query) ||
            element.subcategory.startsWith(query) ||
            element.unit.startsWith(query) ||
            element.inventory.toString().startsWith(query) ||
            element.totalvalue.toString().startsWith(query))
        .toList();
    return ListView.builder(
        itemCount: suggestionlist.length,
        itemBuilder: (context, index) {
          String qrtext =
              "${suggestionlist[index].itemid},${suggestionlist[index].description}";
          return QRCard(
            itemcode: suggestionlist[index].itemcode,
            description: suggestionlist[index].description,
            unit: suggestionlist[index].unit,
            inventory: suggestionlist[index].inventory,
            actualcost: suggestionlist[index].actualcost,
            totalvalue: suggestionlist[index].totalvalue,
            subcategory: suggestionlist[index].subcategory,
            qrtext: qrtext,
          );
        });
  }
}

class QRCard extends StatelessWidget {
  final String itemcode;
  final String description;
  final String unit;
  final int inventory;
  final int actualcost;
  final int totalvalue;
  final String subcategory;
  final String qrtext;
  QRCard(
      {this.itemcode,
      this.description,
      this.unit,
      this.inventory,
      this.actualcost,
      this.totalvalue,
      this.subcategory,
      this.qrtext});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ResponsiveWH.responsiveH(37, context),
        width: ResponsiveWH.responsiveW(100, context),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: ResponsiveWH.responsiveW(100, context),
                height: ResponsiveWH.responsiveH(27, context),
                child: Card(
                  elevation: 10.0,
                  margin: EdgeInsets.symmetric(
                      horizontal: ResponsiveWH.responsiveW(6, context)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 30.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(child: Container()),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: ResponsiveWH.responsiveW(2, context)),
                                child: Text(
                                  itemcode,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: accents,
                                      fontSize:
                                          ResponsiveWH.responsiveW(4, context),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Unit:",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontSize: ResponsiveWH.responsiveW(
                                              5, context),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(unit,
                                        style: TextStyle(
                                            color: accents,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Inventory:",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontSize: ResponsiveWH.responsiveW(
                                              5, context),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(inventory.toString(),
                                        style: TextStyle(
                                            color: accents,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Actual Cost:",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontSize: ResponsiveWH.responsiveW(
                                              5, context),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(actualcost.toString(),
                                        style: TextStyle(
                                            color: accents,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              padding: EdgeInsets.all(
                                  ResponsiveWH.responsiveW(2, context)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Description:",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      description,
                                      style: TextStyle(
                                          color: accents,
                                          fontSize: ResponsiveWH.responsiveW(
                                              3, context)),
                                    ),
                                  )
                                ],
                              ),
                            )),
                            Padding(
                              padding: EdgeInsets.all(
                                  ResponsiveWH.responsiveW(2, context)),
                              child: Container(
                                alignment: Alignment.center,
                                height: double.infinity,
                                width: 100.0,
                                decoration: BoxDecoration(
                                    color: primary.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text(
                                  totalvalue.toString(),
                                  style: TextStyle(
                                      fontSize:
                                          ResponsiveWH.responsiveW(5, context),
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ]))
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: ResponsiveWH.responsiveW(10, context),
              top: ResponsiveWH.responsiveW(6, context),
              height: ResponsiveWH.responsiveH(15, context),
              width: ResponsiveWH.responsiveH(15, context),
              child: GestureDetector(
                onTap: () => showQRcode(context, qrtext),
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: QrImage(
                        data: qrtext,
                        version: QrVersions.auto,
                        gapless: true,
                        size: double.infinity,
                      )),
                ),
              ),
            ),
          ],
        ));
  }
}
