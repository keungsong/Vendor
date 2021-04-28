import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:vendor/Provider/auth_provider.dart';
import 'package:vendor/Provider/product_provider.dart';
import 'package:vendor/Screens/add_new_product_screen.dart';
import 'package:vendor/Screens/login_screen.dart';

import 'package:vendor/Screens/register_screen.dart';
import 'package:vendor/Screens/HoneScreen.dart';

import 'package:vendor/SplashScreen/SplashScreen.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        Home.id: (context) => Home(),
        LoginSreen.id: (context) => LoginSreen(),
        AddNewProduct.id: (context) => AddNewProduct()
      },
    );
  }
}
