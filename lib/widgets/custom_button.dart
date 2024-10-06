import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key, this.onTap, required this.text, required this.author});

  final String text;

  final String author;

  final void Function()? onTap;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false; // Variable pour savoir si la carte est survolée

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        // Widget pour détecter les événements de la souris
        onEnter: (_) => _onHover(true), // Lorsque la souris entre dans la zone
        onExit: (_) => _onHover(false), // Lorsque la souris sort de la zone
        cursor: SystemMouseCursors.click, // Changer le curseur en main
        child: Container(
          margin: const EdgeInsets.all(8),
          width: 200,
          height: 130,
          child: AnimatedContainer(
            // AnimatedContainer pour ajouter une animation
            duration: const Duration(milliseconds: 300), // Durée de l'animation
            curve: Curves.easeInOut, // Courbe d'animation
            decoration: BoxDecoration(
              color: _isHovered
                  ? Colors.green // Couleur au survol
                  : Colors.white, // Couleur par défaut
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: const Color.fromARGB(85, 190, 190, 190), width: 0.4),
            ),
            child: Card(
              elevation: _isHovered ? 10 : 5, // Élévation animée au survol
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "By ${widget.author}",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Fonction pour gérer le changement de survol
  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}
