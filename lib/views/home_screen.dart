import 'package:flutter/material.dart';
import '../controllers/filme_controller.dart';
import '../models/filme.dart';
import 'cadastro_filme_screen.dart';
import 'detalhes_filme_screen.dart';
import 'editar_filme_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FilmeController _filmeController = FilmeController();
  List<Filme> filmes = [];

  @override
  void initState() {
    super.initState();
    carregarFilmes();
  }

  Future<void> carregarFilmes() async {
    filmes = await _filmeController.listarFilmes();
    setState(() {});
  }

  void _adicionarFilme() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CadastroFilmeScreen()),
    );
    carregarFilmes();
  }

  void _deletarFilme(int id) async {
    await _filmeController.deletarFilme(id);
    carregarFilmes();
  }

  void _mostrarOpcoes(Filme filme) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Exibir Dados'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesFilmeScreen(filme: filme),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Alterar'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditarFilmeScreen(filme: filme),
                    ),
                  ).then((atualizado) {
                    if (atualizado == true) {
                      carregarFilmes();
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Grupo'),
                  content: Text('Neri, Gabriel, Marilise'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filmes.length,
        itemBuilder: (context, index) {
          final filme = filmes[index];
          return Dismissible(
            key: ValueKey(filme.id),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              _deletarFilme(filme.id!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${filme.titulo} deletado')),
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              leading: _buildImage(filme.urlImagem),
              title: Text(filme.titulo),
              subtitle: Text(filme.genero),
              onTap: () => _mostrarOpcoes(filme),
              // Removido o trailing icon button para match com o design da imagem
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarFilme,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildImage(String urlImagem) {
    if (urlImagem.startsWith('http') || urlImagem.startsWith('https')) {
      return Image.network(urlImagem, height: 50, width: 50, fit: BoxFit.cover);
    } else {
      return Icon(
        Icons.image_not_supported,
        size: 50,
        color: Colors.grey,
      );
    }
  }
}
