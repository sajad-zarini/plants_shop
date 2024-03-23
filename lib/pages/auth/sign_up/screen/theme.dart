import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plants_app/pages/auth/sign_up/widget/custom_animation_container.dart';
import 'package:plants_app/pages/auth/sign_up/widget/custom_button.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/theme/colors/colors.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> with TickerProviderStateMixin {
  bool isDarkmode = false;
  late AnimationController bounceController;
  late AnimationController zoomController;
  late AnimationController rotateController;

  @override
  void initState() {
    super.initState();
    bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    zoomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,

      /// appbar back button
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Hero(
              tag: l(context).signUp,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: isDarkmode ? AppColor.white : AppColor.secondary,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onHorizontalDragUpdate: (DragUpdateDetails details) => details.delta.dx > 0 ? Navigator.pop(context) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: isDarkmode ? AppColor.secondary : AppColor.white,
          width: dw(context),
          height: dh(context),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(flex: 2),

                  /// light and dark mode selected
                  Container(
                    height: dh(context) / 1.9,
                    width: dw(context) / 1.2,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            CustomAnimationContainer(
                              controller: rotateController,
                              isDarkmode: isDarkmode,
                              val: 0,
                            ),
                            CustomAnimationContainer(
                              controller: rotateController,
                              isDarkmode: isDarkmode,
                              val: 1,
                            ),
                          ],
                        ),
                        sh(40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            /// light theme
                            CustomButton(
                              controller: bounceController.drive(Tween<double>(begin: 1.0, end: 1.1)),
                              function: () {
                                HapticFeedback.mediumImpact();
                                rotateController.forward();

                                Future<void>.delayed(
                                  const Duration(milliseconds: 250),
                                  () {
                                    rotateController.reverse();
                                  },
                                );

                                /// store dark mode
                                setState(() {
                                  isDarkmode = false;
                                });
                                bounceController.forward(from: 0.0);
                              },
                              text: 'Lightmode',
                            ),

                            /// dark theme
                            CustomButton(
                              controller: zoomController.drive(
                                Tween<double>(begin: 1.0, end: 1.1),
                              ),
                              function: () {
                                HapticFeedback.mediumImpact();
                                rotateController.forward();

                                Future<void>.delayed(
                                  const Duration(milliseconds: 400),
                                  () {
                                    rotateController.reverse();
                                  },
                                );
                                
                                /// store light mode
                                
                                setState(
                                  () {
                                    isDarkmode = true;
                                  },
                                );
                                zoomController.forward(from: 0.0);
                              },
                              text: 'Darkmode',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  /// next section button
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 55,
                        color: Colors.white,
                      ),
                      style: IconButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: AppColor.primary,
                        fixedSize: const Size(90, 90),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    rotateController.dispose();
    zoomController.dispose();
    bounceController.dispose();
    super.dispose();
  }
}
