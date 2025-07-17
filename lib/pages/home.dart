import 'package:flutter/material.dart';
import 'package:apis/widgets/mybottomnavigationbar.dart';
import '../widgets/IngresarDatos.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IngresarDatos(),
        //bottomNavigationBar: MyBottomNavigationBar(),

    );
  }
}
