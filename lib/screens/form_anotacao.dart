import 'package:flutter/material.dart';
import 'package:lista_anotacoes/database/dao/anotacao_dao.dart';
import 'package:lista_anotacoes/models/anotacao.dart';

class FormAnotacao extends StatefulWidget {
  final Anotacao anotacao;

  FormAnotacao({this.anotacao});

  @override
  _FormAnotacaoState createState() => _FormAnotacaoState();
}

class _FormAnotacaoState extends State<FormAnotacao> {
  String tituloAppBar = 'Nova Anotação';

  TextEditingController _titulo = TextEditingController();
  TextEditingController _observacao = TextEditingController();

  final AnotacaoDao _anotacaoDao = AnotacaoDao();

  @override
  void initState() {
    _titulo = TextEditingController();
    _observacao = TextEditingController();
    if (widget.anotacao != null) {
      tituloAppBar = 'Ver Anotação';
      _titulo = TextEditingController(
        text: widget.anotacao.titulo,
      );
      _observacao = TextEditingController(
        text: widget.anotacao.observacao,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tituloAppBar),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titulo,
              decoration: InputDecoration(labelText: 'Título'),
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: TextField(
                controller: _observacao,
                decoration: InputDecoration(
                  labelText: 'Observação',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 24),
                maxLines: 10,
              ),
            ),
            Builder(
              builder: (context) => RaisedButton(
                onPressed: () => _criaAnotacao(context),
                textColor: Colors.white,
                child: Text(
                  'Salvar',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _criaAnotacao(BuildContext context) {
    final String titulo = _titulo.text;
    final String observacao = _observacao.text;

    if (titulo.isNotEmpty) {
      if (widget.anotacao != null) {
        widget.anotacao.titulo = _titulo.text;
        widget.anotacao.observacao = _observacao.text;
        _anotacaoDao.update(widget.anotacao);
      } else {
        final Anotacao novaAnotacao = Anotacao(0, titulo, observacao);
        _anotacaoDao.save(novaAnotacao);
      }
      Navigator.pop(context);
    } else {
      _mostraSnackBar(context);
    }
  }

  void _mostraSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Título não pode estar vazio!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
