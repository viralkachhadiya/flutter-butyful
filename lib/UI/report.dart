import 'package:Butyful/UI/login.dart';
import 'package:Butyful/Utils/color.dart';
import 'package:Butyful/Utils/responsiveUI.dart';
import 'package:Butyful/Utils/session.dart';
import 'package:Butyful/bloc/item_master_report_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Butyful/UI/qrview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemMasterReportBloc>(
      create: (_) => ItemMasterReportBloc()..add(LoadItemMasterReport()),
      child: BlocListener<ItemMasterReportBloc, ItemMasterReportState>(
        listener: (context, state) {
          if (state is ItemMaterReportLoaded) {
            if (state.imrlist == null) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Login()));
            }
          }
        },
        child: BlocBuilder<ItemMasterReportBloc, ItemMasterReportState>(
          builder: (BuildContext context, ItemMasterReportState state) {
            if (state is ItemMaterReportLoaded) {
              var item = state.imrlist;
              itemReport = state.imrlist;
              return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    // List data = [item[index].itemid, item[index].description];
                    String qrtext =
                        "${item[index].itemid},${item[index].description}";
                    // String qrtext = jsonEncode(data);
                    print(qrtext);
                    return QRCard(
                      itemcode: item[index].itemcode,
                      description: item[index].description,
                      unit: item[index].unit,
                      inventory: item[index].inventory,
                      actualcost: item[index].actualcost,
                      totalvalue: item[index].totalvalue,
                      subcategory: item[index].subcategory,
                      qrtext: qrtext,
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
              );
            }
          },
        ),
      ),
    );
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
                              child: Column(children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child: Container()),
                                      Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "Sub Category:",
                                                style: TextStyle(
                                                    color: Color(0xff000000),
                                                    fontSize: ResponsiveWH
                                                        .responsiveW(
                                                            5, context),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(subcategory,
                                                  style: TextStyle(
                                                      color: accents,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "Unit:",
                                                style: TextStyle(
                                                    color: Color(0xff000000),
                                                    fontSize: ResponsiveWH
                                                        .responsiveW(
                                                            5, context),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(unit,
                                                  style: TextStyle(
                                                      color: accents,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "Inventory:",
                                                style: TextStyle(
                                                    color: Color(0xff000000),
                                                    fontSize: ResponsiveWH
                                                        .responsiveW(
                                                            5, context),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(inventory.toString(),
                                                  style: TextStyle(
                                                      color: accents,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "Actual Cost:",
                                                style: TextStyle(
                                                    color: Color(0xff000000),
                                                    fontSize: ResponsiveWH
                                                        .responsiveW(
                                                            5, context),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(actualcost.toString(),
                                                  style: TextStyle(
                                                      color: accents,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]))),
                      Expanded(
                          flex: 2,
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  top: ResponsiveWH.responsiveW(3, context),
                                  left: ResponsiveWH.responsiveW(5, context)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Description:",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      description,
                                      overflow: TextOverflow.ellipsis,
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
