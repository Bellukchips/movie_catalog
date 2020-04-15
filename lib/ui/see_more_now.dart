import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_catalog/api_key/Base_api.dart';
import 'package:movie_catalog/model/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_catalog/ui/detail_movie.dart';
import 'package:toast/toast.dart';

class ShowMoreNow extends StatefulWidget { 
  @override
  _ShowMoreNowState createState() => _ShowMoreNowState();
}

class _ShowMoreNowState extends State<ShowMoreNow> {
  
  List<MovieModel> list = [];
  var loading = false;
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  Future<void> ambildata() async {
    //
    //cek koneksi
    list.clear();
    setState(() {
      loading = true;
    });
    final respon = await http.get(BaseApi.nowPlay);
    if (respon.statusCode == 200 || respon.statusCode == 350) {
      final data = jsonDecode(respon.body);
      var data2 = data['results'];
      setState(() {
        for (Map i in data2) {
          list.add(MovieModel.fromJson(i));
          loading = false;
        }
      });
    } else {
      showToast("Connection Failed",duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
    }
  }

  @override
  void initState() {
    ambildata();
    super.initState();
  }
void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Now Playing"),
        ),
        backgroundColor: Color(0xff2d3447),
        body: RefreshIndicator(
            onRefresh: ambildata,
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
                                builder: (a) => DetailMovie(s, ambildata)
                                
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
