import 'dart:convert';

Movie movieFromJson(String str) {
  final jsonData = json.decode(str);
  return Movie.fromJson(jsonData);
}

String movieToJson(Movie data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Movie {
  int id;
  String title;
  String path;

  toMap_2(List<Map<String, dynamic>> m) {
    print(m);
    List<Movie> map = [];
    for (var i = 0; i < m.length; i++) {
      map.add(Movie(
          id: m[i]['id'], 
          path: m[i]['path'],
           title: m[i]['title']));
    }

    return map;
  }

  Movie.fromMap(Map first);
  int get _id => id;
  String get _title => title;
  String get _path => path;

  Movie({this.id, this.title, this.path});

  factory Movie.fromJson(Map<String, dynamic> json) => new Movie(
      id: json['id'], title: json['title'], path: json['poster_path']);
  Map<String, dynamic> toJson() =>
      {"id": id, "title": title, "poster_path": path};
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['poster_path'] = path;
    return map;
  }
}
