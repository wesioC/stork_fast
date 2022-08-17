import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:stork_fast/screen/add_carros.dart';
import 'package:stork_fast/store/frete_store.dart';

import 'my_drawer.dart';

class FreteScreen extends StatelessWidget {
  FreteScreen({Key? key}) : super(key: key);
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
          child: Form(
            child: Column(
              children: [
                Text("Cadastro de frete de veículos:",
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
                      inputFormatters: [PlacaVeiculoInputFormatter()],
                      decoration: InputDecoration(
                        errorText: store.isValidPlaca,
                        labelText: "Digite a placa da Cegonha",
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
                      controller: store.controllerPlaca,
                      onChanged: (value) {
                        print(value);
                        store.setPlaca(value);
                      },
                    );
                  }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                  child: Observer(builder: (_) {
                    return TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        errorText: store.isValidData,
                        labelText: "Digite a data inicial",
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
                      controller: store.controllerDataini,
                      onChanged: (value) {
                        print(value);
                        store.setDataini(value);
                      },
                    );
                  }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                  child: Observer(builder: (_) {
                    return TextField(
                      decoration: InputDecoration(
                        errorText: store.isValidOrigem,
                        labelText: "Digite a origem do frete",
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
                      controller: store.controllerOrigem,
                      onChanged: (value) {
                        print(value);
                        store.setOrigem(value);
                      },
                    );
                  }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                  child: Observer(builder: (_) {
                    return TextField(
                      decoration: InputDecoration(
                        errorText: store.isValidDestino,
                        labelText: "Digite o destino do frete",
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
                      controller: store.controllerDestino,
                      onChanged: (value) {
                        print(value);
                        store.setDestino(value);
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
                        onPressed: store.save(),
                        child: Text("Cadastrar"),
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
                TextButton(
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => AddCarros())),
                    child: Text("Clique para dicionar os carros do frete.",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 15)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
