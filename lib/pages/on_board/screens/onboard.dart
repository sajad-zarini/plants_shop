import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plants_app/core/theme/colors/colors.dart';
import 'package:plants_app/pages/auth/sign_in/sign_in.dart';
import '../../../core/constant/constant.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _lastController;
  late Animation<Offset> _descriptionTranslateAnimation;
  late Animation<Offset> _singInTranslateAnimation;
  late Animation<double> _fadeAnimation;

  Duration duration = const Duration(seconds: 1);

  int currentCarousel = 0;
  bool lastItem = false;

  //Country List
  List<String> animationPlantsList = [
    "assets/animations/3.json",
    "assets/animations/1.json",
    "assets/animations/2.json",
    "assets/animations/4.json",
  ];

  double iconSize = 55;
  double containerSize = 90;

  void _animateResize() {
    iconSize = iconSize == 30 ? 55 : 30;
    containerSize = containerSize == 50 ? 90 : 50;
    lastItem = !lastItem;
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    _lastController = AnimationController(
      vsync: this,
      duration: duration,
    );

    _descriptionTranslateAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0.8),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ),
    );

    _singInTranslateAnimation = Tween<Offset>(
      begin: const Offset(0, 3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _lastController,
        curve: Curves.decelerate,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  void _onIconClick() {
    _controller.reset();

    setState(() {
      if (currentCarousel >= animationPlantsList.length - 1) {
        currentCarousel = 2;
        _animateResize();
      } else {
        currentCarousel += 1;
      }

      if (currentCarousel == animationPlantsList.length - 1) {
        _lastController.reset();
        _lastController.forward();
        _animateResize();
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    List<String> textDescription = [
      l(context).firstOnboard,
      l(context).secondOnboard,
      l(context).thirdOnboard,
      l(context).fourthOnboard,
    ];

    return Scaffold(
      backgroundColor: AppColor.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 15),
            child: TextButton(
              onPressed: () {
                currentCarousel = animationPlantsList.length - 2;
                _onIconClick();
              },
              child: Text(
                l(context).skip,
                style: const TextStyle(
                  color: AppColor.secondary,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// carouselslider
            Padding(
              padding: EdgeInsets.only(top: height * 0.1),
              child: AnimatedSwitcher(
                duration: duration,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Lottie.asset(
                  animationPlantsList[currentCarousel],
                  fit: BoxFit.fill,
                  key: ValueKey<int>(currentCarousel),
                ),
              ),
            ),

            /// dotindicatore
            Padding(
              padding: EdgeInsets.only(top: height * 0.03),
              child: DotsIndicator(
                dotsCount: animationPlantsList.length,
                position: currentCarousel,
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(22.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  activeColor: AppColor.primary,
                  color: const Color(0XFFD2D2D4),
                ),
              ),
            ),

            /// text description
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _descriptionTranslateAnimation,
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 38,
                      ),
                      children: textDescription[currentCarousel]
                          .split(" ")
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final element = entry.value;

                        return TextSpan(
                          text: "$element ",
                          style: TextStyle(
                            fontWeight: index ==
                                    l(context).firstOnboard.split(" ").length -
                                        1
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 90,
              child: Stack(
                children: [
                  /// next item
                  AnimatedPositioned(
                    duration: duration,
                    top: lastItem ? 20 : 0,
                    left: lastItem ? 30 : width * 0.34,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: AnimatedContainer(
                        duration: duration,
                        height: containerSize,
                        child: IconButton(
                          onPressed: _onIconClick,
                          icon: RotationTransition(
                            turns: _controller,
                            child: Icon(
                              lastItem ? Icons.arrow_back : Icons.arrow_forward,
                              size: iconSize,
                              color: Colors.white,
                            ),
                          ),
                          style: IconButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: AppColor.primary,
                            fixedSize: Size(containerSize, containerSize),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// sign up section
                  Visibility(
                    visible: lastItem,
                    child: Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          side: const BorderSide(
                            width: 2,
                            color: AppColor.primary,
                          ),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Text(
                            l(context).signUp,
                            style: const TextStyle(
                              fontSize: 28,
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Visibility(
              visible: lastItem,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _singInTranslateAnimation,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    },
                    child: Hero(
                      tag: l(context).login,
                      child: Text(
                        l(context).alreadyAccount,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColor.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
