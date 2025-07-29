import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';
import 'package:apis/presentation/screens/login.dart';
import 'package:apis/infrastructure/firestore/firebase_service.dart';
import 'package:apis/domain/use_cases/guardar_registro_use_case.dart';
import 'package:apis/presentation/providers/registro_provider.dart';
import 'package:apis/config/router/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RegistroProvider(
            GuardarRegistroUseCase(FirebaseService()),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mi App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/login',
        routes: AppRoutes.routes,
      ),
    );
  }
}
