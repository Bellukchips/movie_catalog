import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_catalog/path/customPaint.dart';
import 'package:movie_catalog/ui/button_exit.dart';
import 'package:movie_catalog/ui/detail_movie.dart';
import 'package:movie_catalog/ui/favMovie.dart';
import 'package:movie_catalog/ui/more_vert.dart';
import 'package:movie_catalog/ui/result_search.dart';
import 'package:movie_catalog/ui/see_moreUp.dart';
import 'package:movie_catalog/ui/see_more_now.dart';
import 'package:movie_catalog/ui/see_more_popular.dart';
import 'package:movie_catalog/ui/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:movie_catalog/ui/shimmerPopular.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:toast/toast.dart';
import 'api_key/Base_api.dart';
import 'model/movie_model.dart';
import 'package:firebase_admob/firebase_admob.dart';
const String testDevice = "";
void main() {
  runApp(MaterialApp(
    title: "Movie Catalog",
    debugShowCheckedModeBanner: false,
    darkTheme: ThemeData.dark(),
    home: Dashboard(),
  ));
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  double height = 30.0;
  Alignment alignment = FractionalOffset.bottomCenter;
  bool v = false;
  bool pysic = false;
  bool croosIcon = false;
  Icon second = Icon(
    Icons.keyboard_arrow_down,
    color: Colors.deepOrange,
    size: 40,
  );
  Icon frist = Icon(
    Icons.keyboard_arrow_up,
    color: Colors.deepOrange,
    size: 40,
  );
  //admob
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['game','mario']
  );
  BannerAd _bannerAd;
  BannerAd createBannerAd(){
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event){
        print("Banner Ad $event");
      }
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    FirebaseAdMob.instance.initialize(
      appId: BannerAd.testAdUnitId,
    );
    _bannerAd = createBannerAd()..load()..show();
  }

  @override
  dispose() {
    _bannerAd.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  //Fungsi Search

  TextEditingController controller = new TextEditingController();
  List<MovieModel> list = [];

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Are you sure?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: new GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: ButtonNo()),
                  ),
                  new GestureDetector(
                      onTap: () => Navigator.of(context).pop(true),
                      child: ButtonYes()),
                ],
              )
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SwipeDetector(
        onSwipeUp: () {
          if (height == 30.0) {
            setState(() {
              height = 300.0;
              alignment = FractionalOffset.topCenter;

              croosIcon = true;
              v = true;
            });
          }
        },
        onSwipeDown: () {
          setState(() {
            if (height == 300.0) {
              height = 30.0;
              croosIcon = false;
            }
          });
        },
        child: Material(
          elevation: 10,
          child: AnimatedContainer(
            color: Color(0xff2d3447),
            duration: Duration(seconds: 1),
            height: height,
            curve: Curves.easeInOutQuint,
            width: double.infinity,
            child: ListView(
              physics: pysic
                  ? BouncingScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          WillPopScope(
                              onWillPop: _onBackPressed,
                              child: AnimatedCrossFade(
                                  firstChild: frist,
                                  secondChild: second,
                                  crossFadeState: croosIcon
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  duration: Duration(seconds: 1))),
                        ]),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 60),
                      child: Visibility(
                        visible: v,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "UpComing",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "righteous"),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => SeeMoreUpCome()));
                              },
                              child: Container(
                                width: 100,
                                height: 30,
                                alignment: FractionalOffset.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.yellow[600]),
                                child: Text(
                                  "See more",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: "righteous",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Visibility(visible: v, child: upcoming),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // drawer: Drawer(
      //   elevation: 5,
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       UserAccountsDrawerHeader(
      //         decoration: BoxDecoration(color: Color(0xff2d3447)),
      //         currentAccountPicture: CircleAvatar(
      //           backgroundImage: AssetImage("img/ande_lumut.jpg"),
      //         ),
      //         accountName: Text("Muh Lukman Akbar P"),
      //         accountEmail: Text("muhamadlukman937@gmail.com"),
      //       ),
      //       ListTile(
      //         trailing: Icon(
      //           Icons.person_pin,
      //         ),
      //         title: Text(
      //           "Akun",
      //           style: TextStyle(fontSize: 15),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          new PopupMenuButton<String>(
            onSelected: moreAction,
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext i) {
              return Morevert.more.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(choice),
                    ],
                  ),
                );
              }).toList();
            },
          )
        ],
      ),
      backgroundColor: Color(0xff2d3447),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            CustomPaint(
              painter: CustomPaintt(),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Text(
                          "Hello..",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "want to find some movies ?",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 40, bottom: 20, left: 20, right: 20),
                    child: Card(
                      color: Colors.blue[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: controller,
                          style: TextStyle(color: Colors.blueGrey),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ResultSearch(controller.text)));
                                },
                              ),
                              fillColor: Colors.white,
                              hintText: "Search movie here",
                              hintStyle:
                                  TextStyle(fontSize: 13, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Now Playing",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontSize: 20),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => ShowMoreNow()));
                          },
                          child: Text(
                            "See All",
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1,
                                fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 5, right: 5),
              child: listCategory,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Popular",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => SeeMorePop()));
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                          color: Colors.white, letterSpacing: 1, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 5, right: 5),
              child: popular,
            ),
          ],
        ),
      ),
    );
  }

  void moreAction(String more) {
    if (more == Morevert.Favorite) {
      Navigator.push(context, MaterialPageRoute(builder: (a) => FavoMovie()));
    }
  }
}

Widget listCategory = Container(
  height: 240,
  child: Container(
    child: CategoryCard(),
  ),
);

class CategoryCard extends StatefulWidget {
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
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
      showToast("Connection Failed",
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
    return RefreshIndicator(
        key: _refresh,
        onRefresh: ambildata,
        child: loading
            ? ShimmerPlayNow()
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff2d3447),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DetailMovie(x, ambildata)));
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  BaseApi.img + x.poster_path,
                                  fit: BoxFit.fitHeight,
                                  // height: 180,
                                  // width: 120,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new Container(
                                        padding:
                                            new EdgeInsets.only(right: 13.0),
                                        child: new Text(
                                          x.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: new TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'Roboto',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    FlutterRatingBar(
                                      initialRating: x.voteAverage,
                                      itemSize: 12,
                                      fillColor: Colors.amber,
                                      borderColor: Colors.amber.withAlpha(50),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ));
  }
}

Widget popular = Container(
  child: Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 20),
    child:
        Container(height: 300, child: Stack(children: <Widget>[PopularCard()])),
  ),
);

class PopularCard extends StatefulWidget {
  @override
  _PopularCardState createState() => _PopularCardState();
}

class _PopularCardState extends State<PopularCard> {
  List<MovieModel> list = [];
  var loading = false;
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  Future<void> ambildataPopular() async {
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
      print("koneksi gagal");
    }
  }

  var height = 150.0;

  @override
  void initState() {
    ambildataPopular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _refresh,
        onRefresh: ambildataPopular,
        child: loading
            ? ShimmerPopular()
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final pop = list[i];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (a) =>
                                    DetailMovie(pop, ambildataPopular)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff2d3442),
                            borderRadius: BorderRadius.circular(10)),
                        height: 300,
                        width: 300,
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  BaseApi.img_1 + pop.poster_path,
                                  fit: BoxFit.fill,
                                  width: 300,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 220),
                              child: Container(
                                width: 240,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff2d3442),
                                ),
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            pop.title,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontFamily: "carter"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          FlutterRatingBar(
                                            initialRating: pop.voteAverage,
                                            itemSize: 12,
                                            fillColor: Colors.amber,
                                            borderColor:
                                                Colors.amber.withAlpha(50),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}

Widget upcoming = Container(
  child: Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 20),
    child: Container(
        height: 160, child: Stack(children: <Widget>[RecomenMovie()])),
  ),
);

class RecomenMovie extends StatefulWidget {
  @override
  _RecomenMovieState createState() => _RecomenMovieState();
}

class _RecomenMovieState extends State<RecomenMovie> {
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
    final respon = await http.get(BaseApi.upcoming);
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
      print("koneksi gagal");
    }
  }

  @override
  void initState() {
    ambildata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _refresh,
        onRefresh: ambildata,
        child: loading
            ? ShimmerPlayNow()
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final a = list[i];
                  return Container(
                    height: 150,
                    width: 130,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailMovie(a, ambildata)));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(10)),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                BaseApi.img + a.poster_path,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                    ),
                  );
                },
              ));
  }
}
