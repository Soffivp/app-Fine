import 'package:flutter/material.dart';
import 'package:apis/domain/entities/estudiante.dart';

class EstudianteProvider with ChangeNotifier {
  Estudiante? _estudiante;

  Estudiante? get estudiante => _estudiante;

  void setEstudiante(Estudiante estudiante) {
    _estudiante = estudiante;
    notifyListeners();
  }

  void limpiar() {
    _estudiante = null;
    notifyListeners();
  }
}
