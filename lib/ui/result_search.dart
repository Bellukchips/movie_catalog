import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_catalog/api_key/Base_api.dart';
import 'package:movie_catalog/model/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_catalog/ui/detail_movie.dart';

class ResultSearch extends StatefulWidget {
  final String search;

  ResultSearch(this.search);

  @override
  _ResultSearchState createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  
  var loading = false;
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  List<MovieModel> list = [];

  Future<void> searchMovie() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final res = await http.get(
        "https://api.themoviedb.org/3/search/movie?api_key=ed94c15844d5687a41edbd52b892330d&language=en-US&query=" +
            widget.search +
            "&page=1&include_adult=false");
    if (res.statusCode == 200) {
      var h = jsonDecode(res.body);
      var search = h['results'];
      setState(() {
        for (Map i in search) {
          list.add(MovieModel.fromJson(i));
          loading = false;
        }
      });
    } else {
      print("koneksi gagal");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchMovie();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Result Search"),
        ),
        backgroundColor: Color(0xff2d3447),
        body: RefreshIndicator(
            onRefresh: searchMovie,
            key: _refresh,
            child: Center(
                child: loading
                    ? CircularProgressIndicator()
                    : StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: list.length,
                        mainAxisSpacing: 3,
                        scrollDirection: Axis.vertical,
                        crossAxisSpacing: 2,
                        itemBuilder: (BuildContext context, i) {
                          var s = list[i];
                          // ignore: unused_element

                          // if (s.poster_path == null) {
                          //   Image.asset(
                          //     "img/index.png",
                          //     fit: BoxFit.fill,
                          //   );
                          // } else {
                          //   Image.network(
                          //     BaseApi.img + s.poster_path,
                          //     fit: BoxFit.fill,
                          //   );
                          // }

                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (a) => DetailMovie(s, searchMovie)
                                
                              ));
                              print(s.id);
                              print(s.title);
                              print(s.poster_path);
                              print(s.overview);
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: s.poster_path == null
                                        ? Image.asset(
                                            "img/index.png",
                                            fit: BoxFit.fill,
                                          )
                                        : Image.network(
                                            BaseApi.img + s.poster_path,
                                            fit: BoxFit.cover,
                                          ))),
                          );
                        },
                        staggeredTileBuilder: (index) =>
                            StaggeredTile.count(2, 3),
                      ))));
  }
}
