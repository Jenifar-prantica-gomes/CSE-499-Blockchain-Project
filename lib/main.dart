//import 'package:cse499_project/Company/approved_list/approved_list.dart';
import 'package:cse499_project/Company/QR_Code_generate/QR_CODE_GENERATE.dart';
import 'package:cse499_project/Costomer/Scanner/Scanner.dart';

import 'package:cse499_project/Farmer/AddCrops_Verifiction/ADD_CROPS/Add_Crop.dart';
import 'package:cse499_project/Starting_page/StartPage.dart';
import 'package:cse499_project/Costomer//user_scanner_button/Scanner_button_user_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Starting_Page(), // Starting_Page(),
    );
  }
}
