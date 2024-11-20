import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;
import '../models/filme.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    String path = join(await getDatabasesPath(), 'filmes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE filmes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            urlImagem TEXT,
            genero TEXT,
            faixaEtaria TEXT,
            duracao INTEGER,
            pontuacao REAL,
            descricao TEXT,
            ano INTEGER
          )
        ''');
      },
    );
  }

  Future<int> inserirFilme(Filme filme) async {
    Database db = await database;
    return await db.insert('filmes', filme.toMap());
  }

  Future<List<Filme>> listarFilmes() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('filmes');
    return List.generate(maps.length, (i) => Filme.fromMap(maps[i]));
  }

  Future<int> atualizarFilme(Filme filme) async {
    Database db = await database;
    return await db.update(
      'filmes',
      filme.toMap(),
      where: 'id = ?',
      whereArgs: [filme.id],
    );
  }

  Future<int> deletarFilme(int id) async {
    Database db = await database;
    return await db.delete(
      'filmes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
