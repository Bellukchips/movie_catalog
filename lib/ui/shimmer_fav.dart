import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFav extends StatefulWidget {
  @override
  _ShimmerFavState createState() => _ShimmerFavState();
}

class _ShimmerFavState extends State<ShimmerFav> {
  @override
  Widget build(BuildContext context) {
    return ListView(scrollDirection: Axis.horizontal, children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 400,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Shimmer.fromColors(
              baseColor: Colors.grey[100],
              highlightColor: Colors.grey[200],
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [Colors.grey[100], Colors.grey[200]],
                        end: Alignment.centerRight,
                        begin: Alignment.centerLeft)),
              )),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 400,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Shimmer.fromColors(
              baseColor: Colors.grey[100],
              highlightColor: Colors.grey[200],
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [Colors.grey[100], Colors.grey[200]],
                        end: Alignment.centerRight,
                        begin: Alignment.centerLeft)),
              )),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 400,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Shimmer.fromColors(
              baseColor: Colors.grey[100],
              highlightColor: Colors.grey[200],
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [Colors.grey[100], Colors.grey[200]],
                        end: Alignment.centerRight,
                        begin: Alignment.centerLeft)),
              )),
        ),
      ),
    ]);
  }
}
