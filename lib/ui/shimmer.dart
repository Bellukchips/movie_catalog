import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPlayNow extends StatefulWidget {
  @override
  _ShimmerPlayNowState createState() => _ShimmerPlayNowState();
}

class _ShimmerPlayNowState extends State<ShimmerPlayNow> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 170,
            width: 120,
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
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 170,
            width: 120,
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
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 170,
            width: 120,
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
