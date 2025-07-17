import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';


class MyBottomNavigationItemBar extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;

  const MyBottomNavigationItemBar({
    Key? key,
    required this.iconData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            child: Container(
              width: 50,
              height: 50,

              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
