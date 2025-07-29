class Validators {
  static String? validarTexto(String? value, {String campo = 'Campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$campo obligatorio';
    }
    final regex = RegExp(r"^[a-zA-ZÀ-ÿ\s]+$");
    if (!regex.hasMatch(value.trim())) {
      return '$campo inválido';
    }
    return null;
  }

  static String? validarCorreo(String? value) {
    if (value == null || value.trim().isEmpty) return 'Correo obligatorio';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value.trim())) return 'Correo no válido';
    return null;
  }

  static String? validarNumero(String? value, {String campo = 'Número'}) {
    if (value == null || value.trim().isEmpty) {
      return '$campo obligatorio';
    }
    if (double.tryParse(value.trim()) == null) {
      return '$campo no válido';
    }
    return null;
  }

  static String? validarCedula(String? value) {
    if (value == null || value.trim().isEmpty) return 'Cédula obligatoria';
    if (value.length != 10) return 'La cédula debe tener 10 dígitos';
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) return 'Cédula inválida';
    // Algoritmo simplificado:
    final digits = value.split('').map(int.parse).toList();
    final provinceCode = int.parse(value.substring(0, 2));
    if (provinceCode < 1 || provinceCode > 24) return 'Cédula inválida';

    final verifier = digits.removeLast();
    int sum = 0;
    for (int i = 0; i < digits.length; i++) {
      int mult = (i % 2 == 0) ? 2 : 1;
      int result = digits[i] * mult;
      if (result > 9) result -= 9;
      sum += result;
    }
    final computedDigit = (10 - (sum % 10)) % 10;
    if (computedDigit != verifier) return 'Cédula no válida';
    return null;
  }

  static String? validarRUC(String? value) {
    if (value == null || value.trim().isEmpty) return 'RUC obligatorio';
    if (value.length != 13) return 'El RUC debe tener 13 dígitos';
    if (!RegExp(r'^[0-9]{13}$').hasMatch(value)) return 'RUC inválido';
    if (!value.startsWith(value.substring(0, 10))) return 'RUC no válido';
    return null;
  }

  static String? validarCelular(String? value) {
    if (value == null || value.trim().isEmpty) return 'Celular obligatorio';
    if (!RegExp(r'^09[0-9]{8}$').hasMatch(value)) {
      return 'Número de celular inválido';
    }
    return null;
  }

  static String? validarTelefono(String? value) {
    if (value == null || value.trim().isEmpty) return 'Teléfono obligatorio';
    if (!RegExp(r'^[0-9]{7}$').hasMatch(value)) {
      return 'Teléfono convencional inválido';
    }
    return null;
  }
}
