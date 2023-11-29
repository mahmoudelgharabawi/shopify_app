import 'package:flutter/material.dart';
import 'package:shopify_app/utils/colors.util.dart';

class AppBarEx {
  static PreferredSizeWidget get getAppBar => AppBar(
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/Messages.png')
                  //  Transform.flip(
                  //   flipX: true,
                  //   child: Icon(
                  //     Icons.chat_bubble_outline,
                  //     color: ColorsUtil.iconColor,
                  //   ),
                  // ),
                  ),
              Positioned(
                  bottom: 6,
                  child: Badge(
                    backgroundColor: ColorsUtil.badgeColor,
                    label: Text('5'),
                  ))
            ],
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_outlined,
                  color: ColorsUtil.iconColor,
                ),
              ),
              Positioned(
                  bottom: 6,
                  child: Badge(
                    backgroundColor: ColorsUtil.badgeColor,
                    label: Text('5'),
                  ))
            ],
          ),
        ],
      );
}
