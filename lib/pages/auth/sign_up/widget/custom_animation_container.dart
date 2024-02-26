import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/theme/colors/colors.dart';

class CustomAnimationContainer extends StatelessWidget {
  final AnimationController controller;
  final bool isDarkmode;
  final int val;

  const CustomAnimationContainer({
    super.key,
    required this.controller,
    required this.isDarkmode,
    required this.val,
  });

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween<double>(begin: 0, end: isDarkmode ? -0.03 : 0.03).animate(
        CurvedAnimation(
          curve: Curves.easeOut,
          parent: controller,
        ),
      ),
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: isDarkmode ? -0.02 * controller.value : 0.02 * controller.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 280,
              width: dw(context) / 3.2,
              decoration: BoxDecoration(
                color: val == 1 ? AppColor.secondary : AppColor.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: StaggeredGridView.countBuilder(
                physics: const NeverScrollableScrollPhysics(),
                staggeredTileBuilder: (int index) => const StaggeredTile.count(1, 1.51),
                crossAxisCount: 2,
                padding: const EdgeInsets.only(left: 10, right: 10),
                itemCount: 6,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemBuilder: (BuildContext context, int index) {
                  if (index % 2 == 0) {
                    return FadeInUp(
                      duration: const Duration(seconds: 1),
                      child: Transform.translate(
                        offset: const Offset(0.0, 15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: val == 0 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return FadeInDown(
                      duration: const Duration(seconds: 1),
                      child: Transform.translate(
                        offset: const Offset(0.0, 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(color: val == 0 ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
