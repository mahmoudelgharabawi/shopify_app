import 'package:flutter/material.dart';

class CategoryItemRowWidget extends StatelessWidget {
  final Color shadowColor;
  final List<Color> gradientColors;
  String? imagePath;
  Widget? iconWidget;
  final String title;
  CategoryItemRowWidget(
      {required this.shadowColor,
      required this.gradientColors,
      this.imagePath,
      this.iconWidget,
      required this.title,
      super.key})
      : assert(imagePath != null || iconWidget != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: shadowColor,
                    offset: const Offset(0, 10),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: gradientColors),
              shape: BoxShape.circle),
          child: Padding(
            padding: EdgeInsets.only(top: imagePath != null ? 10 : 0),
            child: Center(
              child: imagePath != null
                  ? Image.asset(
                      imagePath!,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    )
                  : iconWidget,
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xff515C6F)),
        )
      ],
    );
  }
}
