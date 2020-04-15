import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSimiliar extends StatefulWidget {
  @override
  _ShimmerSimiliarState createState() => _ShimmerSimiliarState();
}

class _ShimmerSimiliarState extends State<ShimmerSimiliar> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Container(
         height: 100,
                      width: 300,
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
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Container(
            height: 100,
                      width: 300,
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
      ],
    );
  }
}