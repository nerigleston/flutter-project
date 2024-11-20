import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/filme.dart';

class DetalhesFilmeScreen extends StatelessWidget {
  final Filme filme;

  DetalhesFilmeScreen({required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(filme.titulo),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                filme.urlImagem,
                height: 200,
                width: 150,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    size: 100,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Título: ${filme.titulo}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Gênero: ${filme.genero}'),
            SizedBox(height: 8),
            Text('Faixa Etária: ${filme.faixaEtaria}'),
            SizedBox(height: 8),
            Text('Duração: ${filme.duracao} min'),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Pontuação: '),
                RatingBarIndicator(
                  rating: filme.pontuacao,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
                Text('${filme.pontuacao.toString()}'),
              ],
            ),
            SizedBox(height: 8),
            Text('Ano: ${filme.ano}'),
            SizedBox(height: 8),
            Text(
              'Descrição:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(filme.descricao),
          ],
        ),
      ),
    );
  }
}
