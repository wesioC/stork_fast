import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stork_fast/model/frete.dart';

import 'home.dart';
import 'my_drawer.dart';

class Busca extends StatelessWidget {
  String placa;
  Busca({
    Key? key,
    required this.placa,
  }) : super(key: key);
  Future<List<Frete>> getAllFretes() async {
    // var res = await FirebaseFirestore.instance.collection('frete').get();
    var res = await FirebaseFirestore.instance.collection('frete').get();
    List<Frete> resultado = [];

    for (var element in res.docs) {
      resultado.add(Frete.fromMap(element.data()));
    }

    print(resultado);
    return resultado;
  }

  bool verificar(String placa, List<String> carros) {
    for (var element in carros) {
      if (element == placa) return true;
    }
    return false;
  }

  bool verificarentregues(String placa, List<String> carros) {
    for (var element in carros) {
      if (element == placa) return true;
    }
    return false;
  }

  bool naoexiste(String placa, List<String> carros) {
    int cont = 0;
    for (var element in carros) {
      if (element == placa) cont++;
    }
    if (cont > 0) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stork Fast"),
          backgroundColor: Colors.black87,
        ),
        drawer: MyDrawer(),
        body: FutureBuilder(
          future: getAllFretes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              print(
                  "-------------------------------------------------------------");
              print(snapshot.data);

              List<Frete> lista = snapshot.data as List<Frete>;
              return ListView.builder(
                itemCount: lista.length,
                itemBuilder: ((context, index) {
                  //aqui
                  int? cont = 0;
                  if (verificarentregues(placa, lista[index].entregues) &&
                      verificar(placa, lista[index].carros)) {
                    cont--;
                    return new Card(
                      child: Column(
                        children: [
                          Text("O Veiculo foi entregue ao destinatario",
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21)),
                          Text("Placa: " + placa,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14))
                        ],
                      ),
                    );
                  } else if (verificar(placa, lista[index].carros)) {
                    cont--;
                    String? atual;
                    atual = lista[index].atual;
                    return new Card(
                      child: Column(
                        children: [
                          Text("O veiculo esta a caminho",
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25)),
                          Text("Placa: " + placa,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          Text(atual!)
                        ],
                      ),
                    );
                  }
                  if (naoexiste(placa, lista[index].carros)) {
                    cont++;
                  }
                  if (naoexiste(placa, lista[index].carros)) {
                    return new Card(
                      child: Column(
                        children: [
                          Text("O Veiculo nao encontrado",
                              style: TextStyle(
                                  color: Colors.red[400],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25)),
                          Text("Placa: " + placa,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (v) => HomeScreen())),
                            child: Text('Rastrear novamente'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black87,
                              onPrimary: Colors.white,
                              shadowColor: Color.fromARGB(255, 105, 105, 105),
                              elevation: 5,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Busca(placa: placa);
                  }
                }),
              );
            }
          },
        ));
  }
}

/*
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stork Fast"),
        backgroundColor: Colors.black87,
      ),
      drawer: MyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("frete").snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            final List<DocumentSnapshot> documents = snap.data!.docs;
            snap.data.docs.
            return ListView(
              children: documents
                  .map(
                    (e) {
                      
                      Frete f = Frete.fromMap(e.data.data);
                      
                      
                      return  Card(
                      child: Column(
                        children: [
                          Icon(Icons.person),
                          ListTile(
                            title: Text(e['atual']),
                          ),
                        ],
                      ),
                    )}
                  )
                  .toList(),
            );
          } else
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black54,
              ),
            );
        },
      ),
    );
  }
  
  */
