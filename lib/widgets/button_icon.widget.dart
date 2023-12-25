import 'package:flutter/cupertino.dart';

class ButtonIconWidget extends StatelessWidget {
  const ButtonIconWidget(
      {super.key,
      required this.txt,
      required this.con,
      required this.clcon,
      required this.clcont,
      required this.cltxt,
      required this.backcl});
  final String txt;
  final IconData con;
  final Color clcon;
  final Color clcont;
  final Color cltxt;
  final Color backcl;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 8,
      ),
      width: 165,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: backcl,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(15, 114, 124, 142),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: cltxt,
              letterSpacing: 1,
            ),
          ),
          Container(
            width: 29,
            height: 30,
            decoration: BoxDecoration(
              color: clcont,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              con,
              size: 15,
              color: clcon,
            ),
          )
        ],
      ),
    );
  }
}
