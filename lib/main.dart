import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:apis/presentation/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializacion de firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Login(), // Pantalla inicial
    );
  }
}
