import 'package:Butyful/UI/home.dart';
import 'package:Butyful/UI/login.dart';
import 'package:Butyful/Utils/router.dart';
import 'package:Butyful/Utils/routes.dart';
import 'package:Butyful/bloc/item_category_bloc.dart';
import 'package:Butyful/bloc/item_master_bloc.dart';
import 'package:Butyful/bloc/item_master_report_bloc.dart';
import 'package:Butyful/bloc/login_bloc.dart';
import 'package:Butyful/bloc/production_bloc.dart';
import 'package:Butyful/bloc/register_bloc.dart';
import 'package:Butyful/bloc/table_bloc.dart';
import 'package:Butyful/provider/connectivityprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'Utils/session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));
  String route = Routes.Login;
  Widget root = Login();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  box = await Hive.openBox("authenticate");
  if (box.containsKey("user")) {
    route = Routes.Home;
    root = Home();
    usersession = box.get("user");
  } else {
    route = Routes.Login;
    root = Login();
  }
  runApp(ChangeNotifierProvider<ConnectivityProvider>(
    create: (_) => ConnectivityProvider(),
    child: MultiBlocProvider(providers: [
      BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
      BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(),
      ),
    ], child: MyApp(root)),
  ));
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
}

class MyApp extends StatelessWidget {
  final Widget root;
  MyApp(this.root);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff00b0ff),
        cursorColor: Color(0xff00b0ff),
        accentColor: Color(0xff00b0ff),
      ),
      home: root,
    );
  }
}
