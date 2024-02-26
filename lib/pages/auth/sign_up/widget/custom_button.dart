import 'package:flutter/material.dart';

import '../../../../core/theme/colors/colors.dart';

class CustomButton extends StatelessWidget {
  final Animation<double> controller;
  final Function()? function;
  final String text;

  const CustomButton({
    super.key,
    required this.controller,
    this.function,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: controller,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: AppColor.white,
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
          child: Text(
            text,
            style: TextStyle(color: AppColor.white),
          ),
        ),
      ),
    );
  }
}