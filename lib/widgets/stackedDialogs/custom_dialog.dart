import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String dialogId;
  final Widget content;
  final VoidCallback onMinimize;

  const CustomDialog({
    super.key,
    required this.dialogId,
    required this.content,
    required this.onMinimize,
  });

  @override
  CustomDialogState createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog> {
  late Offset _position = Offset.infinite;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final screenSize = MediaQuery.of(context).size;
        // Center the offset
        _position = Offset(
          (screenSize.width - 300) / 2,
          (screenSize.height - 300) / 2,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  //update the position
                  _position += details.delta;
                });
              },
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  gradient: const RadialGradient(
                    colors: [Color(0xffffffff), Color(0xfff1efef)],
                    stops: [0.25, 0.75],
                    center: Alignment.center,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                transform: Matrix4.translationValues(1, 0, 0),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dialog ${widget.dialogId}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                          IconButton(
                            icon:
                                const Icon(Icons.minimize, color: Colors.white),
                            onPressed: widget.onMinimize,
                          ),
                        ],
                      ),
                    ),
                    // Content
                    Expanded(child: widget.content),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
