import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../controllers/filme_controller.dart';
import '../models/filme.dart';

class EditarFilmeScreen extends StatefulWidget {
  final Filme filme;

  EditarFilmeScreen({required this.filme});

  @override
  _EditarFilmeScreenState createState() => _EditarFilmeScreenState();
}

class _EditarFilmeScreenState extends State<EditarFilmeScreen> {
  final _formKey = GlobalKey<FormState>();
  final FilmeController _filmeController = FilmeController();

  late String titulo;
  late String urlImagem;
  late String genero;
  late String faixaEtaria;
  late int duracao;
  late double pontuacao;
  late String descricao;
  late int ano;

  @override
  void initState() {
    super.initState();
    titulo = widget.filme.titulo;
    urlImagem = widget.filme.urlImagem;
    genero = widget.filme.genero;
    faixaEtaria = widget.filme.faixaEtaria;
    duracao = widget.filme.duracao;
    pontuacao = widget.filme.pontuacao;
    descricao = widget.filme.descricao;
    ano = widget.filme.ano;
  }

  void _salvarAlteracoes() async {
    if (_formKey.currentState!.validate()) {
      Filme filmeAtualizado = Filme(
        id: widget.filme.id,
        titulo: titulo,
        urlImagem: urlImagem,
        genero: genero,
        faixaEtaria: faixaEtaria,
        duracao: duracao,
        pontuacao: pontuacao,
        descricao: descricao,
        ano: ano,
      );

      await _filmeController.atualizarFilme(filmeAtualizado);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Filme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: titulo,
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
                initialValue: urlImagem,
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
                initialValue: genero,
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
                initialValue: duracao.toString(),
                decoration: InputDecoration(labelText: 'Duração (min)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  duracao = int.tryParse(value) ?? duracao;
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
                initialValue: descricao,
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
                initialValue: ano.toString(),
                decoration: InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  ano = int.tryParse(value) ?? ano;
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _salvarAlteracoes,
                child: Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
