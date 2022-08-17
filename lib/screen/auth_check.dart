import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:stork_fast/screen/home.dart';
import 'package:stork_fast/screen/login.dart';
import 'package:stork_fast/service/auth_service.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    if (auth.isLoading)
      return loading();
    else if (auth.usuario == null)
      return Login();
    else
      return HomeScreen();
  }

  loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.black45),
      ),
    );
  }
}
