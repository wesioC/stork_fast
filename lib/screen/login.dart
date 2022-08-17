import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stork_fast/screen/home.dart';
import 'package:stork_fast/service/auth_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  void setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        titulo = 'Bem vindo';
        actionButton = "Entrar";
        toggleButton = "Ainda não tem conta? Cadastre-se agora.";
      } else {
        titulo = 'Crie sua conta';
        actionButton = "Cadastrar";
        toggleButton = "Voltar ao Login.";
      }
    });
  }

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  registrar() async {
    try {
      setState(() => loading = true);
      await context.read<AuthService>().registrar(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stork Fast"),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 70),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(titulo,
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black54,
                          width: 2,
                        )),
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o email corretamente!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                    child: TextFormField(
                      controller: senha,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        border: OutlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black54,
                          width: 2,
                        )),
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe sua senha';
                        } else if (value.length < 6) {
                          return 'Senha deve conter no mínimo 6 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: ElevatedButton(
                      onPressed: () {
                        if (isLogin) {
                          login();
                        } else {
                          registrar();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: (loading)
                            ? [
                                Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ))
                              ]
                            : [
                                Icon(Icons.check),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    actionButton,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black87,
                        onPrimary: Colors.white,
                        shadowColor: Color.fromARGB(255, 105, 105, 105),
                        elevation: 5,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () => setFormAction(!isLogin),
                      child: Text(toggleButton,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 15)))
                ],
              ),
            )),
      ),
    );
  }
}
