import 'package:flutter/material.dart';

class FormAnotacao extends StatelessWidget {
  final TextEditingController titulo = TextEditingController();
  final TextEditingController observacao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Anotação'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titulo,
              decoration: InputDecoration(labelText: 'Título'),
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: TextField(
                controller: observacao,
                decoration: InputDecoration(
                    labelText: 'Observação',
                    border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 24),
                maxLines: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
