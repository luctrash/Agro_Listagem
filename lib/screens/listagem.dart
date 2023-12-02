import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/despesa.dart';

class DespesasList extends StatefulWidget {
  const DespesasList({Key? key}) : super(key: key);

  @override
  State<DespesasList> createState() => _DespesasListState();
}

class _DespesasListState extends State<DespesasList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem de despesas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('despesas').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return const Center(child: Text('Erro ao carregar os dados.'));
    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(child: Text('Nenhum dado encontrado.'));
    }

    final List<DocumentSnapshot> documents = snapshot.data!.docs;

    print('Número de documentos: ${documents.length}');

    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        Despesa despesa = Despesa.fromDoc(documents[index]);
        print('Despesa $index: $despesa');

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 3,
            child: ListTile(
              title: Text(despesa.nome),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(despesa.descricao),
                  SizedBox(height: 8),
                  Text(
                    'Data: ${despesa.data}',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              trailing: Text(
                'R\$ ${despesa.valor.toString()}',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  },
),
);
}
}