import '../database/database_helper.dart';
import '../models/filme.dart';

class FilmeController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Filme>> listarFilmes() async {
    return await _dbHelper.listarFilmes();
  }

  Future<void> adicionarFilme(Filme filme) async {
    await _dbHelper.inserirFilme(filme);
  }

  Future<void> atualizarFilme(Filme filme) async {
    await _dbHelper.atualizarFilme(filme);
  }

  Future<void> deletarFilme(int id) async {
    await _dbHelper.deletarFilme(id);
  }
}
