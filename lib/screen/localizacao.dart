import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../store/frete_store.dart';
import 'my_drawer.dart';

class Localizacao extends StatelessWidget {
  Localizacao({Key? key}) : super(key: key);
  var store = GetIt.I<FreteStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stork Fast"),
        backgroundColor: Colors.black87,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 70),
          child: Column(
            children: [
              Text("Atualização da localização diária:",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                child: Observer(builder: (_) {
                  return TextField(
                    decoration: InputDecoration(
                      errorText: store.isValidCod,
                      labelText: "Digite o código do frete",
                      border: OutlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black54,
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                      ),
                    ),
                    controller: store.controllerCod,
                    onChanged: (value) {
                      print(value);
                      store.setCod(value);
                    },
                  );
                }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                child: Observer(builder: (_) {
                  return TextFormField(
                    decoration: InputDecoration(
                      errorText: store.isValidOrigem,
                      labelText: "Digite a próxima parada",
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
                    controller: store.controllerAtual,
                    onChanged: (value) {
                      print(value);
                      store.setAtual("Veículo encaminhado para: " + value);
                    },
                  );
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Observer(builder: (_) {
                    return ElevatedButton(
                      onPressed: store.atualizarlocalizacao(),
                      child: Text("Adicionar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black87,
                        onPrimary: Colors.white,
                        shadowColor: Color.fromARGB(255, 105, 105, 105),
                        elevation: 5,
                      ),
                    );
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
