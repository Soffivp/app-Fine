import 'package:flutter/material.dart';
import 'package:apis/presentation/widgets/mybottomnavigationbar.dart';
import '../widgets/IngresarDatos.dart';
import 'package:apis/presentation/screens/datosPers_Estudiantes.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IngresarDatos(),
        //bottomNavigationBar: MyBottomNavigationBar(),

    );
  }
}
