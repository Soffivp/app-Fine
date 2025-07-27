import 'package:flutter/material.dart';
import 'package:apis/presentation/widgets/mybottomnavigationbar.dart';
import '../widgets/IngresarDatos.dart';
import 'package:apis/presentation/screens/matricul1.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IngresarDatos(),
        //bottomNavigationBar: MyBottomNavigationBar(),

    );
  }
}
