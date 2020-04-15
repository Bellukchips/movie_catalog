import 'dart:io' as io;
import 'dart:async';
import 'package:movie_catalog/model/favorite_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider provider = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "movie");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int v) async {
    await db.execute(
        "CREATE TABLE movie(id integer primary key,title text,poster_path text)");
    print("db create");
  }

  newMovie(Movie newMovie) async {
    final db = await database;
    var res = await db.rawInsert("INSERT Into movie (id,title,path)"
        " VALUES (${newMovie.id},${newMovie.title},${newMovie.path})");
    return res;
  }

Future<List> getAllMovie() async {
  final db = await database;
  var res = await db.query("movie");
  print(res);
  return res;
 
}

  Future<Movie> getMovie(int id) async {
    final db = await database;
    List<Map> results = await db.query("movie",
        columns: ["id"], where: 'id = ?', whereArgs: [id]);

    if (results.length > 0) {
      return new Movie.fromMap(results.first);
    }

    return null;
  }

 Future<void> deleteMovie(Movie movie) async {
  // Get a reference to the database.
  final db = await database;

  // Remove the Dog from the Database.
  await db.delete(
    'movie',
    // Use a `where` clause to delete a specific dog.
    where: "id = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [movie.id],
  );
}


  deleteAll() async {
    final db = await database;
    db.rawDelete("delete from movie");
  }

  Future<int> saveMovie(Movie movie) async {
    final db = await database;
    var result = await db.insert("movie", movie.toMap());
    return result;
  }
  
}
