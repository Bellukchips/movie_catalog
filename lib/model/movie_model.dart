class MovieModel {
  final int id;
  final String title;
  final String poster_path;
  final String overview;
  final String release_date;
  final double voteAverage;
  final double popularity;
  final String key;
  final OriginalLanguage originalLanguage;
  
  MovieModel({this.id, this.title, this.poster_path, this.overview, this.release_date,this.voteAverage,this.popularity,this.originalLanguage,this.key});

  factory MovieModel.fromJson(Map<String,dynamic> movie)=> MovieModel(
    title:movie['title'],
    id: movie['id'],
    poster_path: movie['poster_path'],
    overview: movie['overview'],
    release_date: movie['release_date'],
    voteAverage: movie['vote_average'].toDouble(),
    popularity: movie['popularity'].toDouble(),
    key: movie['key'],
    originalLanguage: originalLanguageValues.map[movie['original_language']]
    );
}



enum OriginalLanguage { EN, JA }

final originalLanguageValues =
    new EnumValues({"en": OriginalLanguage.EN, "ja": OriginalLanguage.JA});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
