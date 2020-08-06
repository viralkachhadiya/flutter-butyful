import 'package:Butyful/Model/production.dart';
import 'package:Butyful/UI/login.dart';
import 'package:Butyful/Utils/color.dart';
import 'package:Butyful/Utils/responsiveUI.dart';
import 'package:Butyful/bloc/production_bloc.dart';
import 'package:Butyful/bloc/table_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Production extends StatefulWidget {
  final List qrdata;
  Production({this.qrdata});
  @override
  _ProductionState createState() => _ProductionState();
}

class _ProductionState extends State<Production> {
  final _productionFormkey = new GlobalKey<FormState>();
  TextEditingController _productcontroller = new TextEditingController();
  bool iserror = false;

  DateTime selectedDate;
  String date;
  String group;
  String tableid;
  TimeOfDay time;
  String timedata;
  String masterbox;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final selecttime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (selecttime != null && selecttime != time)
      setState(() {
        time = selecttime;
        timedata = time.toString().substring(10, 15);
      });
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    date = "${selectedDate.toLocal()}".split(' ')[0];
    time = TimeOfDay.now();
    timedata = time.toString().substring(10, 15);
  }

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
    _productcontroller.text = widget.qrdata[1];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: secondry),
        title: Text(
          "Production",
          style: TextStyle(fontWeight: FontWeight.bold, color: secondry),
        ),
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<TableBloc>(
            create: (context) => TableBloc()..add(LoadTable()),
          ),
          BlocProvider<ProductionBloc>(
            create: (context) => ProductionBloc(),
          )
        ],
        child: BlocListener<TableBloc, TableState>(
          listener: (BuildContext context, tablestate) {
            if (tablestate is TableLoaded) {
              if (tablestate.tablelist == null) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Login()));
              }
            }
          },
          child: BlocBuilder<TableBloc, TableState>(
            builder: (BuildContext context, TableState tablestate) {
              if (tablestate is TableLoaded) {
                return BlocListener<ProductionBloc, ProductionState>(
                  listener: (context, state) {
                    if (state is ProductionLoaded) {
                      if (!state.responsestates["status"] &&
                          state.responsestates["message"] == "Login Again...") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => Login()));
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
                  child: BlocBuilder<ProductionBloc, ProductionState>(
                      builder: (context, state) {
                    return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveWH.responsiveW(8.0, context)),
                        child: Form(
                            key: _productionFormkey,
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          ResponsiveWH.responsiveW(5, context),
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(color: primary),
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 10.0, top: 10.0),
                                                child: Text(
                                                  "Date",
                                                  style: TextStyle(
                                                      color: accents,
                                                      fontSize: 15.0),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 10.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Text(
                                                        date,
                                                        style: TextStyle(
                                                            fontSize: 17.0,
                                                            color:
                                                                Colors.black87
                                                            // Text colour here
                                                            ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        _selectDate(context);
                                                      },
                                                      icon: Icon(
                                                          Icons.date_range,
                                                          color: primary),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ])),
                                    SizedBox(
                                      height:
                                          ResponsiveWH.responsiveW(5, context),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color:
                                                iserror ? Colors.red : primary),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 10.0, top: 10.0),
                                            child: Text(
                                              "Table No *",
                                              style: TextStyle(
                                                  color: accents,
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                          Wrap(children: [
                                            for (int i = 0;
                                                i < tablestate.tablelist.length;
                                                i++)
                                              Container(
                                                width: 100.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Radio(
                                                        value: tablestate
                                                            .tablelist[i]
                                                            .tableid
                                                            .toString(),
                                                        groupValue: group,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            tableid = val;
                                                            group = val;
                                                          });
                                                        }),
                                                    Text(
                                                      tablestate
                                                          .tablelist[i].tableno
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: accents,
                                                          fontSize: 15.0),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          ResponsiveWH.responsiveW(5, context),
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(color: primary),
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 10.0, top: 10.0),
                                                child: Text(
                                                  "Time",
                                                  style: TextStyle(
                                                      color: accents,
                                                      fontSize: 15.0),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 10.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Text(
                                                        timedata,
                                                        style: TextStyle(
                                                            fontSize: 17.0,
                                                            color:
                                                                Colors.black87
                                                            // Text colour here
                                                            ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        _selectTime(context);
                                                      },
                                                      icon: Icon(
                                                          Icons.access_time,
                                                          color: primary),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ])),
                                    SizedBox(
                                      height:
                                          ResponsiveWH.responsiveW(5, context),
                                    ),
                                    SizedBox(
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                    color: Color(0xff00b0ff))),
                                            labelText:
                                                "Master Boxes Producted *",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                    color: Color(0xff00b0ff)))),
                                        onSaved: (val) {
                                          print(val);
                                          masterbox = val;
                                        },
                                        validator: (val) => val.isEmpty
                                            ? "Please Enter a Boxes Producted"
                                            : validate(val)
                                                ? null
                                                : "Plese Enter a Boxes Producted",
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          ResponsiveWH.responsiveW(5, context),
                                    ),
                                    SizedBox(
                                      child: TextFormField(
                                        controller: _productcontroller,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            enabled: false,
                                            isDense: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                    color: Color(0xff00b0ff))),
                                            labelText: "Plan Product Name",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                    color: Color(0xff00b0ff)))),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          ResponsiveWH.responsiveW(10, context),
                                    ),
                                    Container(
                                      height: 50.0,
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        padding: EdgeInsets.zero,
                                        color: Color(0xff00b0ff),
                                        onPressed: state is ProductionLoading
                                            ? () {}
                                            : () async {
                                                if (tableid == null) {
                                                  setState(() {
                                                    iserror = true;
                                                  });
                                                } else {
                                                  if (_productionFormkey
                                                      .currentState
                                                      .validate()) {
                                                    _productionFormkey
                                                        .currentState
                                                        .save();

                                                    Map prodction =
                                                        ItemProduction(
                                                                productiondate:
                                                                    date,
                                                                tblid: tableid,
                                                                productiontime:
                                                                    timedata,
                                                                masterbox:
                                                                    masterbox,
                                                                itemid: widget
                                                                    .qrdata[0]
                                                                    .toString())
                                                            .toJson();
                                                    BlocProvider.of<
                                                                ProductionBloc>(
                                                            context)
                                                        .add(AddProduction(
                                                            production:
                                                                prodction));
                                                    _productionFormkey
                                                        .currentState
                                                        .reset();
                                                    _productcontroller.clear();
                                                    tableid = "";
                                                    group = "";
                                                    setState(() {
                                                      iserror = false;
                                                    });
                                                  }
                                                }
                                              },
                                        child: state is ProductionLoading
                                            ? CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Color(0xffffffff)),
                                              )
                                            : Text(
                                                "SUBMIT",
                                                style: TextStyle(
                                                    color: Color(0xffffffff)),
                                              ),
                                      ),
                                    )
                                  ]),
                            )));
                  }),
                );
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
      ),
    );
  }
}
