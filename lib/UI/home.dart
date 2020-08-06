import 'package:Butyful/UI/login.dart';
import 'package:Butyful/UI/qr.dart';
import 'package:Butyful/UI/register.dart';
import 'package:Butyful/Utils/responsiveUI.dart';
import 'package:Butyful/Utils/session.dart';
import 'package:Butyful/provider/connectivityprovider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:Butyful/Utils/color.dart';
import 'package:Butyful/UI/item_master.dart';
import 'package:Butyful/UI/report.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Butyful/UI/search.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  String index;
  AnimationController _controller;
  Animation<double> opacity;
  Animation<double> height;
  List modulelist = [];
  Map register = {"ModuleName": "Register", "flgIsAccess": 1};
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    if (box.containsKey("user")) {
      usersession = box.get("user");
      modulelist = usersession["Permission"]
          .where((data) => data["flgIsAccess"] == 1)
          .toList();

      index = modulelist[0]["ModuleName"];
    }
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(() {
            setState(() {});
          });
    opacity = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    height = Tween<double>(begin: 0.0, end: 50.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _controller.forward();
    super.initState();
  }

  Future<void> setDraweritem(String temp) async {
    index = temp;
    _controller.reset();
    await _controller.forward();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: secondry),
          title: Text(
            index == "Item Master"
                ? "Item Master"
                : index == "Production"
                    ? "Scan Item"
                    : index == "Item Master Report" ? "Report" : "Users",
            style: TextStyle(fontWeight: FontWeight.bold, color: secondry),
          ),
          centerTitle: true,
          actions: <Widget>[
            index == "ItemMasterReport"
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(context: context, delegate: Search());
                    })
                : Container(),
          ],
        ),
        drawer: buildDrawer(),
        body:
            Consumer<ConnectivityProvider>(builder: (context, network, child) {
          switch (network.checkconnection()) {
            case ConnectivityResult.wifi:
            case ConnectivityResult.mobile:
              // StreamBuilder(
              //   stream: _connectivity.onConnectivityChanged,
              //   builder: (context, snapshot) =>
              //       snapshot.data == ConnectivityResult.mobile ||
              //               snapshot.data == ConnectivityResult.wifi
              //           ?
              return index == "Item Master"
                  ? ItemMaster()
                  : index == "Production"
                      ? Qr()
                      : index == "Item Master Report" ? Report() : Register();
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
        })

        //           : Center(
        //               child: CircularProgressIndicator(
        //                 valueColor: AlwaysStoppedAnimation<Color>(primary),
        //               ),
        //             ),
        // ),
        );
  }

  //animation builder for side line animation in drawer item
  AnimatedBuilder buildAnimatedBuilder(String animateindex) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: opacity.value,
          child: Container(
            width: index == animateindex ? 8 : 0,
            height: index == animateindex ? height.value : 0,
            decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0))),
          ),
        );
      },
    );
  }

  //navigation Drawer
  Drawer buildDrawer() {
    return Drawer(
      child: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          UserAccountsDrawerHeader(
              accountName: Center(
                child: CircleAvatar(
                    backgroundColor: Color(0xffffffff),
                    radius: 40.0,
                    child: Icon(
                      Icons.person,
                      color: primary,
                      size: 40.0,
                    )),
              ),
              accountEmail: Center(
                child: Text(
                  usersession["Username"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.bold),
                ),
              )),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: ResponsiveWH.responsiveH(10, context),
                  ),
                  ...modulelist
                      .map(
                        (e) => Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                buildAnimatedBuilder(e["ModuleName"]),
                                Expanded(
                                  child: ListTile(
                                    leading: e["ModuleName"] == "Item Master"
                                        ? FaIcon(
                                            FontAwesomeIcons.mastodon,
                                            color: index == e["ModuleName"]
                                                ? primary
                                                : accents,
                                          )
                                        : e["ModuleName"] == "Production"
                                            ? FaIcon(
                                                FontAwesomeIcons.productHunt,
                                                color: index == e["ModuleName"]
                                                    ? primary
                                                    : accents,
                                              )
                                            : e["ModuleName"] == "Users"
                                                ? FaIcon(
                                                    FontAwesomeIcons.registered,
                                                    color:
                                                        index == e["ModuleName"]
                                                            ? primary
                                                            : accents,
                                                  )
                                                : Icon(
                                                    Icons.event_note,
                                                    color:
                                                        index == e["ModuleName"]
                                                            ? primary
                                                            : accents,
                                                  ),
                                    title: Text(
                                      e["ModuleName"],
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: index == e["ModuleName"]
                                              ? primary
                                              : accents,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () => setDraweritem(e["ModuleName"]),
                                  ),
                                ),
                              ],
                            )),
                      )
                      .toList(),
                  Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildAnimatedBuilder("Logouts"),
                          Expanded(
                            child: ListTile(
                              leading: Icon(
                                Icons.exit_to_app,
                                color: index == "Logout" ? primary : accents,
                              ),
                              title: Text(
                                "Logout",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color:
                                        index == "Logout" ? primary : accents,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                index = "Logout";
                                logoutDialog(context);
                              },
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  logoutDialog(context) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are You sure you want to Logout?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                box.clear();
                usersession.clear();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Login()));
              },
            )
          ],
        );
      },
    );
  }
}
