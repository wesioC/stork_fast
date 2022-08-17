import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:stork_fast/screen/login.dart';
import 'package:stork_fast/screen/my_app.dart';
import 'package:stork_fast/service/auth_service.dart';

import 'store/frete_store.dart';

void main() async {
  void inicializarSigleton() {
    GetIt.I.registerSingleton(FreteStore());
  }

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp f = await Firebase.initializeApp();
  inicializarSigleton();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: MyApp(),
    ),
    //MaterialApp(
    // debugShowCheckedModeBanner: false,
    //home: Login(),)
  );
}
