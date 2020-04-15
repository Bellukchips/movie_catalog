import 'dart:convert';
// import 'dart:ui' as prefix0;
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:movie_catalog/api_key/Base_api.dart';
import 'package:movie_catalog/db/db.dart';
import 'package:movie_catalog/model/favorite_model.dart';
import 'package:movie_catalog/model/movie_model.dart';
// import 'package:movie_catalog/model/moviemodelvideo.dart';
// import 'package:movie_catalog/ui/shimmer_similar.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMovie extends StatefulWidget {
  final MovieModel model;
  final VoidCallback reload;

  DetailMovie(this.model, this.reload);

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  var keyPrimer;

  Movie get movie => null;

  Future<void> getVideos() async {
    final respon = await http.get("https://api.themoviedb.org/3/movie/" +
        widget.model.id.toString() +
        "/videos?api_key=ed94c15844d5687a41edbd52b892330d&language=en-US");
    if (respon.statusCode == 200) {
      final resVideo = jsonDecode(respon.body);
      var result = resVideo['results'];
      var a = result[0];
      var key = a["key"];
      setState(() {
        keyPrimer = key;
      });
    } else {
      print("Koneksi gagal");
    }
    print(keyPrimer);
  }

  lauchUrl() async {
    var url = "https://www.youtube.com/watch?v=" + keyPrimer;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future setColor() async {
    var db = DBProvider.provider;
    var res = await db.getMovie(widget.model.id);
    if (res == null) {
      setState(() {
        icon = Icon(
          Icons.favorite_border,
          color: Colors.white,
        );
      });
    } else {
      setState(() {
        icon = Icon(
          Icons.favorite,
          color: Colors.red,
        );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getVideos();
    setColor();
  }

  Future check() async {
    var db = DBProvider.provider;
    var r = await db.getMovie(widget.model.id);
    Movie m = Movie(id: widget.model.id);

    if (r == null) {
      showToast("Double Tap To Add Favorite",
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      db.deleteMovie(m);
      setState(() {
        icon = Icon(
          Icons.favorite_border,
          color: Colors.white,
        );
      });
    }
  }

  bool navBottom = true;
  Future addMovie() async {
    var db = DBProvider.provider;
    var res = await db.getMovie(widget.model.id);
    if (res == null) {
      var save = Movie(
          id: widget.model.id,
          title: widget.model.title,
          path: widget.model.poster_path);
      await db.saveMovie(save);

      showToast("Add To Favorite",
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(() {
        icon = Icon(Icons.favorite, color: Colors.red);
      });
    } else {
      return null;
    }
  }

  Icon icon = Icon(
    Icons.favorite_border,
    color: Colors.white,
  );

  bool fav = false;
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Visibility(
          visible: keyPrimer == null?navBottom = false:navBottom= true,
          child: Container(
            color: Color(0xff2d3447),
            height: 50.0,
            alignment: FractionalOffset.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Watch Trailer " + widget.model.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 8,
                        color: Colors.white),
                  ),
                  InkWell(
                    onTap: lauchUrl,
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: FractionalOffset.center,
                      child: Text(
                        "Watch",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xff2d3447),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 420.0,
                floating: false,
                pinned: true,
                backgroundColor: Color(0xff2d3447),
                flexibleSpace: FlexibleSpaceBar(
                    background: widget.model.poster_path == null
                        ? Image.asset(
                            "img/index.png",
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            BaseApi.img + widget.model.poster_path,
                            fit: BoxFit.cover,
                          )),
              )
            ];
          },
          body: Container(
            color: Color(0xff2d3447),
            padding: EdgeInsets.only(left: 5, right: 5),
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        widget.model.title,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "carter"),
                      ),
                    ),
                    InkWell(
                      onTap: check,
                      onDoubleTap: addMovie,
                      child: icon,
                    )
                  ],
                ),
                Divider(
                  height: 20,
                ),
                Table(
                  textDirection: TextDirection.ltr,
                  defaultColumnWidth: FixedColumnWidth(10.0),
                  children: [
                    _buildTableRow("Title," + widget.model.title + ""),
                    _buildTableRow(
                        "Release Date," + widget.model.release_date + ""),
                    _buildTableRow("Vote Average," +
                        widget.model.voteAverage.toString() +
                        ""),
                    _buildTableRow("Popularity," +
                        widget.model.popularity.toString() +
                        ""),
                    _buildTableRow("Original Language," +
                        widget.model.originalLanguage.toString() +
                        ""),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.model.overview,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

TableRow _buildTableRow(String listOfNames) {
  return TableRow(
    children: listOfNames.split(',').map((name) {
      return Container(
        alignment: Alignment.centerLeft,
        child:
            Text(name, style: TextStyle(fontSize: 15.0, color: Colors.white)),
        padding: EdgeInsets.all(8.0),
      );
    }).toList(),
  );
}

// Widget similiar = Container(
//   child: Similiar(),
// );

// class Similiar extends StatefulWidget {
//   final MovieModel model;

//   Similiar({this.model});
//   @override
//   _SimiliarState createState() => _SimiliarState();
// }

// class _SimiliarState extends State<Similiar> {
//   List<MovieModel> list = [];
//   var loading = false;
//   final GlobalKey<RefreshIndicatorState> _refresh =
//       GlobalKey<RefreshIndicatorState>();
//   Future<void> getSimiliar() async {
//     var respon = await http.get("https://api.themoviedb.org/3/movie/" +
//         widget.model.id.toString() +
//         "/similar?api_key=ed94c15844d5687a41edbd52b892330d&language=en-US");
//     if (respon.statusCode == 200) {
//       var result = jsonDecode(respon.body);
//       var similiar = result['results'];
//       setState(() {
//         for (Map i in similiar) {
//           list.add(MovieModel.fromJson(i));
//           loading = false;
//         }
//       });
//     } else {
//       print("Koneksi gagal");
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getSimiliar();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//         key: _refresh,
//         onRefresh: getSimiliar,
//         child: loading
//             ? ShimmerSimiliar()
//             : ListView.builder(
//                 physics: BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: list.length,
//                 itemBuilder: (context, x) {
//                   var smiliar = list[x];
//                   return Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Color(0xff2d3442),
//                           borderRadius: BorderRadius.circular(10)),
//                       height: 300,
//                       width: 300,
//                       child: Stack(
//                         children: <Widget>[
//                           ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.network(
//                                 BaseApi.img_1 + smiliar.poster_path,
//                                 fit: BoxFit.fill,
//                                 width: 300,
//                               )),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 220),
//                             child: Container(
//                               width: 240,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Color(0xff2d3442),
//                               ),
//                               height: 60,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: <Widget>[
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: <Widget>[
//                                         Text(
//                                           smiliar.title,
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 10,
//                                               fontFamily: "carter"),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: <Widget>[
//                                         FlutterRatingBar(
//                                           initialRating: smiliar.voteAverage,
//                                           itemSize: 12,
//                                           fillColor: Colors.amber,
//                                           borderColor:
//                                               Colors.amber.withAlpha(50),
//                                           onRatingUpdate: (rating) {
//                                             print(rating);
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ));
//   }
// }
