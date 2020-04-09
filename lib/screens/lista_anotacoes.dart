import 'package:flutter/material.dart';
import 'package:lista_anotacoes/database/dao/anotacao_dao.dart';
import 'package:lista_anotacoes/models/anotacao.dart';
import 'package:lista_anotacoes/screens/form_anotacao.dart';

class ListaAnotacoes extends StatefulWidget {
  @override
  _ListaAnotacoesState createState() => _ListaAnotacoesState();
}

class _ListaAnotacoesState extends State<ListaAnotacoes> {
  final AnotacaoDao _anotacaoDao = AnotacaoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Anotações'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Anotacao>>(
        initialData: List(),
        future: _anotacaoDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Carregando...')
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Anotacao> anotacoes = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Anotacao anotacao = anotacoes[index];
                  return _ItemAnotacao(anotacao);
                },
                itemCount: anotacoes.length,
              );
              break;
          }
          return Text('Erro desconhecido');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormAnotacao(),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.redAccent,
          child: Container(height: 40.0)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _ItemAnotacao extends StatelessWidget {
  final Anotacao anotacao;

  _ItemAnotacao(this.anotacao);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.note),
        title: Text(
          anotacao.titulo,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          anotacao.observacao,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
