import 'package:flutter/material.dart';

class SelectedSize extends StatefulWidget {
  final List<dynamic> values;
  final void Function(dynamic) selectedValueCallBack;

  const SelectedSize(
      {required this.values, required this.selectedValueCallBack, super.key});

  @override
  State<SelectedSize> createState() => _SelectedColorState();
}

class _SelectedColorState extends State<SelectedSize> {
  int? selectedIndex;
  late List<dynamic> values;
  @override
  void initState() {
    values = widget.values;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: values.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (selectedIndex == index) {
                  selectedIndex = 0;
                } else {
                  selectedIndex = index;
                }
                widget.selectedValueCallBack.call(values[selectedIndex ?? 0]);
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: 72,
                  height: 39,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffffffff),
                  ),
                  child: Center(
                    child: Text(
                      '${values[index]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: selectedIndex == index
                              ? Color(0xffff6969)
                              : Color(0xff727c8e),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
