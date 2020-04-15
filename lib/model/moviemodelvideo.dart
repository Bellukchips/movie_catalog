class MovieModelVideo {
  final String id;
  final String key;
  
  MovieModelVideo({this.id,this.key});

  factory MovieModelVideo.fromJson(Map<String,dynamic> movie)=> MovieModelVideo(
    id: movie['id'],
    key: movie['key'],
    );
}