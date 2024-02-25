import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constant/constant.dart';
import '../../../core/theme/colors/colors.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  Widget _customButton(
    Function()? function,
    String text,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: AppColor.secondary,
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
                color: AppColor.secondary,
                size: 28,
              ),
              sw(10),
              Text(
                text,
                style: const TextStyle(color: AppColor.secondary, fontSize: 23),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,

      /// appbar back button
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Hero(
              tag: l(context).login,
              child: const Padding(
                padding: EdgeInsets.only(left: 20, top: 5),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          if (details.delta.dx > 0) {
            Navigator.pop(context);
          }
        },
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            sh(20),

            /// images transform
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

            /// login setion
            Padding(
              padding: EdgeInsets.only(bottom: dh(context) / 3),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    /// login text section
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    sh(20),

                    /// login button google
                    _customButton(
                      () {
                        // AuthService state =
                        //     Provider.of<AuthService>(context, listen: false);
                        // state.googleSign(context);
                      },
                      'Google',
                      FontAwesomeIcons.google,
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
}
