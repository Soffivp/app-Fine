class Credenciales {
  final String usuario;
  final String contrasena;

  Credenciales({
    required this.usuario,
    required this.contrasena,
  });

  Map<String, dynamic> toJson() {
    return {
      'usuario': usuario,
      'contrasena': contrasena,
    };
  }
}
