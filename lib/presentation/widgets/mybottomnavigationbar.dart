
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:apis/presentation/widgets/mybottomnavigationbaritem.dart';


class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE51F52),
      child: SafeArea(
        child: Row(
          children: [
            MyBottomNavigationItemBar(iconData: Ionicons.home_outline,),
            MyBottomNavigationItemBar(iconData: Ionicons.book_outline,),
            MyBottomNavigationItemBar(iconData: Ionicons.document_outline,),
            MyBottomNavigationItemBar(iconData: Ionicons.cash_outline,),
            MyBottomNavigationItemBar(iconData: Ionicons.person_outline,),
          ],
        ),
      ),
    );
  }
}
