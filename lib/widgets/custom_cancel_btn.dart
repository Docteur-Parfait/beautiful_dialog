import 'package:flutter/material.dart';

class CustomCancelButon extends StatelessWidget {
  const CustomCancelButon({
    super.key,
    required this.icon,
    required this.bgColor,
    required this.text,
    required this.btnTextColor,
  });
  final IconData icon;
  final Color bgColor;
  final String text;
  final Color btnTextColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color.fromARGB(155, 207, 207, 207)),
          borderRadius: BorderRadius.circular(
            5.0,
          ),
        ),
        backgroundColor: bgColor, // Bouton rouge
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: btnTextColor,
            size: 18,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
              color: btnTextColor,
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.of(context).pop(); // Fermer la boîte
      },
    );
  }
}
