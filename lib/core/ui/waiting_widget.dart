import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../configurations/assets.dart';

class WaitingWidget extends StatefulWidget {
  const WaitingWidget({Key? key}) : super(key: key);

  @override
  State<WaitingWidget> createState() => _WaitingWidgetState();
}

class _WaitingWidgetState extends State<WaitingWidget> {

  @override
  Widget build(BuildContext context) =>
      Center(
        child: Lottie.asset(Assets.ANIMATED_LOADER,height: 100,width: 100),
      );
}
