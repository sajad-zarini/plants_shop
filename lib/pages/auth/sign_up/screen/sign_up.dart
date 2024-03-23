import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/theme/colors/colors.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    /// check dark mode or light mode in project
    Color color = AppColor.white;
    Color rcolor = AppColor.white;

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Hero(
              tag: l(context).back,
              child: const Padding(
                padding: EdgeInsets.only(left: 20, top: 5),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.secondary,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            Navigator.pop(context);
          }
        },
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            /// padding top
            sh(20),

            /// images
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Align(
                alignment: Alignment.topCenter,
                child: FadeInLeft(
                  duration: const Duration(seconds: 1),
                  child: FadeInDown(
                    duration: const Duration(seconds: 1),
                    child: Transform.scale(
                      scale: 0.7,
                      child: Image.asset(
                        'assets/images/2.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// icon for singup
            Padding(
              padding: EdgeInsets.only(bottom: dh(context) / 5),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    /// test sign up
                    Text(
                      'Signup',
                      style: TextStyle(color: rcolor, fontSize: 40, fontWeight: FontWeight.bold),
                    ),

                    /// padding gap
                    sh(20),

                    /// custom button for google
                    _customButton(
                      () {
                        /// open google sign in section
                      },
                      'Google',
                      FontAwesomeIcons.google,
                    ),

                    /// custom button for anonym
                    _customButton(
                      () {
                        /// store user id in datastore
                        /// navigate to home page
                      },
                      ' ${l(context).anonym}',
                      FontAwesomeIcons.mask,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customButton(
    Function()? function,
    String text,
    IconData icon,
  ) {
    Color color = AppColor.secondary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: color,
          ),
        ),
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: function,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                color: color,
                size: 28,
              ),
              sw(10),
              Text(
                text,
                style: TextStyle(color: color, fontSize: 23),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
