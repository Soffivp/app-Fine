import 'package:flutter/material.dart';
import 'package:apis/presentation/screens/login.dart';
import 'package:apis/presentation/screens/matricul1.dart';
import 'package:apis/presentation/screens/home.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: backgroundColor),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String label;
  final String value;
  final bool obscureText;

  const CustomInputField({
    Key? key,
    required this.label,
    required this.value,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
            ),
          ),
          child: Text(
            obscureText ? '••••••' : value,
            style: TextStyle(
              color: obscureText ? Colors.black : Color(0xFFA2A1A1),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class OlvideContra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFF186BDF),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Olvidé mi contraseña »',
            style: TextStyle(
              color: const Color(0xFF186BDF),
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class IngresarDatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 785,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 113,
                top: 145,

                child: Image.asset('assets/images/logo.png',
                  width: 134,
                  height: 117,)

              ),
              Positioned(
                left: 40,
                top: 330,
                child: SizedBox(
                  width: 280,
                  child: CustomInputField(
                    label: 'Usuario',
                    value: 'nahomi123',
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 409,
                child: SizedBox(
                  width: 280,
                  child: CustomInputField(
                    label: 'Contraseña',
                    value: '',
                    obscureText: true,
                  ),
                ),
              ),
              Positioned(
                left: 44,
                top: 488,
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE51F52),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Recordarme',
                      style: TextStyle(
                        color: Color(0xFF213354),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 16),
                    OlvideContra(),
                  ],
                ),
              ),
              Positioned(
                left: 60,
                top: 547,
                child: SizedBox(
                  width: 260,
                  child: Row(
                    children: [
                      CustomButton(
                        text: 'Matricular',
                        backgroundColor: Color(0xFF213354),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MatricularEstudianteForm1()),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      CustomButton(
                        text: 'Ingresar',
                        backgroundColor: Color(0xFFE51F52),
                        textColor: Color(0xFFF5F5F5),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
