import 'package:cloud_firestore/cloud_firestore.dart';

class Despesa {
  String nome;
  String descricao;
  double valor;
  String data;

  Despesa({
    this.nome = "",
    this.descricao = "",
    this.valor = 0,
    this.data = "",
  });

  // Construtor estático para criar uma instância de Despesa a partir de um DocumentSnapshot
  static Despesa fromDoc(DocumentSnapshot<Object?> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Convertendo a string 'data' para DateTime
    DateTime dataFormatada =
        DateTime.tryParse(data['data'] ?? '') ?? DateTime.now();

    return Despesa(
      nome: data['nome'] ?? "",
      descricao: data['descricao'] ?? "",
      valor: (data['valor'] ?? 0.0).toDouble(),
      data: dataFormatada.toString(),
    );
  }
}