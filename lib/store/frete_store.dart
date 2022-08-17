import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:stork_fast/model/frete.dart';
part 'frete_store.g.dart';

class FreteStore = _FreteStoreBase with _$FreteStore;

abstract class _FreteStoreBase with Store {
  TextEditingController controllerPlaca = TextEditingController();
  TextEditingController controllerCod = TextEditingController();
  TextEditingController controllerCarros = TextEditingController();
  TextEditingController controllerEntregues = TextEditingController();
  TextEditingController controllerDataini = TextEditingController();
  TextEditingController controllerOrigem = TextEditingController();
  TextEditingController controllerDestino = TextEditingController();
  TextEditingController controllerAtual = TextEditingController();

  @observable
  String? placa;
  @action
  void setPlaca(String? v) {
    if (v == null) controllerPlaca.text = "";
    placa = v;
  }

  @computed
  String? get isValidPlaca {
    if (placa == null)
      return null;
    else if (placa!.isEmpty) {
      return "O campo não pode ser vazio!";
    } else if (placa!.length < 7) return "Placa inválida!";
    return null;
  }

  @observable
  String? cod;
  @action
  void setCod(String? v) {
    if (v == null) controllerCod.text = "";
    cod = v;
  }

  @computed
  String? get isValidCod {
    if (cod == null)
      return null;
    else if (cod!.isEmpty) {
      return "O campo não pode ser vazio!";
    } else if (cod!.length < 5) return "cod inválido!";
    return null;
  }

  @observable
  String? dataini;
  @action
  void setDataini(String? v) {
    if (v == null) controllerDataini.text = "";
    dataini = v;
  }

  @computed
  String? get isValidData {
    if (dataini == null)
      return null;
    else if (dataini!.isEmpty) {
      return "O campo não pode ser vazio!";
    } else if (dataini!.length < 10) return "data Incvállida";
    return null;
  }

  @observable
  String? origem;
  @action
  void setOrigem(String? v) {
    if (v == null) controllerOrigem.text = "";
    origem = v;
  }

  @computed
  String? get isValidOrigem {
    if (origem == null)
      return null;
    else if (origem!.isEmpty) {
      return "O campo não pode ser vazio!";
    }
    return null;
  }

  @observable
  String? destino;
  @action
  void setDestino(String? v) {
    if (v == null) controllerDestino.text = "";
    destino = v;
  }

  @computed
  String? get isValidDestino {
    if (destino == null)
      return null;
    else if (destino!.isEmpty) {
      return "O campo não pode ser vazio!";
    }
    return null;
  }

  @observable
  String? atual;
  @action
  void setAtual(String? v) {
    if (v == null) controllerAtual.text = "";
    atual = v;
  }

  @computed
  String? get isValidAtual {
    if (atual == null)
      return null;
    else if (atual!.isEmpty) {
      return "O campo não pode ser vazio!";
    }
    return null;
  }

  @observable
  List<String> carros = [];
  @action
  //setCarros(String value) => carros.add(value);
  void setCarros(String v) {
    if (v == null) controllerCarros.text = "";
    List<String> aux = [];
    aux.add(v);
    if (aux.last.length > 7) carros.insert(0, aux.last);
  }

  

  @observable
  List<String> entregues = [];
  @action
  void setEntregues(String v) {
    if (v == null) controllerEntregues.text = "";
    List<String> aux = [];
    aux.add(v);
    if (aux.last.length > 7) entregues.insert(0, aux.last);
  }

  Function()? save() {
    if (placa != null && isValidPlaca == null)
      //,SetOptions(merge: true)
      // ignore: curly_braces_in_flow_control_structures
      return () {
        Frete f = getDados();
        var collettion = FirebaseFirestore.instance.collection("frete");
        collettion.doc(cod).set(f.toMap());
        setPlaca(null);
        setCod(null);
        setDataini(null);
        setAtual(null);
        setDestino(null);
        setOrigem(null);
      };
    else
      return null;
  }

  Frete getDados() {
    return Frete(
        placa: placa,
        destino: destino,
        origem: origem,
        atual: atual,
        data: dataini,
        carros: [],
        entregues: []);
  }

//----------------------------------carros--------------------------
  Function()? carrosfrete() {
    if (carros != null && isValidCod == null && cod != null && isValidPlaca == null && placa!=null) {
      //,SetOptions(merge: true)
      // ignore: curly_braces_in_flow_control_structures
      return () {
        //Frete c = getDadosCarros();
        var collettion = FirebaseFirestore.instance.collection("frete");
        collettion.doc(cod).update({"carros": FieldValue.arrayUnion(carros)});
        setPlaca(null);
        setCod(null);
        controllerCarros.clear();
      };
    } else
      return null;
  }

  Function()? entregue() {
    if (entregues != null && isValidCod == null && cod != null && isValidPlaca == null && placa!=null) {
      //,SetOptions(merge: true)
      // ignore: curly_braces_in_flow_control_structures
      return () {
        //Frete c = getDadosCarros();
        var collettion = FirebaseFirestore.instance.collection("frete");
        collettion
            .doc(cod)
            .update({"entregues": FieldValue.arrayUnion(entregues)});
        setPlaca(null);
        controllerEntregues.clear();
        setCod(null);
      };
    } else
      return null;
  }

  //---------------------------Localização----------------------------
  Function()? atualizarlocalizacao() {
    if (atual != null && isValidAtual == null && cod != null) {
      //,SetOptions(merge: true)
      // ignore: curly_braces_in_flow_control_structures
      return () {
        var collettion = FirebaseFirestore.instance.collection("frete");
        collettion.doc(cod).update({"atual": atual});
        setAtual(null);
        setCod(null);
      };
    } else
      return null;
  }
}
