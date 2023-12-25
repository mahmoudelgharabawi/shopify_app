import 'dart:ffi';

import 'package:flutter/material.dart';

class SelectedColor extends StatefulWidget {
  final void Function(Color) selectedColorCallBack;
  final List<int> colors;
  const SelectedColor(
      {required this.colors, required this.selectedColorCallBack, super.key});

  @override
  State<SelectedColor> createState() => _SelectedColorState();
}

class _SelectedColorState extends State<SelectedColor> {
  int selectedIndex = -1;
  late List<Color> colors;

  @override
  void initState() {
    colors = widget.colors.map((e) => Color(e)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (selectedIndex == index) {
                  selectedIndex = 0;
                } else {
                  selectedIndex = index;
                }
                widget.selectedColorCallBack.call(colors[selectedIndex]);
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 22),
                child: Container(
                  width: 39,
                  height: 39,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    color: colors[index],
                  ),
                  child: Center(
                    child: selectedIndex == index
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
