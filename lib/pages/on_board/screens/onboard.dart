import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/core/theme/colors/colors.dart';
import 'package:plants_app/pages/on_board/widgets/bottom_navigation_bottom.dart';
import '../../../core/constant/constant.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> onBoardList(BuildContext context) =>
      <Map<String, dynamic>>[
        <String, dynamic>{
          "image": "1.json",
          "text": l(context).firstOnboard,
        },
        <String, dynamic>{
          "image": "1.json",
          "text": l(context).secondOnboard,
        },
        <String, dynamic>{
          "image": "1.json",
          "text": l(context).thirdOnboard,
        },
        <String, dynamic>{
          "image": "1.json",
          "text": l(context).thirdOnboard,
        },
      ];

  int counter = 0;
  final CarouselController _carouselController = CarouselController();
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 700),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              debugger(message: "click here");
            },
            child: Text(
              l(context).skip,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationButton(
        current: counter,
        carouselController: _carouselController,
        controller: animationController,
      ),
    );
  }
}
