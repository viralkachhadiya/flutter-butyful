import 'package:Butyful/Model/itemmaster.dart';
import 'package:Butyful/UI/login.dart';
import 'package:Butyful/Utils/color.dart';
import 'package:Butyful/Utils/responsiveUI.dart';
import 'package:Butyful/Utils/routes.dart';
import 'package:Butyful/bloc/item_category_bloc.dart';
import 'package:Butyful/bloc/item_master_bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemMaster extends StatefulWidget {
  @override
  _ItemMasterState createState() => _ItemMasterState();
}

class _ItemMasterState extends State<ItemMaster> {
  final Connectivity _connectivity = Connectivity();
  final _itemFormkey = GlobalKey<FormState>();
  TextEditingController _totalamount = new TextEditingController();
  String group = "PCS";
  String selectitem;
  int i = 0, a = 0;

  String itemcode;
  String description;
  String unit = "PCS";
  int inventory;
  int actualcost;
  int totalvalue;
  int categoryid;

  bool validate(String value) {
    String pattern = r'(^[0-9]+$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // StreamBuilder(
        //   stream: _connectivity.onConnectivityChanged,
        //   builder: (context, snapshot) => snapshot.data ==
        //               ConnectivityResult.mobile ||
        //           snapshot.data == ConnectivityResult.wifi
        //       ?
        MultiBlocProvider(
      providers: [
        BlocProvider<ItemCategoryBloc>(
            create: (_) => ItemCategoryBloc()..add(LoadCategory())),
        BlocProvider<ItemMasterBloc>(
          create: (_) => ItemMasterBloc(),
        ),
      ],
      child: BlocListener<ItemCategoryBloc, ItemCategoryState>(
        listener: (BuildContext context, ItemCategoryState categorystate) {
          if (categorystate is CategoryLoaded) {
            if (categorystate.categorylist == null) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Login()));
            }
          }
        },
        child: BlocBuilder<ItemCategoryBloc, ItemCategoryState>(
          builder: (BuildContext context, ItemCategoryState categorystate) {
            if (categorystate is CategoryLoaded) {
              return BlocListener<ItemMasterBloc, ItemMasterState>(
                listener: (context, state) {
                  if (state is ItemLoaded) {
                    if (!state.responsestates["status"] &&
                        state.responsestates["message"] == "Login Again...") {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => Login()));
                    } else if (state.responsestates["status"] &&
                        state.responsestates["message"] ==
                            "1 Record Inserted") {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(state.responsestates["message"]),
                        backgroundColor: Color(0xff000000),
                        duration: Duration(seconds: 2),
                      ));
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(state.responsestates["message"]),
                        backgroundColor: Color(0xff000000),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  }
                },
                child: BlocBuilder<ItemMasterBloc, ItemMasterState>(
                  builder: (context, state) => Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveWH.responsiveW(8.0, context)),
                    child: Form(
                      key: _itemFormkey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: ResponsiveWH.responsiveW(5, context),
                            ),
                            SizedBox(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    isDense: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff00b0ff))),
                                    labelText: "Item #",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff00b0ff)))),
                                onSaved: (val) {
                                  itemcode = val;
                                },
                                validator: (val) =>
                                    val.isEmpty ? "Please Enter a Item" : null,
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveWH.responsiveW(5, context),
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    isDense: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff00b0ff))),
                                    labelText: "Description *",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff00b0ff)))),
                                onSaved: (val) {
                                  print(val);
                                  description = val;
                                },
                                validator: (val) => val.isEmpty
                                    ? "Please Enter a Description"
                                    : null,
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveWH.responsiveW(5, context),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: primary),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10.0, top: 10.0),
                                    child: Text(
                                      "Unit",
                                      style: TextStyle(
                                          color: accents, fontSize: 15.0),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Radio(
                                                  value: "PCS",
                                                  groupValue: group,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      unit = val;
                                                      group = val;
                                                    });
                                                  }),
                                              Text(
                                                "PCS",
                                                style: TextStyle(
                                                    color: accents,
                                                    fontSize: 15.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Radio(
                                                  value: "KG",
                                                  groupValue: group,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      unit = val;
                                                      group = val;
                                                    });
                                                  }),
                                              Text(
                                                "KG",
                                                style: TextStyle(
                                                    color: accents,
                                                    fontSize: 15.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Radio(
                                                  value: "Other",
                                                  groupValue: group,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      unit = val;
                                                      group = val;
                                                    });
                                                  }),
                                              Text(
                                                "Other",
                                                style: TextStyle(
                                                    color: accents,
                                                    fontSize: 15.0),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveWH.responsiveW(5, context),
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    isDense: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff00b0ff))),
                                    labelText: "Inventory",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff00b0ff)))),
                                onSaved: (val) {
                                  inventory = int.parse(val);
                                },
                                onChanged: (val) {
                                  i = int.parse(val);
                                  totalvalue = i * a;
                                  _totalamount.text = totalvalue.toString();
                                },
                                validator: (val) => val.isEmpty
                                    ? "Please Enter a Inventory"
                                    : validate(val)
                                        ? null
                                        : "Plese Enter a Valid Inventory",
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveWH.responsiveW(5, context),
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    isDense: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff00b0ff))),
                                    labelText: "Actual Cost",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff00b0ff)))),
                                onSaved: (val) {
                                  print(val);
                                  actualcost = int.parse(val);
                                },
                                onChanged: (val) {
                                  a = int.parse(val);
                                  totalvalue = i * a;
                                  _totalamount.text = totalvalue.toString();
                                },
                                validator: (val) => val.isEmpty
                                    ? "Please Enter a Actual Cost"
                                    : validate(val)
                                        ? null
                                        : "Plese Enter a Valid Actual Cost",
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveWH.responsiveW(5, context),
                            ),
                            SizedBox(
                              child: TextFormField(
                                readOnly: true,
                                controller: _totalamount,
                                decoration: InputDecoration(
                                    isDense: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff00b0ff))),
                                    labelText: "Total Amount",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff00b0ff)))),
                                validator: (val) => val.isEmpty
                                    ? "Please Enter a Inventory and Actual Cost"
                                    : null,
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveWH.responsiveW(5, context),
                            ),
                            SizedBox(
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff00b0ff))),
                                    labelText: "SubCategory",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: Color(0xff00b0ff)))),
                                isDense: true,
                                value: selectitem,
                                iconEnabledColor: primary,
                                items: categorystate.categorylist
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value.categoryid.toString(),
                                    child: Text(value.categoryname),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  selectitem = val;
                                },
                                validator: (val) => val == null
                                    ? 'Please Select SubCategory'
                                    : null,
                                onSaved: (val) {
                                  categoryid = int.parse(val);
                                },
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveWH.responsiveW(10, context),
                            ),
                            Container(
                              height: 50.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                padding: EdgeInsets.all(0.0),
                                color: Color(0xff00b0ff),
                                onPressed: state is ItemLoading
                                    ? () {}
                                    : () {
                                        if (_itemFormkey.currentState
                                            .validate()) {
                                          _itemFormkey.currentState.save();
                                          Map itemmaster = Item(
                                                  itemcode: itemcode,
                                                  description: description,
                                                  unit: unit,
                                                  inventory: inventory,
                                                  actualcost: actualcost,
                                                  totalvalue: totalvalue,
                                                  categoryid: categoryid)
                                              .toJson();
                                          BlocProvider.of<ItemMasterBloc>(
                                                  context)
                                              .add(AddItem(
                                                  itemmaster: itemmaster));
                                          _itemFormkey.currentState.reset();
                                          _totalamount.clear();
                                          selectitem = null;
                                          print(itemmaster);
                                        }
                                      },
                                child: state is ItemLoading
                                    ? CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Color(0xffffffff)),
                                      )
                                    : Text(
                                        "SUBMIT",
                                        style:
                                            TextStyle(color: Color(0xffffffff)),
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
              );
            }
          },
          //  ),
        ),
      ),
      // )
      // : Center(
      //     child: CircularProgressIndicator(
      //       valueColor: AlwaysStoppedAnimation<Color>(primary),
      //     ),
      //   ),
    );
  }
}
