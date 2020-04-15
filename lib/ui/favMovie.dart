import 'package:flutter/material.dart';
import 'package:movie_catalog/api_key/Base_api.dart';
import 'package:movie_catalog/db/db.dart';
import 'package:movie_catalog/model/favorite_model.dart';
import 'package:movie_catalog/ui/shimmer_fav.dart';
import 'package:toast/toast.dart';

class FavoMovie extends StatefulWidget {
  @override
  _FavoMovieState createState() => _FavoMovieState();
}

class _FavoMovieState extends State<FavoMovie> {
  List data;
  bool dow = false;
  getAllData() async {
    this.setState(() {
      dow = true;
    });
    final r = await DBProvider.provider.getAllMovie();
    data = r;
    this.setState(() {
      dow = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Favorite Movie"),
          backgroundColor: Colors.blueAccent,
        ),
        backgroundColor: Color(0xff2d3447),
        body: !dow
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      padding:const EdgeInsets.only(left: 80),
                      color: Colors.red,
                      child: Icon(Icons.delete_forever,size: 100,),
                    ),
                    onDismissed: (direction) {
                      var db = DBProvider.provider;
                      Movie m = Movie(id: data[index]['id']);
                      db.deleteMovie(m);
                      showToast("Deleted From Favorite",
                          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    },
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        child: data[index]['poster_path']==null?
                        Image.asset("img/index.png",fit: BoxFit.fill,)
                        :Image.network(
                          BaseApi.img_1 + data[index]["poster_path"],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              )
            : ShimmerFav());
  }
}
