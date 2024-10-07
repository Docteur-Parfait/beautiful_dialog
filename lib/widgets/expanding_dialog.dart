import 'package:flutter/material.dart';

class ExpandingDialog extends StatefulWidget {
  final String message;

  const ExpandingDialog({super.key, required this.message});

  @override
  ExpandingDialogState createState() => ExpandingDialogState();
}

class ExpandingDialogState extends State<ExpandingDialog>
    with SingleTickerProviderStateMixin {
  double _rotationY = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 60),
      vsync: this,
    );
  }

  void _onEnter(PointerEvent details) {
    if (_controller.status == AnimationStatus.dismissed) {
      // Calculate the rotation based on the cursor position
      _rotationY =
          details.localPosition.dx < 100 ? 0.025 : -0.025; // Small rotation
      _controller.forward();
    }
  }

  void _onExit(PointerEvent details) {
    // Reset rotation
    _rotationY = 0.0;
    _controller.reverse();
  }

  void _onUpdate([DragUpdateDetails? details]) {
    if (_controller.status == AnimationStatus.dismissed) {
      _rotationY = -0.05; //ll rotation
      _controller.forward();
    }else {
      _rotationY = 0.0;
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective effect
            ..rotateY(_rotationY), // Apply scale transformation
          child: Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                  color: Colors.black, style: BorderStyle.solid, width: 4),
            ),
            child:
            GestureDetector(
              onPanUpdate: _onUpdate,
              onTap: _onUpdate,
              child:MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: _onEnter,
                onExit: _onExit,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff878787), Color(0xffe0e0e0)],
                      stops: [0.25, 0.75],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 0, left: 20, right: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 0, left: 25, right: 25),
                    child: SizedBox(
                      width: 280,
                      height: 180,
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "You got it!",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 30)),
                          Text(
                            widget.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 30)),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              backgroundColor: Colors.black,
                              elevation: 0,
                              side: const BorderSide(
                                  color: Colors.white24,
                                  style: BorderStyle.solid,
                                  width: 1),
                            ).copyWith(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Done",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
