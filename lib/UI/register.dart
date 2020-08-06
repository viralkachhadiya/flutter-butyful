import 'dart:convert';

import 'package:Butyful/Model/user.dart';
import 'package:Butyful/UI/login.dart';
import 'package:Butyful/Utils/responsiveUI.dart';
import 'package:Butyful/Utils/routes.dart';
import 'package:Butyful/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:Butyful/Utils/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerFormkey = GlobalKey<FormState>();

  String group = "2";

  String isadmin = "2";
  String username;
  String password;

  var checkboxdata = [
    {"ModuleId": "ItemMaster", "flgIsAccess": true},
    {"ModuleId": "ItemMasterReport", "flgIsAccess": false},
    {"ModuleId": "Production", "flgIsAccess": false},
    {"ModuleId": "Users", "flgIsAccess": false}
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoaded) {
          if (!state.responsestatus["status"] &&
              state.responsestatus["message"] == "Login Again...") {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Login()));
          } else if (state.responsestatus["status"] &&
              state.responsestatus["message"] == "Record inserted") {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.responsestatus["message"]),
              backgroundColor: Color(0xff000000),
              duration: Duration(seconds: 2),
            ));
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.responsestatus["message"]),
              backgroundColor: Color(0xff000000),
              duration: Duration(seconds: 2),
            ));
          }
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(ResponsiveWH.responsiveW(8.0, context)),
            child: SingleChildScrollView(
              child: Form(
                key: _registerFormkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Color(0xff00b0ff))),
                            labelText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Color(0xff00b0ff)))),
                        onSaved: (val) {
                          print(val);
                          username = val;
                        },
                        validator: (val) =>
                            val.isEmpty ? "Please Enter a Username" : null,
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
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Color(0xff00b0ff))),
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Color(0xff00b0ff)))),
                        onSaved: (val) {
                          print(val);
                          password = val;
                        },
                        validator: (val) =>
                            val.isEmpty ? "Please Enter a Password" : null,
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
                            margin: EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Text(
                              "IsAdmin",
                              style: TextStyle(color: accents, fontSize: 15.0),
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Radio(
                                          value: "1",
                                          groupValue: group,
                                          onChanged: (val) {
                                            setState(() {
                                              isadmin = val;
                                              group = val;
                                            });
                                          }),
                                      Text(
                                        "True",
                                        style: TextStyle(
                                            color: accents, fontSize: 15.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Radio(
                                          value: "2",
                                          groupValue: group,
                                          onChanged: (val) {
                                            setState(() {
                                              isadmin = val;
                                              group = val;
                                            });
                                          }),
                                      Text(
                                        "False",
                                        style: TextStyle(
                                            color: accents, fontSize: 15.0),
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
                                margin: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: Text(
                                  "Select Role",
                                  style:
                                      TextStyle(color: accents, fontSize: 15.0),
                                ),
                              ),
                              ...checkboxdata.map((e) {
                                return CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: e["flgIsAccess"],
                                    title: Text(
                                      e["ModuleId"],
                                      style: TextStyle(
                                          color: accents, fontSize: 15.0),
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        e["flgIsAccess"] = val;
                                      });
                                      print(checkboxdata);
                                    });
                              }).toList(),
                            ])),
                    SizedBox(
                      height: ResponsiveWH.responsiveW(10, context),
                    ),
                    Container(
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: EdgeInsets.zero,
                        color: Color(0xff00b0ff),
                        onPressed: state is RegisterLoading
                            ? () {}
                            : () {
                                if (_registerFormkey.currentState.validate()) {
                                  _registerFormkey.currentState.save();
                                  checkboxdata.map((e) {
                                    if (e["ModuleId"] == "ItemMaster") {
                                      e["ModuleId"] = 1;
                                    } else if (e["ModuleId"] ==
                                        "ItemMasterReport") {
                                      e["ModuleId"] = 2;
                                    } else if (e["ModuleId"] == "Production") {
                                      e["ModuleId"] = 3;
                                    } else if (e["ModuleId"] == "Users") {
                                      e["ModuleId"] = 4;
                                    }
                                  }).toList();
                                  print(checkboxdata);
                                  Map user = User(
                                          username: username,
                                          password: password,
                                          isadmin: isadmin,
                                          permission: checkboxdata)
                                      .toJson();
                                  print(jsonEncode(user));
                                  BlocProvider.of<RegisterBloc>(context)
                                      .add(AddUser(user: user));
                                  _registerFormkey.currentState.reset();
                                  checkboxdata = [
                                    {
                                      "ModuleId": "ItemMaster",
                                      "flgIsAccess": true
                                    },
                                    {
                                      "ModuleId": "ItemMasterReport",
                                      "flgIsAccess": false
                                    },
                                    {
                                      "ModuleId": "Production",
                                      "flgIsAccess": false
                                    },
                                    {"ModuleId": "Users", "flgIsAccess": false}
                                  ];
                                }
                              },
                        child: state is RegisterLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xffffffff)),
                              )
                            : Text(
                                "SIGN UP",
                                style: TextStyle(color: Color(0xffffffff)),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
