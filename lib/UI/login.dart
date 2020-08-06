import 'package:Butyful/Model/user.dart';
import 'package:Butyful/UI/home.dart';
import 'package:Butyful/Utils/responsiveUI.dart';
import 'package:Butyful/bloc/login_bloc.dart';
import 'package:Butyful/provider/connectivityprovider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:Butyful/Utils/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginFormkey = GlobalKey<FormState>();
  final Connectivity _connectivity = Connectivity();

  bool isvisible = false;

  String username;

  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        //   StreamBuilder(
        // stream: _connectivity.onConnectivityChanged,
        // builder: (context, snapshot) => snapshot.data ==
        //             ConnectivityResult.mobile ||
        //         snapshot.data == ConnectivityResult.wifi
        //     ?
        Consumer<ConnectivityProvider>(builder: (context, network, child) {
      switch (network.checkconnection()) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginLoaded) {
                if (state.responsestatus["status"]) {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => Home()));
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(state.responsestatus["message"]),
                    backgroundColor: Color(0xff000000),
                    duration: Duration(seconds: 2),
                  ));
                }
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
                builder: (BuildContext context, LoginState state) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding:
                        EdgeInsets.all(ResponsiveWH.responsiveW(8.0, context)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Form(
                          key: _loginFormkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: ResponsiveWH.responsiveH(20, context),
                              ),
                              Text(
                                "Sign In",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        ResponsiveWH.responsiveW(15, context),
                                    color: primary),
                              ),
                              SizedBox(
                                height: ResponsiveWH.responsiveW(15, context),
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
                                      labelText: "Username",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                              color: Color(0xff00b0ff)))),
                                  onSaved: (val) {
                                    username = val;
                                  },
                                  validator: (val) => val.isEmpty
                                      ? "Please Enter a Username"
                                      : null,
                                ),
                              ),
                              SizedBox(
                                height: ResponsiveWH.responsiveW(5, context),
                              ),
                              SizedBox(
                                child: TextFormField(
                                  obscureText: !isvisible,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(isvisible
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              isvisible = !isvisible;
                                            });
                                          }),
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                              color: Color(0xff00b0ff))),
                                      labelText: "Password",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                              color: Color(0xff00b0ff)))),
                                  onSaved: (val) {
                                    password = val;
                                  },
                                  validator: (val) => val.isEmpty
                                      ? "Please Enter a Password"
                                      : null,
                                ),
                              ),
                              SizedBox(
                                height: ResponsiveWH.responsiveW(10, context),
                              ),
                              Container(
                                  height: 50.0,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: EdgeInsets.zero,
                                    color: Color(0xff00b0ff),
                                    onPressed: state is LoginLoading
                                        ? () {}
                                        : () async {
                                            if (_loginFormkey.currentState
                                                .validate()) {
                                              _loginFormkey.currentState.save();
                                              Map user = User(
                                                      username: username,
                                                      password: password)
                                                  .tojson();
                                              BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .add(
                                                      Authenticate(user: user));
                                            }
                                          },
                                    child: state is LoginLoading
                                        ? CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Color(0xffffffff)),
                                          )
                                        : Text(
                                            "SIGN IN",
                                            style: TextStyle(
                                                color: Color(0xffffffff)),
                                          ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
          break;
        case ConnectivityResult.none:
          return Center(child: Text("Your Device is Offline Mode"));
          break;
        default:
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffffffff)),
            ),
          );
      }
      //       : Center(
      //           child: CircularProgressIndicator(
      //             valueColor: AlwaysStoppedAnimation<Color>(primary),
      //           ),
      //         ),
      // )
    }));
  }
}
