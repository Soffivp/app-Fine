import 'package:cloud_firestore/cloud_firestore.dart';

class Pago {
  final String referencia;
  final double monto;
  final String fechaDeposito;
  final String idDeposita;
  final String cuentaBancaria;

  Pago({
    required this.referencia,
    required this.monto,
    required this.fechaDeposito,
    required this.idDeposita,
    required this.cuentaBancaria,
  });

  Map<String, dynamic> toJson() => {
    'referencia': referencia,
    'monto': monto,
    'fechaDeposito': fechaDeposito,
    'idDeposita': idDeposita,
    'cuentaBancaria': cuentaBancaria,
    'fechaRegistro': FieldValue.serverTimestamp(),
  };
}
