import 'dart:convert';

import 'package:collection/collection.dart';

class Frete {
  String? placa;
  String? data;
  String? origem;
  String? destino;
  String? atual;
  List<String> carros = [];
  List<String> entregues = [];
  Frete({
    this.placa,
    this.data,
    this.origem,
    this.destino,
    this.atual,
    required this.carros,
    required this.entregues,
  });

  bool foiEntregue(String placa) {
    return entregues.contains(placa);
  }

  Frete copyWith({
    String? placa,
    String? data,
    String? origem,
    String? destino,
    String? atual,
    List<String>? carros,
    List<String>? entregues,
  }) {
    return Frete(
      placa: placa ?? this.placa,
      data: data ?? this.data,
      origem: origem ?? this.origem,
      destino: destino ?? this.destino,
      atual: atual ?? this.atual,
      carros: carros ?? this.carros,
      entregues: entregues ?? this.entregues,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (placa != null) {
      result.addAll({'placa': placa});
    }
    if (data != null) {
      result.addAll({'data': data});
    }
    if (origem != null) {
      result.addAll({'origem': origem});
    }
    if (destino != null) {
      result.addAll({'destino': destino});
    }
    if (atual != null) {
      result.addAll({'atual': atual});
    }
    result.addAll({'carros': carros});
    result.addAll({'entregues': entregues});

    return result;
  }

  factory Frete.fromMap(Map<String, dynamic> map) {
    return Frete(
      placa: map['placa'],
      data: map['data'],
      origem: map['origem'],
      destino: map['destino'],
      atual: map['atual'],
      carros: List<String>.from(map['carros']),
      entregues: List<String>.from(map['entregues']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Frete.fromJson(String source) => Frete.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Frete(placa: $placa, data: $data, origem: $origem, destino: $destino, atual: $atual, carros: $carros, entregues: $entregues)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Frete &&
        other.placa == placa &&
        other.data == data &&
        other.origem == origem &&
        other.destino == destino &&
        other.atual == atual &&
        listEquals(other.carros, carros) &&
        listEquals(other.entregues, entregues);
  }

  @override
  int get hashCode {
    return placa.hashCode ^
        data.hashCode ^
        origem.hashCode ^
        destino.hashCode ^
        atual.hashCode ^
        carros.hashCode ^
        entregues.hashCode;
  }
}
