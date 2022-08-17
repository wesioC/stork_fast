import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:stork_fast/screen/busca.dart';

import '../store/frete_store.dart';
import 'my_drawer.dart';

class HomeScreen extends StatelessWidget {
  String? placa;
  TextEditingController controllerPlaca = TextEditingController();
  setplaca(String v) {
    placa = v;
  }

  var store = GetIt.I<FreteStore>();
  HomeScreen({Key? key, this.placa}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stork Fast"),
        backgroundColor: Colors.black87,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Código de rastreamento:",
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
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
                controller: controllerPlaca,
                onChanged: (value) {
                  print(value);
                  setplaca(value);
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                if (placa != null)
                  return Busca(placa: placa ?? "");
                else
                  return Container();
              })),
              child: Text('Rastrear'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black87,
                onPrimary: Colors.white,
                shadowColor: Color.fromARGB(255, 105, 105, 105),
                elevation: 5,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
