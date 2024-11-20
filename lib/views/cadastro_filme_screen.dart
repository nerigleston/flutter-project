import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../controllers/filme_controller.dart';
import '../models/filme.dart';

class CadastroFilmeScreen extends StatefulWidget {
  @override
  _CadastroFilmeScreenState createState() => _CadastroFilmeScreenState();
}

class _CadastroFilmeScreenState extends State<CadastroFilmeScreen> {
  final _formKey = GlobalKey<FormState>();
  final FilmeController _filmeController = FilmeController();

  String titulo = '';
  String urlImagem = '';
  String genero = '';
  String faixaEtaria = 'Livre';
  int duracao = 0;
  double pontuacao = 0.0;
  String descricao = '';
  int ano = DateTime.now().year;

  void _salvarFilme() async {
    if (_formKey.currentState!.validate()) {
      Filme filme = Filme(
        titulo: titulo,
        urlImagem: urlImagem,
        genero: genero,
        faixaEtaria: faixaEtaria,
        duracao: duracao,
        pontuacao: pontuacao,
        descricao: descricao,
        ano: ano,
      );

      await _filmeController.adicionarFilme(filme);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Filme')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Título'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                titulo = value;
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'URL da Imagem'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                urlImagem = value;
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Gênero'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                genero = value;
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: faixaEtaria,
              items: ['Livre', '10', '12', '14', '16', '18']
                  .map((faixa) => DropdownMenuItem(
                        value: faixa,
                        child: Text(faixa),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => faixaEtaria = value!),
              decoration: InputDecoration(labelText: 'Faixa Etária'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Duração (min)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                duracao = int.tryParse(value) ?? 0;
                return null;
              },
            ),
            SizedBox(height: 16),
            Text('Avaliação', style: TextStyle(fontSize: 16)),
            RatingBar.builder(
              initialRating: pontuacao,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  pontuacao = rating;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                descricao = value;
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Ano'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                ano = int.tryParse(value) ?? DateTime.now().year;
                return null;
              },
            ),
            ElevatedButton(
              onPressed: _salvarFilme,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
