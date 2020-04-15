// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

// final String tableMovie = 'movie';
// final String columnid = '_id';
// final String title = 'title';

// class Movie {
//   int id;
//   String title;
//   bool done;

//   get columnTitle => null;

//   get columnId => null;

//   get columnDone => null;

//   Map<String, dynamic> toMap() {
//     var map = <String, dynamic>{title: title};
//     if (id != null) {
//       map[columnid] = id;
//     }
//     return map;
//   }

//   Movie();
//   Movie.fromMap(Map<String, dynamic> map) {
//     id = map[columnId];
//     title = map[columnTitle];
//   }
// }


// class MovieProvider {
//   Database db;

//   Future open(String path) async {
//     db = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//       await db.execute(
//           '''create table $tableMovie($columnid integer primary key,$title text)''');
//     });
//   }

//   Future<Movie> insert(Movie movie, Set<String> set) async {
//     movie.id = await db.insert(tableMovie, movie.toMap());
//     return movie;
//   }

//   Future<Movie> getMovie(int id) async {
//     List<Map> maps = await db.query(tableMovie,
//         columns: [columnid, title], where: '$columnid = ?', whereArgs: [id]);

//     if (maps.length > 0) {
//       return Movie.fromMap(maps.first);
//     }
//     return null;
//   }

//   Future<int> delete(int id) async {
//     return await db.delete(tableMovie, where: '$columnid = ?', whereArgs: [id]);
//   }

//   Future close() async => db.close();
// }
