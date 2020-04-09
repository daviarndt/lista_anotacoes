import 'package:flutter/material.dart';
import 'package:lista_anotacoes/screens/lista_anotacoes.dart';

void main() => runApp(KeepIt());

class KeepIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaAnotacoes(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
