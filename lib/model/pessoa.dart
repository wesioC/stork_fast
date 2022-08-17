// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Pessoa {
  String? nome;
  String? telefone;
  int? idade;
  String? email;
  Pessoa({
    this.nome,
    this.telefone,
    this.idade,
    this.email,
  });

  Pessoa copyWith({
    String? nome,
    String? telefone,
    int? idade,
    String? email,
  }) {
    return Pessoa(
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      idade: idade ?? this.idade,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'telefone': telefone,
      'idade': idade,
      'email': email,
    };
  }

  factory Pessoa.fromMap(Map<String, dynamic> map) {
    return Pessoa(
      nome: map['nome'] != null ? map['nome'] as String : null,
      telefone: map['telefone'] != null ? map['telefone'] as String : null,
      idade: map['idade'] != null ? map['idade'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pessoa.fromJson(String source) =>
      Pessoa.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pessoa(nome: $nome, telefone: $telefone, idade: $idade, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pessoa &&
        other.nome == nome &&
        other.telefone == telefone &&
        other.idade == idade &&
        other.email == email;
  }

  @override
  int get hashCode {
    return nome.hashCode ^ telefone.hashCode ^ idade.hashCode ^ email.hashCode;
  }
}
