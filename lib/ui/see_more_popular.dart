import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_catalog/api_key/Base_api.dart';
import 'package:movie_catalog/model/movie_model.dart';
import 'package:toast/toast.dart';

import 'detail_movie.dart';

class SeeMorePop extends StatefulWidget {
  @override
  _SeeMorePopState createState() => _SeeMorePopState();
}

class _SeeMorePopState extends State<SeeMorePop> {
  // List<Widget> daftarlist = List();
  // var data = [
  //   {
  //     "title": "SAINS",
  //     "img": "img/sains.jpg",
  //     "desc":
  //         "Dunia yang terbangun adalah dunia yang memiliki konsep teknologi dan sains ilmiah yang belum tentu ada di dunia nyata"
  //   },
  //   {
  //     "title": "HOROR",
  //     "img": "img/horor.jpg",
  //     "desc":
  //         "Horor bisa berisi tentang makhluk-makhluk halus yang suka meneror, tapi bisa juga berisi tentang pembunuh berantai yang memberikan kesan ngeri"
  //   },
  //   {
  //     "title": "Fantasi",
  //     "img": "img/fantasi.jpg",
  //     "desc":
  //         "Fantasi adalah sebuah bentuk manifestasi kreativitas tingkat tinggi yang menuntut imajinasi bebas sebebasnya, namun juga tetap logis dan rasional."
  //   },
  //   {
  //     "title": "Romance",
  //     "img": "img/romance.jpg",
  //     "desc":
  //         "Romance konon memiliki ciri khas dimana diksi-diksi yang tertulis di dalamnya terbaca begitu puitis dan romantis sehingga mampu menciptakan suasana heart-warming yang mengakibatkan pembacanya dapat menikmati keindahannya."
  //   },
  //   {
  //     "title": "Fanfiction",
  //     "img": "img/fanfiction.jpg",
  //     "desc":
  //         " Fanfiction bisa berarti “imajinasi fans”. Jadi apabila kau membuat cerita berdasarkan boyband atau film animasi favoritmu, dan masih menggunakan dunia, konsep, karakter dan beberapa aspek cerita aslinya."
  //   },
  //   {
  //     "title": "Humor",
  //     "img": "img/humor.jpg",
  //     "desc":
  //         " Humor lebih menekankan pada unsur jenaka dan bertujuan utama untuk membuat pembaca menjadi tertawa dan terhibur. "
  //   },
  // ];
   
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
    final respon = await http.get(BaseApi.popular);
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
          title: Text("Popular"),
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