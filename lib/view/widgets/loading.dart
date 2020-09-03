import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  List<Widget> spinners = [
    SpinKitWanderingCubes(
      color: Colors.white,
      size: 100.0,
    ),
    SpinKitDoubleBounce(
      color: Colors.white,
      size: 100.0,
    ),
    SpinKitWave(
      color: Colors.white,
      size: 100.0,
    ),
    SpinKitFadingFour(
      color: Colors.white,
      size: 100.0,
    ),
    SpinKitPulse(
      color: Colors.white,
      size: 100.0,
    ),
    SpinKitChasingDots(
      color: Colors.white,
      size: 100.0,
    ),
    SpinKitThreeBounce(
      color: Colors.white,
      size: 100.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff18191b),
      child: Center(
        child: spinners[Random().nextInt(spinners.length)],
      ),
    );
  }
}
