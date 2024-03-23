import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/theme/colors/colors.dart';
import 'theme.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// check keyboard open
    FocusScopeNode currentFocus = FocusScope.of(context);

    return Scaffold(
      backgroundColor: AppColor.white,

      /// appbar back button
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            !currentFocus.hasPrimaryFocus ? currentFocus.unfocus() : Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Hero(
              tag: l(context).signUp,
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
            !currentFocus.hasPrimaryFocus ? currentFocus.unfocus() : Navigator.pop(context);
          }
        },
        onTap: () {
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: dh(context),
            child: Column(
              children: <Widget>[
                sh(dh(context) / 13),

                /// images transform
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: FadeInRight(
                      duration: const Duration(seconds: 1),
                      child: FadeInUp(
                        duration: const Duration(seconds: 1),
                        child: Transform.scale(
                          scale: 0.7,
                          child: Image.asset(
                            'assets/images/name.png',
                            height: dh(context) / 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// name text field
                FadeInRight(
                  duration: const Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: TextField(
                      cursorColor: Colors.blue,
                      cursorHeight: 70,
                      textAlign: TextAlign.center,
                      keyboardAppearance: Brightness.dark,
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: l(context).name,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 70,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 70,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                /// login setion
                IconButton(
                  onPressed: _nameController.text.isEmpty
                      ? null
                      : () {
                          /// store name
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => ThemePage(key: widget.key)),
                          );
                        },
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 55,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: AppColor.primary,
                    fixedSize: const Size(90, 90),
                    disabledBackgroundColor: AppColor.lightGrey,
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
